//RLAMZUNI JOB MSGCLASS=X,REGION=0M,
//     NOTIFY=RLAM
//*AZUALLOC JOB <job parameters>
//*********************************************************************
//* Licensed materials - Property of IBM                              *
//* 5724-T07 Copyright IBM Corp. 2016, 2020                           *
//* All rights reserved                                               *
//* US Government users restricted rights  -  Use, duplication or     *
//* disclosure restricted by GSA ADP schedule contract with IBM Corp. *
//*                                                                   *
//* z/OS Explorer Extensions                                          *
//* IBM z/OS Automated Unit Testing Framework (zUnit)                 *
//* This JCL will allocate user-specific target libraries             *
//*                                                                   *
//*                                                                   *
//* CAUTION: This is neither a JCL procedure nor a complete job.      *
//* Before using this job step, you will have to make the following   *
//* modifications:                                                    *
//*                                                                   *
//* 1) Add the job parameters to meet your system requirements.       *
//*                                                                   *
//* 2) Provide, in variable HLQ, the high-level qualifier(s) of the   *
//*    allocated data sets (default is your user ID).                 *
//*                                                                   *
//* 3) Provide, in variable UHLQ, the high-level qualifier(s) of the  *
//*    debugger delayed debug profile (default is your user ID).      *
//*                                                                   *
//* 4) Provide, in variable DISP, the allocation disposition for the  *
//*    allocated data sets (default is NEW).                          *
//*                                                                   *
//* 5) If you do not want the data sets to be SMS managed, you must:  *
//*    a) Provide, in variable VOLSER, the volume for the             *
//*       allocated data sets (there is no default).                  *
//*    b) Uncomment all lines with the VOLSER keyword. It occurs      *
//*       in the block of SET statements, in the PDSE procedure, and  *
//*       in the ZUNIT procedure.                                     *
//*                                                                   *
//* Note(s):                                                          *
//*                                                                   *
//* 1. This job WILL complete with a return code 0.                   *
//*    You must check allocation messages to verify that the          *
//*    data sets are allocated and cataloged as expected.             *
//*                                                                   *
//*********************************************************************
//*
//         SET HLQ=&SYSUID
//         SET UHLQ=&SYSUID
//         SET DISP=MOD
//*        SET VOLSER=
//*
//*--------
//PDSE     PROC LLQ=,
//            RECF=FB,
//            RECL=80,
//            BLKS=0,
//            SIZE='TRK,(15,15,20)'
//*
//ALLOC    EXEC PGM=IEFBR14
//DSN      DD SPACE=(&SIZE),
//            DISP=(&DISP,CATLG,DELETE),
//            DSNTYPE=LIBRARY,
//            BLKSIZE=&BLKS,
//            RECFM=&RECF,
//            LRECL=&RECL,
//            UNIT=SYSALLDA,
//*           VOL=SER=&VOLSER,
//            DSN=&HLQ..&LLQ
//         PEND
//*--------
//COBOL    PROC
//SOURCE   EXEC PROC=PDSE,LLQ=COBOL.SOURCE.COBOL    * program
//COPYLIB  EXEC PROC=PDSE,LLQ=COBOL.COPYLIB
//OBJECT   EXEC PROC=PDSE,LLQ=COBOL.OBJ
//LISTING  EXEC PROC=PDSE,LLQ=COBOL.LISTING,RECF=FBA,RECL=133
//SYSDEBUG EXEC PROC=PDSE,LLQ=COBOL.SYSDEBUG,RECL=1024
//ZUNIT    EXEC PROC=PDSE,LLQ=ZUNIT.COBOL           * test case
//         PEND
//*--------
//PLI      PROC
//SOURCE   EXEC PROC=PDSE,LLQ=PLI.SOURCE.PLI        * program
//INCLUDE  EXEC PROC=PDSE,LLQ=PLI.INCLUDE
//OBJECT   EXEC PROC=PDSE,LLQ=PLI.OBJ
//LISTING  EXEC PROC=PDSE,LLQ=PLI.LISTING,RECF=VBA,RECL=137
//SYSDEBUG EXEC PROC=PDSE,LLQ=PLI.SYSDEBUG,RECL=1024
//ZUNIT    EXEC PROC=PDSE,LLQ=ZUNIT.PLI             * test case
//         PEND
//*--------
//ZUNIT    PROC
//* zUnit runner configuration
//AZUCFG   EXEC PROC=PDSE,LLQ=ZUNIT.AZUCFG,RECF=VBA,RECL=16383
//* zUnit test case generation configuration
//AZUGEN   EXEC PROC=PDSE,LLQ=ZUNIT.AZUGEN,RECF=VBA,RECL=16383
//* zUnit runner result
//AZURES   EXEC PROC=PDSE,LLQ=ZUNIT.AZURES,RECF=VBA,RECL=16383
//* zUnit test data layout
//AZUSCH   EXEC PROC=PDSE,LLQ=ZUNIT.AZUSCH,RECF=VBA,RECL=16383
//* zUnit test data
//AZUTDT   EXEC PROC=PDSE,LLQ=ZUNIT.AZUTDT,RECF=VBA,RECL=16383
//* Debugger delayed debug profile (sequential data set)
//EQAUOPTS EXEC PGM=IEFBR14
//DSN      DD SPACE=(TRK,(1,1)),
//            DISP=(&DISP,CATLG,DELETE),
//            DCB=(DSORG=PS,BLKSIZE=0,RECFM=FB,LRECL=80),
//            UNIT=SYSALLDA,
//*           VOL=SER=&VOLSER,
//            DSN=&UHLQ..ZUNIT.DLAYDBG.EQAUOPTS
//         PEND
//*--------
//*
//COBOL    EXEC PROC=COBOL
//PLI      EXEC PROC=PLI
//ZUNIT    EXEC PROC=ZUNIT
//* load library must be PDS/E
//LOAD     EXEC PROC=PDSE,LLQ=LOAD,RECF=U,RECL=0,BLKS=32760
//*
