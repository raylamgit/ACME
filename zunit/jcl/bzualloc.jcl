//RLAMBZUA JOB MSGCLASS=X,REGION=0M,
//     NOTIFY=RLAM
//*BZUALLOC JOB <job parameters>
//*********************************************************************
//* Licensed materials - Property of IBM
//* 5655-AC5 5724-T07 5737-J31 Copyright IBM Corp. 2019, 2019
//* All rights reserved
//* US Government users restricted rights  -  Use, duplication or
//* disclosure restricted by GSA ADP schedule contract with IBM Corp.
//*
//* IBM z/OS Dynamic Test Runner
//* This job creates a data set used to store recorded playback data
//*
//*
//* CAUTION: This is neither a JCL procedure nor a complete job.
//* Before using this job step, you will have to make the following
//* modifications:
//*
//* 1) Add the job parameters to meet your system requirements.
//*
//* 2) Provide, in variable HLQ, the high-level qualifier(s) of the
//*    data sets to be allocated (default is your user ID).
//*
//* 3) Provide, in variable DISP, the allocation disposition for the
//*    data sets to be allocated (default is NEW).
//*
//* 4) If you do not want the data sets to be SMS managed, you must:
//*    a) Provide, in variable VOLSER, the volume for the
//*       allocated data sets (there is no default).
//*    b) Uncomment all lines with the VOLSER keyword. It occurs
//*       in the block of SET statements, and in the ALLOC procedure.
//*
//* 5) If desired, adjust the size of the data sets to be allocated
//*    by changing the SIZE parameter used in the invocation of the
//*    ALLOC procedure.
//*
//* 6) If desired, adjust the low level qualifier(s) of the data sets
//*    to be allocated by changing the LLQ parameter used in the
//*    invocation of the ALLOC procedure.
//*
//* Note(s):
//*
//* 1. This job WILL complete with a return code 0.
//*    You must check allocation messages to verify that the
//*    data sets are allocated and cataloged as expected.
//*
//*********************************************************************
//*
//         SET HLQ=&SYSUID
//         SET DISP=NEW
//*        SET VOLSER=
//*
//*--------
//ALLOC    PROC LLQ=,
//            TYPE=LIBRARY,
//            RECF=FB,
//            RECL=80,
//            BLKS=0,
//            SIZE='TRK,(15,15)'
//*
//ALLOC    EXEC PGM=IEFBR14
//DSN      DD SPACE=(&SIZE),
//            DISP=(&DISP,CATLG,DELETE),
//            DSNTYPE=&TYPE,
//            BLKSIZE=&BLKS,
//            RECFM=&RECF,
//            LRECL=&RECL,
//            UNIT=SYSALLDA,
//*           VOL=SER=&VOLSER,
//            DSN=&HLQ..&LLQ
//         PEND
//*--------
//*
//PLAYBACK EXEC ALLOC,TYPE=BASIC,RECF=VB,RECL=32756,      do not change
//            SIZE='CYL,(10,10)',LLQ=ZUNIT.PLAYBACK       can change
//*
