//RLAMBZUS JOB MSGCLASS=X,REGION=0M,
//     NOTIFY=RLAM
//*BZUSETUP JOB <job parameters>
//*********************************************************************
//* Licensed materials - Property of IBM
//* 5655-AC5 5724-T07 5737-J31 Copyright IBM Corp. 2019, 2019
//* All rights reserved
//* US Government users restricted rights  -  Use, duplication or
//* disclosure restricted by GSA ADP schedule contract with IBM Corp.
//*
//* IBM z/OS Dynamic Test Runner
//* This JCL creates and populates data sets used
//* for the configuration of the product.
//*
//*
//* Refer to the bottom of this comment block for details on what
//* this JCL creates and copies.
//*
//*
//* CAUTION: This is neither a JCL procedure nor a complete job.
//* Before using this job step, you will have to make the following
//* modifications:
//*
//* 1) Add the job parameters to meet your system requirements.
//*
//* 2) Provide, in variable HLQ, the high-level qualifier(s) of the
//*    product install (default is BZU).
//*
//* 3) Provide, in variable CUST, the high-level qualifier(s) for the
//*    customized configuration data sets (default is BZU.#CUST).
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
//* Note(s):
//*
//* 1. This job should complete with a return code 0.
//*
//*********************************************************************
//*
//* JOB DETAILS
//*
//*********************************************************************
//*
//* All steps will create &CUST..&LLQ and copy in the listed members
//* from &BZU..SBZUSAMP. Refer to the different steps for more details.
//*
//*********************************************************************
//*
//* MIGRATION NOTES
//*
//*********************************************************************
//*
//         SET HLQ=BZU.V1R0M0
//         SET CUST=BZU.#CUST
//         SET DISP=NEW
//         SET VOLSER=T71112
//*
//* MVS COPY PROCEDURE
//*
//COPY     PROC RECL=80,
//            SRC=SBZUSAMP,
//            SPACE=,
//            LLQ=LLQ
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
//            VOL=SER=&VOLSER,
//            SPACE=&SPACE
//SYSIN    DD DUMMY
//ECOPY    PEND
//*
//* COPY MVS CUSTOMIZATION FILES
//*
//CONFIG   EXEC PROC=COPY,LLQ=CONFIG,SPACE=(TRK,(1,5,10))
//SYSIN    DD *
    COPY OUTDD=SYSUT2,INDD=((SYSUT1,R))
    SELECT MEMBER=BZULEOPT
//JCL      EXEC PROC=COPY,LLQ=JCL,SPACE=(TRK,(10,5,10))
//SYSIN    DD *
    COPY OUTDD=SYSUT2,INDD=((SYSUT1,R))
    SELECT MEMBER=BZUALLOC
    SELECT MEMBER=BZUCSD
    SELECT MEMBER=BZURACF
    SELECT MEMBER=BZUSETUP
    SELECT MEMBER=BZUVRM
    SELECT MEMBER=BZUVSAM
//PROCLIB  EXEC PROC=COPY,LLQ=PROCLIB,SPACE=(TRK,(5,5,10))
//SYSIN    DD *
    COPY OUTDD=SYSUT2,INDD=((SYSUT1,R))
    SELECT MEMBER=BZUINCL
    SELECT MEMBER=BZUPBCP
    SELECT MEMBER=BZUPDCP
    SELECT MEMBER=BZUPDLI
    SELECT MEMBER=BZUPECP
    SELECT MEMBER=BZUPMCP
    SELECT MEMBER=BZUPPLAY
//XML      EXEC PROC=COPY,LLQ=XML,SPACE=(TRK,(2,5,1))
//SYSIN    DD *
    COPY OUTDD=SYSUT2,INDD=((SYSUT1,R))
    SELECT MEMBER=BZUCBCBL
    SELECT MEMBER=BZUCBPL1
    SELECT MEMBER=BZUSCFG
//*
