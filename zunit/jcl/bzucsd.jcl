//RLAMBCSD JOB MSGCLASS=X,REGION=0M,
//     NOTIFY=RLAM
//*BZUCSD   JOB <job parameters>
//*********************************************************************
//* Licensed materials - Property of IBM
//* 5655-AC5 5724-T07 5737-J31 Copyright IBM Corp. 2019, 2019
//* All rights reserved
//* US Government users restricted rights  -  Use, duplication or
//* disclosure restricted by GSA ADP schedule contract with IBM Corp.
//*
//* IBM z/OS Dynamic Test Runner
//* This job will define the CICS recording service to your
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
//* 4) Change #bzucfg to the name of the data set holding the
//*    recorder configuration XML.
//*
//* 5) Change #bzuplay to the name of the data set used for
//*    storing recorded playback data.
//*    See the notes below on how to use user-specific data sets.
//*
//* 6) Change #bzuvfile to the name of the VSAM data set used for
//*    storing intermediate data during recording.
//*
//* 7) Change #listname to the appropriate CICS startup group
//*    list name, for example BZULIST.
//*    This list name must be in your CICS GRPLIST that is specified
//*    in the system initialization (SIT) parameters.
//*
//* 8) Verify/change the use of group name "BZUGROUP".
//*
//* Note(s):
//*
//* 1. For program-to-program interceptions with argument trapping to
//*    work, the following SIT parameter must be set:
//*    RENTPGM=NOPROTECT
//*
//* 2. The BZUCFG XML holds the commands for program to program
//*    interceptions. It might also hold callback program definitions
//*    used during replay of this recording with BZUPPLAY.
//*    The DSORG of this data set must be Sequential Fixed Blocked 80.
//*    See SBZUSAMP(BZUSCFG) for sample content.
//*
//* 3. See sample job SBZUSAMP(BZUALLOC) to allocate the data set that
//*    holds the recorded playback data.
//*
//* 4. See sample job SBZUSAMP(BZUVSAM) to allocate the VSAM data set
//*    used for storing intermediate data during recording.
//*
//* 5. Users can use a shared TDQ, like the provided TDQ(BZUQ), or use
//*    a personal TDQ to store recorded playback data. When creating
//*    personal TDQs, use the following model as template by providing
//*    a value for TDQ(), DSNAME(), and DDNAME(). DISPOSITION() can be
//*    OLD or MOD, and GROUP() can be adjusted to match your site
//*    standards. The other parameters have fixed values. TDQ name
//*    BZUC is reserved for usage by z/OS Dynamic Test Runner.
//*    Users can use sample job SBZUSAMP(BZUALLOC) or the zUnit client
//*    to allocate the data set referenced here.
//*
//* DEFINE TDQ(    )            GROUP(BZUGROUP)
//*        DSNAME()
//*        DDNAME(        )     TYPEFILE(OUTPUT)     TYPE(EXTRA)
//*        RECORDFORMAT(V)      BLOCKFORMAT(BLOCKED) DISPOSITION(OLD)
//*        RECORDSIZE(32756)    BLOCKSIZE(32760)
//*
//* 6. This job should complete with a return code 0. Return code 4
//*    is normal if a resource is pre-existing.
//*
//*********************************************************************
//BZUCSD   EXEC PGM=DFHCSDUP,REGION=0M,
//            PARM='CSD(READWRITE),PAGESIZE(60),NOCOMPAT'
//STEPLIB  DD DISP=SHR,DSN=DFH.V5R6M0.CICS.SDFHLOAD
//DFHCSD   DD DISP=SHR,DSN=CICS56.CICS01.DFHCSD
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
*      DELETE    LIST(BZULIST)
*      DELETE    GROUP(BZUGROUP)

***********************************************************************
*
* Shared definitions for CICS recorder application.
* These can be replaced by similar user-specific definitions.
*
***********************************************************************

* See sample job SBZUSAMP(BZUALLOC) to allocate the BZUQ data set.
DEFINE TDQ(BZUQ)            GROUP(BZUGROUP)
       DSNAME(#bzuplay)
       DDNAME(BZUBZUQ)      TYPEFILE(OUTPUT)     TYPE(EXTRA)
       RECORDFORMAT(V)      BLOCKFORMAT(BLOCKED) DISPOSITION(OLD)
       RECORDSIZE(32756)    BLOCKSIZE(32760)

***********************************************************************
*
* Common resource definitions for CICS recorder application.
*
***********************************************************************

* CICS requires this data set to be sequential
DEFINE TDQ(BZUC)            GROUP(BZUGROUP)
       DSNAME(#bzucfg)
       DDNAME(BZUCFG)       TYPEFILE(INPUT)      TYPE(EXTRA)
       DISPOSITION(SHR)     OPENTIME(DEFERRED)   BLOCKFORMAT(BLOCKED)
       RECORDFORMAT(F)      RECORDSIZE(80)       BLOCKSIZE(32720)

* See sample job SBZUSAMP(BZUVSAM) to allocate the BZUVFILE data set.
DEFINE FILE(BZUVFILE)       GROUP(BZUGROUP)      STATUS(ENABLED)
       DSNAME(#bzuvfile)
       RECORDFORMAT(V)      RECORDSIZE(32700)    KEYLENGTH(12)
       ADD(YES)             DELETE(YES)          READ(YES)
       BROWSE(YES)          RECOVERY(NONE)       STRINGS(10)

DEFINE TRANSACTION(BZUA)    GROUP(BZUGROUP)      PROGRAM(BZUCICSA)
DEFINE TRANSACTION(BZUE)    GROUP(BZUGROUP)      PROGRAM(BZUCICST)
DEFINE TRANSACTION(BZUI)    GROUP(BZUGROUP)      PROGRAM(BZUCIDRI)
DEFINE TRANSACTION(BZUS)    GROUP(BZUGROUP)      PROGRAM(BZUCICSS)
DEFINE TRANSACTION(BZUW)    GROUP(BZUGROUP)      PROGRAM(BZUCICSW)

DEFINE PROGRAM(BZUCICSA)    GROUP(BZUGROUP)      EXECKEY(CICS)
DEFINE PROGRAM(BZUCF410)    GROUP(BZUGROUP)
DEFINE PROGRAM(BZUCF420)    GROUP(BZUGROUP)
DEFINE PROGRAM(BZUCF510)    GROUP(BZUGROUP)
DEFINE PROGRAM(BZUCF520)    GROUP(BZUGROUP)
DEFINE PROGRAM(BZUCF530)    GROUP(BZUGROUP)
DEFINE PROGRAM(BZUCF540)    GROUP(BZUGROUP)
DEFINE PROGRAM(BZUCF550)    GROUP(BZUGROUP)
DEFINE PROGRAM(BZUCI410)    GROUP(BZUGROUP)
DEFINE PROGRAM(BZUCI420)    GROUP(BZUGROUP)
DEFINE PROGRAM(BZUCI510)    GROUP(BZUGROUP)
DEFINE PROGRAM(BZUCI520)    GROUP(BZUGROUP)
DEFINE PROGRAM(BZUCI530)    GROUP(BZUGROUP)
DEFINE PROGRAM(BZUCI540)    GROUP(BZUGROUP)
DEFINE PROGRAM(BZUCI550)    GROUP(BZUGROUP)
DEFINE PROGRAM(BZUCO410)    GROUP(BZUGROUP)
DEFINE PROGRAM(BZUCO420)    GROUP(BZUGROUP)
DEFINE PROGRAM(BZUCO510)    GROUP(BZUGROUP)
DEFINE PROGRAM(BZUCO520)    GROUP(BZUGROUP)
DEFINE PROGRAM(BZUCO530)    GROUP(BZUGROUP)
DEFINE PROGRAM(BZUCO540)    GROUP(BZUGROUP)
DEFINE PROGRAM(BZUCO550)    GROUP(BZUGROUP)
DEFINE PROGRAM(BZUCICSS)    GROUP(BZUGROUP)      EXECKEY(CICS)
DEFINE PROGRAM(BZUCICST)    GROUP(BZUGROUP)      EXECKEY(CICS)
DEFINE PROGRAM(BZUCICSW)    GROUP(BZUGROUP)      EXECKEY(CICS)
DEFINE PROGRAM(BZUCIDRS)    GROUP(BZUGROUP)      EXECKEY(CICS)
DEFINE PROGRAM(BZUCIDRT)    GROUP(BZUGROUP)      EXECKEY(CICS)
DEFINE PROGRAM(BZUCIDRI)    GROUP(BZUGROUP)      EXECKEY(CICS)
DEFINE PROGRAM(BZUCIDRP)    GROUP(BZUGROUP)
DEFINE PROGRAM(BZUII410)    GROUP(BZUGROUP)
DEFINE PROGRAM(BZUII420)    GROUP(BZUGROUP)
DEFINE PROGRAM(BZUII510)    GROUP(BZUGROUP)
DEFINE PROGRAM(BZUII520)    GROUP(BZUGROUP)
DEFINE PROGRAM(BZUII530)    GROUP(BZUGROUP)
DEFINE PROGRAM(BZUII540)    GROUP(BZUGROUP)
DEFINE PROGRAM(BZUII550)    GROUP(BZUGROUP)
DEFINE PROGRAM(BZUIO410)    GROUP(BZUGROUP)
DEFINE PROGRAM(BZUIO420)    GROUP(BZUGROUP)
DEFINE PROGRAM(BZUIO510)    GROUP(BZUGROUP)
DEFINE PROGRAM(BZUIO520)    GROUP(BZUGROUP)
DEFINE PROGRAM(BZUIO530)    GROUP(BZUGROUP)
DEFINE PROGRAM(BZUIO540)    GROUP(BZUGROUP)
DEFINE PROGRAM(BZUIO550)    GROUP(BZUGROUP)
DEFINE PROGRAM(BZURI410)    GROUP(BZUGROUP)
DEFINE PROGRAM(BZURI420)    GROUP(BZUGROUP)
DEFINE PROGRAM(BZURI510)    GROUP(BZUGROUP)
DEFINE PROGRAM(BZURI520)    GROUP(BZUGROUP)
DEFINE PROGRAM(BZURI530)    GROUP(BZUGROUP)
DEFINE PROGRAM(BZURI540)    GROUP(BZUGROUP)
DEFINE PROGRAM(BZURI550)    GROUP(BZUGROUP)
DEFINE PROGRAM(BZURO410)    GROUP(BZUGROUP)
DEFINE PROGRAM(BZURO420)    GROUP(BZUGROUP)
DEFINE PROGRAM(BZURO510)    GROUP(BZUGROUP)
DEFINE PROGRAM(BZURO520)    GROUP(BZUGROUP)
DEFINE PROGRAM(BZURO530)    GROUP(BZUGROUP)
DEFINE PROGRAM(BZURO540)    GROUP(BZUGROUP)
DEFINE PROGRAM(BZURO550)    GROUP(BZUGROUP)

***********************************************************************
*
* Add the group to a GRPLIST list.
* Change the LIST operand to a LIST which is in your CICS GRPLIST.
*
***********************************************************************

ADD    GROUP(BZUGROUP)  LIST(BZULIST)
//*
