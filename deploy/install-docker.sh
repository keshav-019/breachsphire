#!/usr/bin/env bash
# Installs Docker Engine + the Compose plugin from Docker's official
# repository on Ubuntu, and lets the current user run docker without sudo.
set -euo pipefail

if [[ $EUID -eq 0 ]]; then
  echo "Run this as your normal user (e.g. ubuntu), not root. It uses sudo where needed." >&2
  exit 1
fi

. /etc/os-release
if [[ "${ID:-}" != "ubuntu" ]]; then
  echo "This script is for Ubuntu. Detected: ${PRETTY_NAME:-unknown}" >&2
  exit 1
fi
echo "==> Detected ${PRETTY_NAME}"

echo "==> Updating system packages"
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

echo "==> Removing unofficial/conflicting Docker packages (if any)"
conflicts=$(dpkg --get-selections docker.io docker-compose docker-compose-v2 docker-doc docker-buildx podman-docker containerd runc 2>/dev/null | cut -f1 || true)
if [[ -n "$conflicts" ]]; then
  sudo apt-get remove -y $conflicts
else
  echo "    none found"
fi

echo "==> Adding Docker's official apt repository"
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

sudo tee /etc/apt/sources.list.d/docker.sources >/dev/null <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: ${UBUNTU_CODENAME:-$VERSION_CODENAME}
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt-get update

echo "==> Installing Docker Engine and Compose plugin"
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "==> Enabling Docker on boot"
sudo systemctl enable --now docker containerd

echo "==> Adding $USER to the docker group"
sudo usermod -aG docker "$USER"

echo "==> Verifying"
sudo docker --version
sudo docker compose version
sudo docker run --rm hello-world >/dev/null && echo "    hello-world ran successfully"

cat <<EOF

Docker is installed.

IMPORTANT: log out and SSH back in so you can run docker without sudo:
    exit
    ssh <your-vm>

Then run:  ./generate-certs.sh
EOF

if [[ -f /var/run/reboot-required ]]; then
  echo
  echo "NOTE: the system says a reboot is required (sudo reboot). Do that before continuing."
fi
