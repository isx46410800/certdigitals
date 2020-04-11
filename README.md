# CERTIFICATS DIGITALS TLS/SSL 

+ Aquest tema s’avalua en dues pràctiques que es fan a l’aula in situ però que l’alumne prepara a casa, desplega a l’aula i li ensenya al professor, tot explicant què fa i contestant les preguntes que rep.

+ Excepcionalment caldrà que elaboreu un document en markdown explicant el procés, amb incrustacions tant del codi per generar els certificats, la imatge i els serveis segurs, com de l’explotació dels serveis segurs. Ha de ser palpable que el tràfic és segur.

## Servidor ldap segur
+ Crear una nova imatge docker del servidor ldap que implementi un servidor ldap segur. Ha d’utilitzar els seus propis certificats digitals i ha de permetre tant connexions ldaps com connexions ldap amb starttls.
+ Utilitzarem sempre una autoritat de certificació CA anomenada Veritat Absoluta, que és qui emetrà tots els certificats per a l’organització edt.org. Aquí caldrà un certificat de servidor ldap.edt.org (si pode posar-li àlies millor).
+ Un client ldap ha de poser-se conectar al servidor ldap usant ldaps connectant al port privilegiat, però també usant ldap (port insegur) i usant startls per generar una connexió segura.
+ Assegureu-vos de practicar amb telnet, curl, i ldapserach (amb zetes!) fins a tenir-ho clar.

## OpenVPN amb certificats propis.
+ Implementar els exemples de OpenVPN (3,4) però utilitzant certificats pròpis i no els certificats per defecte de OpenVPN. I l’exemple amb systemctl i un servidor a AWS EC2 i dos clients locals
+ Utilitzarem sempre una autoritat de certificació CA anomenada Veritat Absoluta, que és qui emetrà tots els certificats per a l’organització edt.org. Aquí caldrà un certificat de servidor i un parell de certificats client. Atenció que segurament els certificats han de complir uns requeriments específics per a ser vàlids per a OpenVPN.
+ Recordeu també de posar atenció el nom del certificat (mireu de posar-hi àlies).
