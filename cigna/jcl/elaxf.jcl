//*********************************************************************
//* Licensed materials - Property of IBM                              *
//* 5724-T07 Copyright IBM Corp. 2018, 2020                           *
//* All rights reserved                                               *
//* US Government users restricted rights  -  Use, duplication or     *
//* disclosure restricted by GSA ADP schedule contract with IBM Corp. *
//*                                                                   *
//* z/OS Explorer Extensions                                          *
//* Include member to centralize definitions of other libraries.      *
//*                                                                   *
//*                                                                   *
//* Customize this member to match your site requirements.            *
//*                                                                   *
//* 1) Modify the values to the high level qualifiers of your         *
//*    libraries, as indicated in the comments of each variable.      *
//*                                                                   *
//* Note(s):                                                          *
//*                                                                   *
//* 1. The ELAXF* and AZUZU* PROC members include this member, so     *
//*    ensure it can be found by JES, for example by keeping all      *
//*    the member in the same library.                                *
//*                                                                   *
//*********************************************************************
//*
//* PRODUCT DATA SETS
//*
//* HLQ for z/OS Explorer Extensions (FMID HHOPxxx), default FEL
//* Latest Version FEL.V15R0M0
// SET FEL='FEL.V15R0M0'
//* HLQ for Dynamic Test Runner (FMID HAL6xxx), default BZU
//* Latest Version BZU.V1R0M0
// SET BZU='BZU.V1R0M0'
//* HLQ for z/OS Debugger (FMID HADRxxx), default EQAW
// SET EQA='EQAW'
//* HLQ for ADFz Common Components (FMID HVWRxxx), default IPV
//* Latest Version IPV.V1R8M0
// SET IPV='IPV.V1R8M0'
//*
//* COMPILER DATA SETS
//*
//* HLQ for COBOL, default IGY.V6R3M0
// SET IGY='IGY.V6R3M0'
//* HLQ for PL/I, default PLI.V1R1M1
// SET IBMZ='PLI.V1R1M1'
//* HLQ for C/C++, default CBC
// SET CCN='CBC'
//*
//* UTILITY DATA SETS
//*
//* HLQ for Language Environment (LE), default CEE
// SET CEE='CEE'
//* HLQ for XML Toolkit for z/OS, default SYS1
// SET IXM='SYS1'
//*
//* SUBSYSTEM DATA SETS
//*
//* HLQ for CICS TS, default DFH.V5R6M0
// SET DFH='DFH.V5R6M0'
//* HLQ for DB2, default DSNA12
// SET DSN='DSN.V12R1M0'
//* DSN for DB2 RUNLIB, default DSNA12.RUNLIB.LOAD
// SET DSNRUN='DSN121.RUNLIB.LOAD'
//* HLQ for customized IMS RESLIB, default IMS
// SET DFSRESL='IMS'
//* HLQ for customized IMS REFERAL, default IMS
// SET DFSREFER='IMS'
//* HLQ for customized IMS PROCLIB, default IMS
// SET DFSPROC='IMS'
//*
//* SYSTEM DATA SETS
//*
//* HLQ for SYS1.LINKLIB, system utilities, default SYS1
// SET LINKLIB='SYS1'
//* HLQ for SYS1.MACLIB, assembler macros, default SYS1
// SET MACLIB='SYS1'
//* HLQ for SYS1.CSSLIB, callable system service, default SYS1
// SET CSSLIB='SYS1'
//*
