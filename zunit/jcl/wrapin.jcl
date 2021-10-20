* Wrap a line by placing * in column 72 and continue in column 1.
* /usr/lpp/cicsts/dfh560/
DEFINE PIPELINE(AZUPIPE)                GROUP(AZUGROUP)
       DESCRIPTION(zUnit JSON non-Java Provider Pipeline)
       STATUS(ENABLED)
       CONFIGFILE(/usr/lpp/cicsts/dfh560/                              *
samples/pipelines/jsonnonjavaprovid.xml)
       SHELF(/var/cicsts)
       WSDIR(/usr/lpp/IBM/idz/lib/wsbind)

