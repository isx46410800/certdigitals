# EJEMPLOS 3 Y 4 DE OPENVPN CON CERTIFICADOS PROPIOS

## Partimos con que ya tenemos generados los certificados y key de la CA `Veritat Absoluta`
```
[isx46410800@miguel openvpn:aws]$ ll
-rw-rw-r--. 1 isx46410800 isx46410800      83 Apr 11 23:24 ca.conf
-rw-rw-r--. 1 isx46410800 isx46410800    1164 Apr 11 23:14 ca-crt.pem
-rw-rw-r--. 1 isx46410800 isx46410800      17 Apr 11 23:24 ca-crt.srl
-rw-------. 1 isx46410800 isx46410800     887 Apr 11 23:06 ca-key.pem
```
## Ficheros de extensiones y openssl.cnf
+ A la hora de crear manualmente las keys y los certificados se han de tener en cuenta las extensiones pertinentes tanto para el servidor como para el cliente.

+ `ext.server.conf`
```
basicConstraints       = CA:FALSE
nsCertType             = server
nsComment              = "OpenSSL Generated Server Certificate"
subjectKeyIdentifier   = hash
authorityKeyIdentifier = keyid,issuer:always
extendedKeyUsage       = serverAuth
keyUsage = digitalSignature, keyEncipherment
```

+ `ext.client.conf`
```
basicConstraints        = CA:FALSE
subjectKeyIdentifier    = hash
authorityKeyIdentifier = keyid,issuer:always
```

## Creamos la clave privada y certificado del servidor
`[isx46410800@miguel openvpn:aws]$ openssl genrsa -out serverkey-vpn.pem`

![](capturas/foto_1.png)

`[isx46410800@miguel openvpn:aws]$ openssl req -new -key serverkey-vpn.pem -out serverreq-vpn.pem`

![](capturas/foto_2.png)

`[isx46410800@miguel openvpn:aws]$ openssl x509 -CAkey ca-key.pem -CA ca-crt.pem -req -in serverreq-vpn.pem -days 3650 -CAcreateserial -extfile ext.server.conf -out servercrt-vpn.pem`

![](capturas/foto_3.png)

## Creamos la clave privada y el certificado de un primer cliente
`[isx46410800@miguel openvpn:aws]$ openssl genrsa -out client1key-vpn.pem`

![](capturas/foto_4.png)

`[isx46410800@miguel openvpn:aws]$ openssl req -new -key client1key-vpn.pem -out client1req-vpn.pem`

![](capturas/foto_5.png)

`[isx46410800@miguel openvpn:aws]$ openssl x509 -CAkey ca-key.pem -CA ca-crt.pem -req -in client1req-vpn.pem -days 3650 -CAcreateserial -extfile ext.client.conf -out client1crt-vpn.pem`

![](capturas/foto_6.png)

## Creamos la clave privada y el certificado de un segundo cliente
`[isx46410800@miguel openvpn:aws]$ openssl genrsa -out client2key-vpn.pem`

![](capturas/foto_7.png)

`[isx46410800@miguel openvpn:aws]$ openssl req -new -key client2key-vpn.pem -out client2req-vpn.pem`

![](capturas/foto_8.png)

`[isx46410800@miguel openvpn:aws]$ openssl x509 -CAkey ca-key.pem -CA ca-crt.pem -req -in client2req-vpn.pem -days 3650 -CAcreateserial -extfile ext.client.conf -out client2crt-vpn.pem`

![](capturas/foto_9.png)

## Exemple 3: Túnel Host to Host [ TLS Public/Secret Key ]
+ En este ejemplo utilizo dos hosts de mi casa, un pc y un portatil. El PC es el servidor y el portátil es el cliente1.

+ Escribimos en el PC la orden openvpn con certificados como `servidor`:
`[isx46410800@miguel openvpn:aws]$ sudo openvpn --remote 192.168.1.43 --dev tun1 --ifconfig 10.4.0.1 10.4.0.2 --tls-server --dh dh2048.pem --ca ca-crt.pem --cert servercrt-vpn.pem --key serverkey-vpn.pem --reneg-sec 60`

![](capturas/foto_10.png)

+ Vemos la interfaz `tun1` creada por el tunel VPN:

![](capturas/foto-11.png)

+ Escribimos en el portatil la orden openvpn con certificados como `cliente1`:
`[root@miguel-fedora keys]# openvpn --remote 192.168.1.41 --dev tun1 --ifconfig 10.4.0.2 10.4.0.1 --tls-client --ca ca-crt.pem --cert client1crt-vpn.pem --key client1key-vpn.pem --reneg-sec 60`

![](capturas/foto_13.png)

+ Vemos la interfaz `tun1` creada por el tunel VPN:

![](capturas/foto_14.png)

+ `Comprobaciones`:

+ En el server lo ponemos escuchar por el puerto 60000 y desde el cliente1 hacemos un telnet para comprobar que haya conexión por este tunel de openvpn:

![](capturas/foto_12.png)

![](capturas/foto_15.png)

## Exemple 4: Túnel Network to Network


