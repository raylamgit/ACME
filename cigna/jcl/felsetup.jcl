//RLAMZSET JOB MSGCLASS=X,REGION=0M,
//     NOTIFY=RLAM
//*FELSETUP JOB <job parameters>
//*********************************************************************
//* Licensed materials - Property of IBM
//* 5724-T07 Copyright IBM Corp. 2008, 2020
//* All rights reserved
//* US Government users restricted rights  -  Use, duplication or
//* disclosure restricted by GSA ADP schedule contract with IBM Corp.
//*
//* z/OS Explorer Extensions
//* This JCL creates and populates data sets and directories used
//* for the configuration of the product.
//*
//*
//* Refer to the bottom of this comment block for details on what
//* this JCL creates and copies.
//*
//*
//* CAUTIONS:
//* A) This job contains case sensitive path statements.
//* B) This is neither a JCL procedure nor a complete job.
//*    Before using this JCL, you will have to make the following
//*    modifications:
//*
//* 1) Add the job parameters to meet your system requirements.
//*
//* 2) Provide, in variable HLQ, the high-level qualifier(s) of the
//*    product install (default is FEL).
//*
//* 3) Provide, in variable CUST, the high-level qualifier(s) for the
//*    customized configuration data sets (default is FEL.#CUST).
//*
//* 4) Provide, in variable DISP, the allocation disposition for the
//*    customized configuration data sets (default NEW).
//*
//* 5) If you do not want the data sets to be SMS managed, you must:
//*    a) Provide, in variable VOLSER, the volume for the
//*       customized configuration files (there is no default).
//*    b) Uncomment all lines with the VOLSER keyword. It occurs
//*       in the block of SET statements and in the COPY procedure.
//*
//* 6) Provide, in variable BASE, the home directory of the
//*    product install (default is /usr/lpp/IBM/zee).
//*    This must be done twice, once in the SET statement and once
//*    in the STDENV DD of the USS step.
//*
//* 7) Provide, in variable CNFG, the home directory for the
//*    customized configuration files (default is /etc/zexpl).
//*    This must be done in the STDENV DD of the USS step.
//*    Note that this directory must match the configuration
//*    directory of IBM Explorer for z/OS.
//*
//* 8) By default, z/OS UNIX commands use /tmp to store temporary
//*    data. Uncomment and customize the TMPDIR variable if /tmp
//*    cannot be used by the FELSETUP initialization script.
//*    This must be done in the STDENV DD of the USS step.
//*
//* Note(s):
//*
//* 1. THE USER ID THAT RUNS THIS JOB MUST HAVE SUFFICIENT z/OS UNIX
//*    AUTHORITY.
//*
//* 2. When using existing directories, for example /etc, note that
//*    these directories are expected to have at least a permission
//*    bit mask that allows read/execute for everyone (eg. mask 755).
//*    The user ID assigned to this job must have write permission.
//*
//* 3. If a target file already exists while copying the z/OS UNIX
//*    samples, the original file will be copied to
//*    $FILE.backup.by.FELSETUP before replacing it by the sample.
//*
//* 4. This job should complete with a return code 0.
//*
//*********************************************************************
//*
//* JOB DETAILS
//*
//*********************************************************************
//*
//* All steps, except for the USS one, will create &CUST..&LLQ and
//* copy in the listed members from &FEL..SFELSAMP. Refer to the
//* different steps for more details.
//*
//* The USS step will execute a shell script that creates z/OS UNIX
//* directories (based upon the variables defined in DD STDENV),
//* copies samples (from $BASE/samples) and sets
//* permission bits for directories. All files are created with
//* permission bitmask 755 (read/write/execute for owner,
//* read/execute for group and other).
//*
//*    * $CNFG
//*      default: /etc/zexpl
//*      permission bitmask: 755
//*      files: CRASRV.properties                      (from samples)
//*             crastart.conf                          (from samples)
//*             crastart.endevor.conf                  (from samples)
//*             include.conf                           (from samples)
//*             zee.env                                (from samples)
//*
//*********************************************************************
//*
//* MIGRATION NOTES
//*
//*********************************************************************
//*
//* The shell script executed in the USS step will create a backup,
//* <file>.backup.by.FELSETUP, if a target file already exists.
//*
//* changed in v15.0.0.0
//* --------------------
//* * sample files/members that are no longer copied
//*   JCL(FELCMPLY)
//*
//* changed in v14.2.0.0
//* --------------------
//* * directories/data sets that are no longer created
//*   /var/zee/sclmdt
//*   /var/zee/sclmdt/CONFIG
//*   /var/zee/sclmdt/CONFIG/PROJECT
//*   /var/zee/sclmdt/CONFIG/script
//* * sample files/members that are no longer copied
//*   /var/zee/sclmdt/CONFIG/TRANSLATE.conf
//*   /var/zee/sclmdt/CONFIG/PROJECT/SITE.conf
//*   /var/zee/sclmdt/CONFIG/PROJECT/SCLMproject.conf
//*   /var/zee/sclmdt/CONFIG/script/BWBCRONB
//*   /var/zee/sclmdt/CONFIG/script/BWBCRONP
//*   /var/zee/sclmdt/CONFIG/script/BWBCRON1
//*   /var/zee/sclmdt/CONFIG/script/deploy.jacl
//* * sample file/member changes
//*   /etc/zexpl/zee.env -> /etc/zexpl/zee.env
//*
//* changed in v14.1.5.0
//* --------------------
//* * new sample files/members
//*   JCL(AZUCSD)
//*
//* changed in v14.1.4.0
//* --------------------
//* * new sample files/members
//*   PROCLIB(ELAXF)
//*
//* changed in v14.1.0.0
//* --------------------
//* * new sample files/members
//*   JCL(AZUALLOC)
//*   JCL(FELCMPLY)
//*   CNTL(FELEDTMC)
//*
//* changed in v14.0.0.0
//* --------------------
//* * directory/data set changes
//*   /usr/lpp/IBM/rdz -> /usr/lpp/IBM/zee
//*   /var/rdz/sclmdt -> /var/zee/sclmdt
//* * new sample files/members
//*   PROCLIB(AZUZUDB2)
//*   JCL(FELSMF)
//* * sample files/members that are no longer copied
//*   PROCLIB(AQEJCL)  (DBGMGR)
//*   JCL(AQECSD)
//*   JCL(AQED3CEE)
//*   JCL(AQED3CXT)
//*   JCL(AQERACF)
//*
//* changed in v9.5.1.1
//* -------------------
//* * sample file/member changes
//*   SQL(FEKTEP2) -> SQL(FELTEP2)
//*   SQL(FEKTIAD) -> SQL(FELTIAD)
//*
//* changed in v9.5.1.0
//* ----------------
//* * new directories/data sets
//*   none
//* * directory/data set changes
//*   /usr/lpp/rdz -> /usr/lpp/IBM/rdz
//*   /etc/rdz -> /etc/zexpl
//* * directories/data sets that are no longer created
//*   /var/rdz/WORKAREA
//*   /var/rdz/logs
//*   /var/rdz/pushtoclient
//* * new sample files/members
//*   /etc/zexpl/rdz.env
//* * sample file/member changes
//*   JCL(FEKRACF) -> JCL(FELRACF)
//*   JCL(FEKSETUP) -> JCL(FELSETUP)
//* * sample files/members that are no longer copied
//*   /etc/rdz/ISPF.conf
//*   /etc/rdz/ivpinit
//*   /etc/rdz/pushtoclient.properties
//*   /etc/rdz/rsecomm.properties
//*   /etc/rdz/rsed.envvars
//*   /etc/rdz/ssl.properties
//*   PARMLIB(FEJJCNFG)
//*   PROCLIB(FEJJJCL) (JMON)
//*   PROCLIB(FEKRSED) (RSED)
//*   JCL(FEKLOGS)
//*   JCL(FEKPBITS)
//*   CNTL(FEJTSO)
//*
//* changed in v9500
//* ----------------
//* * new sample files/members
//*   PARMLIB(CRASCL)
//*
//* * sample files/members that are no longer copied
//*   COBOL(ADNMSGHS)
//*   JCL(ADNCSDAR)
//*   JCL(ADNCSDRS)
//*   JCL(ADNCSDTX)
//*   JCL(ADNCSDWS)
//*   JCL(ADNJSPAU)
//*   JCL(ADNMSGHC)
//*   JCL(ADNTXNC)
//*   JCL(ADNVCRD)
//*   JCL(ADNVMFST)
//*
//* changed in v9110
//* ----------------
//* * new sample files/members
//*   JCL(IRZCSD)
//*
//* changed in v9100
//* ----------------
//* * new sample files/members
//*   JCL(AQED3CEE)
//*   JCL(AQED3CXT)
//*   JCL(FEKPBITS)
//*
//* changed in v9010
//* ----------------
//* * new sample files/members
//*   JCL(AQECSD)
//*   JCL(AQERACF)
//*   PARMLIB(CRACFG)
//*   PROCLIB(DBGMGR)
//*
//* changed in v9000
//* ----------------
//* * new sample files/members
//*   PROCLIB(ELAXFSP)
//*   PROCLIB(ELAXFSQL)
//*   SQL(FEKTEP2)
//*   SQL(FEKTIAD)
//*
//* * sample files/members that are no longer copied
//*   PROCLIB(FEKLOCKD)
//*   PROCLIB(ELAXMSAM)
//*   JCL(ELAXMJCL)
//*
//* changed in v8510
//* ----------------
//* * new sample files/members
//*   CNTL(CRABJOBC)
//*
//* changed in v8500
//* ----------------
//* * new sample files/members
//*   $CNFG/include.conf
//*   PROCLIB(AZUZUNIT)
//* * sample files/members that are no longer copied
//*   FMIEXT.properties
//*
//*********************************************************************
//*
//         SET HLQ=FEL.V15R0M0
//         SET CUST=FEL.#CUST
//         SET DISP=NEW
//*        SET VOLSER=
//         SET BASE='/usr/lpp/IBM/idz'
//*
//* z/OS UNIX ACTIONS
//*
//USS      EXEC PGM=BPXBATCH,REGION=0M,TIME=NOLIMIT
//STDENV   DD *
BASE=/usr/lpp/IBM/idz
CNFG=/etc/zexpl
#TMPDIR=/tmp
//STDIN    DD PATHOPTS=(ORDONLY),PATH='&BASE./bin/felsetup.sh'
//STDOUT   DD SYSOUT=*
//STDERR   DD SYSOUT=*
//*
//* MVS COPY PROCEDURE
//*
//COPY     PROC RECL=80,
//            SRC=SFELSAMP,
//            SPACE=,
//            LLQ=
//*
//COPY     EXEC PGM=IEBCOPY,REGION=0M,TIME=NOLIMIT
//SYSPRINT DD SYSOUT=*
//SYSUT1   DD DISP=SHR,DSN=&HLQ..&SRC
//SYSUT2   DD DSN=&CUST..&LLQ,
//            DISP=(&DISP,CATLG,DELETE),
//            DSNTYPE=LIBRARY,
//            BLKSIZE=0,
//            RECFM=FB,
//            LRECL=&RECL,
//            UNIT=SYSALLDA,
//*           VOL=SER=&VOLSER,
//            SPACE=&SPACE
//SYSIN    DD DUMMY
//ECOPY    PEND
//*
//* COPY MVS CUSTOMIZATION FILES
//*
//PARMLIB  EXEC PROC=COPY,LLQ=PARMLIB,SPACE=(TRK,(2,1,1))
//SYSIN    DD *
    COPY OUTDD=SYSUT2,INDD=((SYSUT1,R))
    SELECT MEMBER=CRABCFG
    SELECT MEMBER=CRACFG
    SELECT MEMBER=CRASCL
    SELECT MEMBER=CRASHOW
    SELECT MEMBER=CRATMAP
//PROCLIB  EXEC PROC=COPY,LLQ=PROCLIB,SPACE=(TRK,(5,1,10))
//SYSIN    DD *
    COPY OUTDD=SYSUT2,INDD=((SYSUT1,R))
    SELECT MEMBER=AZUZUDB2
    SELECT MEMBER=AZUZUNIT
    SELECT MEMBER=ELAXF
    SELECT MEMBER=ELAXFADT
    SELECT MEMBER=ELAXFASM
    SELECT MEMBER=ELAXFBMS
    SELECT MEMBER=ELAXFCOC
    SELECT MEMBER=ELAXFCOP
    SELECT MEMBER=ELAXFCOT
    SELECT MEMBER=ELAXFCPC
    SELECT MEMBER=ELAXFCPP
    SELECT MEMBER=ELAXFCP1
    SELECT MEMBER=ELAXFDCL
    SELECT MEMBER=ELAXFGO
    SELECT MEMBER=ELAXFLNK
    SELECT MEMBER=ELAXFMFS
    SELECT MEMBER=ELAXFPLP
    SELECT MEMBER=ELAXFPLT
    SELECT MEMBER=ELAXFPL1
    SELECT MEMBER=ELAXFPP1
    SELECT MEMBER=ELAXFSP
    SELECT MEMBER=ELAXFSQL
    SELECT MEMBER=ELAXFTSO
    SELECT MEMBER=ELAXFUOP
//JCL      EXEC PROC=COPY,LLQ=JCL,SPACE=(TRK,(10,1,10))
//SYSIN    DD *
    COPY OUTDD=SYSUT2,INDD=((SYSUT1,R))
    SELECT MEMBER=AZUALLOC
    SELECT MEMBER=AZUCSD
    SELECT MEMBER=CRA$VCAD
    SELECT MEMBER=CRA$VCAS
    SELECT MEMBER=CRA$VDEF
    SELECT MEMBER=CRA$VMSG
    SELECT MEMBER=CRA$VSTR
    SELECT MEMBER=CRA#ASLM
    SELECT MEMBER=CRA#CIRX
    SELECT MEMBER=CRA#UADD
    SELECT MEMBER=CRA#UQRY
    SELECT MEMBER=CRA#VPDS
    SELECT MEMBER=CRA#VSLM
    SELECT MEMBER=FELRACF
    SELECT MEMBER=FELSETUP
    SELECT MEMBER=FELSMF
    SELECT MEMBER=IRZCSD
//CNTL     EXEC PROC=COPY,LLQ=CNTL,SPACE=(TRK,(2,1,2))
//SYSIN    DD *
    COPY OUTDD=SYSUT2,INDD=((SYSUT1,R))
    SELECT MEMBER=CRABATCA
    SELECT MEMBER=CRABJOBC
    SELECT MEMBER=CRASUBCA
    SELECT MEMBER=CRASUBMT
    SELECT MEMBER=FEKRNPLI
    SELECT MEMBER=FELEDTMC
//ASM      EXEC PROC=COPY,LLQ=ASM,SPACE=(TRK,(2,1,1))
//SYSIN    DD *
    COPY OUTDD=SYSUT2,INDD=((SYSUT1,R))
    SELECT MEMBER=CRAXJCL
//SQL      EXEC PROC=COPY,LLQ=SQL,SPACE=(TRK,(2,1,1))
//SYSIN    DD *
    COPY OUTDD=SYSUT2,INDD=((SYSUT1,R))
    SELECT MEMBER=FELTEP2
    SELECT MEMBER=FELTIAD
//*
