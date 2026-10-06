#!/usr/bin/env bash
# Creates a private Certificate Authority and a server certificate for Postgres.
#
# Usage:
#   ./generate-certs.sh                       # auto-detects this VM's public IP
#   ./generate-certs.sh 65.0.179.11           # specific IP
#   ./generate-certs.sh 65.0.179.11 db.example.com   # IP and/or domain names
#
# Every IP/domain clients will use to connect MUST be listed, otherwise
# sslmode=verify-full fails with a hostname mismatch.
set -euo pipefail

cd "$(dirname "$0")"
CERT_DIR="certs"
CA_DAYS=3650      # CA valid ~10 years
SERVER_DAYS=825   # server cert valid ~2.25 years

if [[ -f "$CERT_DIR/server.crt" && "${FORCE:-0}" != "1" ]]; then
  echo "Certificates already exist in $CERT_DIR/." >&2
  echo "To regenerate them, run:  FORCE=1 ./generate-certs.sh ..." >&2
  echo "(Clients will then need the new ca.crt.)" >&2
  exit 1
fi

command -v openssl >/dev/null || { sudo apt-get update && sudo apt-get install -y openssl; }

hosts=("$@")
if [[ ${#hosts[@]} -eq 0 ]]; then
  echo "==> No address given, detecting this machine's public IP"
  public_ip=$(curl -fsS --max-time 5 https://checkip.amazonaws.com | tr -d '[:space:]' || true)
  if [[ -z "$public_ip" ]]; then
    echo "Could not detect the public IP. Pass it explicitly: ./generate-certs.sh <ip-or-domain>" >&2
    exit 1
  fi
  echo "    detected: $public_ip"
  read -rp "Use $public_ip in the certificate? [Y/n] " ans
  [[ "${ans:-Y}" =~ ^[Yy]$ ]] || { echo "Aborted. Pass the address explicitly."; exit 1; }
  hosts=("$public_ip")
fi

# Build subjectAltName: given hosts + local names used for testing and
# for other containers in the same compose project (service name "postgres").
san=""
add_san() {
  local h="$1"
  if [[ "$h" =~ ^[0-9]{1,3}(\.[0-9]{1,3}){3}$ || "$h" == *:* ]]; then
    san+="IP:$h,"
  else
    san+="DNS:$h,"
  fi
}
for h in "${hosts[@]}"; do add_san "$h"; done
for h in localhost 127.0.0.1 postgres; do add_san "$h"; done
san="${san%,}"

primary="${hosts[0]}"
echo "==> Certificate will be valid for: ${san//,/, }"

mkdir -p "$CERT_DIR"
umask 077

echo "==> Creating Certificate Authority"
openssl req -new -x509 -days "$CA_DAYS" -nodes \
  -newkey rsa:4096 \
  -keyout "$CERT_DIR/ca.key" -out "$CERT_DIR/ca.crt" \
  -subj "/CN=breachsphire-postgres-ca" 2>/dev/null

echo "==> Creating server key and signing request"
openssl req -new -nodes \
  -newkey rsa:2048 \
  -keyout "$CERT_DIR/server.key" -out "$CERT_DIR/server.csr" \
  -subj "/CN=$primary" 2>/dev/null

cat > "$CERT_DIR/server.ext" <<EOF
basicConstraints = CA:FALSE
keyUsage = digitalSignature, keyEncipherment
extendedKeyUsage = serverAuth
subjectAltName = $san
EOF

echo "==> Signing server certificate with the CA"
openssl x509 -req -in "$CERT_DIR/server.csr" \
  -CA "$CERT_DIR/ca.crt" -CAkey "$CERT_DIR/ca.key" -CAcreateserial \
  -days "$SERVER_DAYS" -sha256 \
  -out "$CERT_DIR/server.crt" -extfile "$CERT_DIR/server.ext" 2>/dev/null

rm -f "$CERT_DIR/server.csr"

chmod 600 "$CERT_DIR/ca.key" "$CERT_DIR/server.key"
chmod 644 "$CERT_DIR/ca.crt" "$CERT_DIR/server.crt"

echo "==> Verifying"
openssl verify -CAfile "$CERT_DIR/ca.crt" "$CERT_DIR/server.crt"
echo "    expires: $(openssl x509 -enddate -noout -in "$CERT_DIR/server.crt" | cut -d= -f2)"

cat <<EOF

Certificates created in $CERT_DIR/:
  ca.crt      -> give this to clients (your laptop, your app)
  ca.key      -> SECRET. Can sign trusted certs. Move it off this server (see below)
  server.crt  -> used by Postgres
  server.key  -> used by Postgres (secret, stays on this server)

Next, from your LOCAL machine, download the CA files:
  scp <your-vm>:$(pwd)/$CERT_DIR/ca.crt .
  scp <your-vm>:$(pwd)/$CERT_DIR/ca.key .

Then delete the CA key from this server:
  rm $(pwd)/$CERT_DIR/ca.key

Keep ca.key somewhere safe; you need it to renew the server certificate.

Then run:  ./setup.sh
EOF
