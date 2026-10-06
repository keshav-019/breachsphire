# PostgreSQL 18 with SSL enabled and enforced.
# Certificates are created by ./generate-certs.sh before building.
FROM postgres:18

# Copy only what the server needs. The key must be owned by postgres
# and not readable by anyone else, or Postgres refuses to start.
COPY --chown=postgres:postgres certs/server.crt certs/server.key certs/ca.crt /etc/postgresql/ssl/
COPY --chown=postgres:postgres pg_hba.conf /etc/postgresql/pg_hba.conf

RUN chmod 600 /etc/postgresql/ssl/server.key \
 && chmod 644 /etc/postgresql/ssl/server.crt /etc/postgresql/ssl/ca.crt /etc/postgresql/pg_hba.conf

CMD ["postgres", \
     "-c", "ssl=on", \
     "-c", "ssl_cert_file=/etc/postgresql/ssl/server.crt", \
     "-c", "ssl_key_file=/etc/postgresql/ssl/server.key", \
     "-c", "ssl_ca_file=/etc/postgresql/ssl/ca.crt", \
     "-c", "ssl_min_protocol_version=TLSv1.2", \
     "-c", "password_encryption=scram-sha-256", \
     "-c", "hba_file=/etc/postgresql/pg_hba.conf"]
