# ldapserver
FROM fedora:27
LABEL version="1.0"
LABEL author="Miguel Amorós"
LABEL subject="ldapserver tls/ssl"
RUN dnf install -y openldap-servers openldap-clients openssl vim procps tree
RUN mkdir /opt/docker
COPY * /opt/docker/
RUN chmod +x /opt/docker/startup.sh
WORKDIR /opt/docker
CMD /opt/docker/startup.sh
