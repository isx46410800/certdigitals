#! /bin/bash
# Install ldapserver tls/ssl

rm -rf /etc/openldap/slapd.d/*
rm -rf /var/lib/ldap/*

mkdir /var/lib/ldap.edt.org

cp /opt/docker/ca.conf /etc/openldap/certs/.
cp /opt/docker/ca-crt.pem /etc/openldap/certs/.
cp /opt/docker/ca-key.pem /etc/openldap/certs/.
cp /opt/docker/ca-crt.srl /etc/openldap/certs/.
cp /opt/docker/server-crt.pem /etc/openldap/certs/.
cp /opt/docker/server-csr.pem /etc/openldap/certs/.
cp /opt/docker/server-key.pem /etc/openldap/certs/.

cp /opt/docker/DB_CONFIG /var/lib/ldap/. 
slaptest -f /opt/docker/slapd.conf -F /etc/openldap/slapd.d
slapadd -F /etc/openldap/slapd.d -l /opt/docker/edt.org.ldif
chown -R ldap.ldap /etc/openldap/slapd.d
chown -R ldap.ldap /var/lib/ldap
cp /opt/docker/ldap.conf /etc/openldap/.
