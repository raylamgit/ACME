//RLAMA    JOB MSGCLASS=H,REGION=0M,
//     NOTIFY=RLAM
//STEP1      EXEC  PGM=IDCAMS
//SYSPRINT   DD    SYSOUT=H
//SYSIN      DD    *
     LISTCAT -
          ENTRIES(SYS3.LOADLIB.PROD) -
          ALL
/*
