//RLAMSSC1 JOB MSGCLASS=H,REGION=0M,
//     NOTIFY=RLAM
//*  RUN WAZI VTP FOR HCAZ
//PLAYBK   EXEC PGM=BZUPLAY,PARM='TRACE=N'
//*PLAYBK   EXEC PGM=BZUPLAY,PARM='TRACE=Y'
//STEPLIB  DD DISP=SHR,DSN=BZU.V1R0M0.SBZULOAD
//         DD DISP=SHR,DSN=RLAM.HEALTH.LOAD
//*        DD DISP=SHR,DSN=RLAM.ZUNIT.TEST.LOAD
//*BZUPLAY  DD DISP=SHR,DSN=BZU100.ZUNIT.PLAYBACK
//BZUPLAY  DD DISP=SHR,DSN=BZU.ZUNIT.PLAYBACK.DEMO
//SYSOUT   DD SYSOUT=*       (THIS KEEPS LE OUTPUT IN ONE SPOOL FILE)
//BZUMSG  DD SYSOUT=*        (OPTIONAL, CAN BE A VB OUTPUT DATASET)
//
