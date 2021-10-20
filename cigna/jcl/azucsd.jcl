//RLAMCSD JOB MSGCLASS=X,REGION=0M,
//     NOTIFY=RLAM
//*AZUCSD   JOB <job parameters>
//*********************************************************************
//* Licensed materials - Property of IBM
//* 5724-T07 Copyright IBM Corp. 2019, 2020
//* All rights reserved
//* US Government users restricted rights  -  Use, duplication or
//* disclosure restricted by GSA ADP schedule contract with IBM Corp.
//*
//* z/OS Explorer Extensions
//* IBM z/OS Automated Unit Testing Framework (zUnit)
//* This job will define the zUnit CICS recording service to your
//* CICSTS region.
//*
//*
//* CAUTION: This is neither a JCL procedure nor a complete job.
//* Before using this job step, you will have to make the following
//* modifications:
//*
//* 1) Add the job parameters to meet your system requirements.
//*
//* 2) Change #cicshlq to the CICS high level qualifier(s).
//*
//* 3) Change #csdhlq to the high level qualifier(s) of the CICS
//*    CSD containing the resource definitions for the CICS region.
//*
//* 4) Change #port to the TCP/IP port used for communication with
//*    the zUnit REST API, http://<host>:<port>/zunit/.
//*
//* 5) Change #cicspath to the path used to install the z/OS UNIX
//*    components of CICS.
//*
//* 6) Change #azupath to the path used to install the z/OS UNIX
//*    components of zUnit (default /usr/lpp/IBM/zee).
//*
//* 7) Verify/change the use of path "/var/cicsts" as SHELF
//*    directory for your CICS region.
//*
//* 8) Change #listname to the appropriate CICS startup group
//*    list name, for example AZULIST.
//*    This list name must be in your CICS GRPLIST that is specified
//*    in the system initialization (SIT) parameters.
//*
//* 9) Verify/change the use of group name "AZUGROUP".
//*
//* Note(s):
//*
//* 1. The CSD definitions changed in v14.2.1. If you submitted this
//*    job with the v14.2.0 definitions, uncomment the DELETE
//*    statements marked with "since v14.2.1" and resubmit this job.
//*
//* 2. This job should complete with a return code 0. Return code 4
//*    is normal if a resource is pre-existing.
//*
//*********************************************************************
//AZUCSD   EXEC PGM=DFHCSDUP,REGION=0M,
//            PARM='CSD(READWRITE),PAGESIZE(60),NOCOMPAT'
//STEPLIB  DD DISP=SHR,DSN=DFH.V5R6M0.CICS.SDFHLOAD
//DFHCSD   DD DISP=SHR,DSN=CICS56.CICS01.DFHCSD
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
       DELETE    LIST(AZULIST)
       DELETE    GROUP(AZUGROUP)

* since v14.2.1, obsolete
*      DELETE TRANSACTION(AZUR)
*      DELETE PROGRAM(AZUCRBG)
*      DELETE PROGRAM(AZUCRGE)
*      DELETE PROGRAM(AZUCSTRT)
* since v14.2.1, reused with possibly altered definition details
*      DELETE TRANSACTION(AZUM)
*      DELETE PROGRAM(AZUCMGT)
*      DELETE PROGRAM(AZUCREST)
*      DELETE TCPIPSERVICE(AZUREST)
*      DELETE PIPELINE(AZUPIPE)

***********************************************************************
*
* REST API definitions for zUnit CICS recorder application.
*
***********************************************************************

DEFINE TRANSACTION(AZUM)                GROUP(AZUGROUP)
       DESCRIPTION(zUnit Management Transaction)
       PROGRAM(AZUCMGT)

DEFINE PROGRAM(AZUCMGT)                 GROUP(AZUGROUP)
       DESCRIPTION(zUnit Management Command)
       LANGUAGE(C)

DEFINE PROGRAM(AZUCREST)                GROUP(AZUGROUP)
       DESCRIPTION(zUnit Rest API)
       LANGUAGE(C)                      EXECKEY(CICS)

* 6486 for zUnit REST API
DEFINE TCPIPSERVICE(AZUREST)            GROUP(AZUGROUP)
       DESCRIPTION(zUnit REST API)
       AUTHENTICATE(NO)                 BACKLOG(1)
       MAXDATALEN(512000)               PORTNUMBER(6486)
       PROTOCOL(HTTP)                   SOCKETCLOSE(NO)
       SSL(NO)                          STATUS(OPEN)
       TRANSACTION(CWXN)                URM(DFHWBAAX)

* Wrap a line by placing * in column 72 and continue in column 1.
* /usr/lpp/cicsts/dfh560/
DEFINE PIPELINE(AZUPIPE)                GROUP(AZUGROUP)
       DESCRIPTION(zUnit JSON non-Java Provider Pipeline)
       STATUS(ENABLED)
       CONFIGFILE(/usr/lpp/cicsts/dfh560/samples/pipelines/jsonnonjavap*
rovid.xml)
       SHELF(/var/cicsts)
       WSDIR(/usr/lpp/IBM/idz/lib/wsbind)

***********************************************************************
*
* Add the group to a GRPLIST list.
* Change the LIST operand to a LIST which is in your CICS GRPLIST.
*
***********************************************************************

ADD    GROUP(AZUGROUP)  LIST(AZULIST)
//*
