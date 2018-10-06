; UPD ID= 8481, RIP:<7.MONITOR>ASEMBL.CMD.8,   9-Feb-88 11:49:09 by GSCOTT
;TCO 7.1218 - Update copyright notice.
; UPD ID= 8386, RIP:<7.MONITOR>ASEMBL.CMD.7,  27-Jan-88 10:29:29 by GSCOTT
;TCO 7.1200 - Add JSYSM as JSYS code from MEXEC.
; UPD ID= 8352, RIP:<7.MONITOR>ASEMBL.CMD.6,  20-Jan-88 11:39:37 by RASPUZZI
;TCO 7.1190 - CFS is now 2 modules: CFSSRV and CFSUSR. Also ripped out
;             definitions to CFSPAR.
; UPD ID= 200, RIP:<7.MONITOR>ASEMBL.CMD.5,  23-Oct-87 15:03:49 by GSCOTT
;TCO 7.1081 - Add DOB
; UPD ID= 185, RIP:<7.MONITOR>ASEMBL.CMD.3,  21-Oct-87 17:28:57 by RASPUZZI
;TCO 7.1076 - Add CLUDGR, CLUFRK, and CLUPAR.
; UPD ID= 157, RIP:<7.MONITOR>ASEMBL.CMD.2,  19-Oct-87 17:07:32 by LOMARTIRE
;TCO 7.1072 - Add ENQSRV and ENQPAR
;RIP:<7.MONITOR>ASEMBL.CMD.1,  21-May-87  9:00:00 by LOMARTIRE
;Convert from 6.1 to 7.0
; UPD ID= 1054, SNARK:<6.1.MONITOR>ASEMBL.CMD.10,  13-Nov-84 01:39:12 by GROSSMAN
;Add NIPAR, which somehow got lost in the 6.0/6.1 merge.
; UPD ID= 1053, SNARK:<6.1.MONITOR>ASEMBL.CMD.8,  13-Nov-84 01:12:21 by GROSSMAN
;Remove NISYM.
; UPD ID= 1021, SNARK:<6.1.MONITOR>ASEMBL.CMD.7,   9-Nov-84 16:08:19 by PRATT
;Add IPCIDV for TCP/IP over CI
;<PRATT.IP.TTY>ASEMBL.CMD.3,  5-Nov-84 14:16:32, Edit by PRATT
;Changes to TTYSRV and freinds
;PUBLIC:<MELOHN>ASEMBL.CMD.3  1-Nov-84 15:09:29, Edit by MELOHN
;Include 6.1 modules
; UPD ID= 3847, SNARK:<6.MONITOR>ASEMBL.CMD.3,   5-Mar-84 10:49:52 by PURRETTA

;	COPYRIGHT (c) DIGITAL EQUIPMENT CORPORATION 1976, 1988.
;	ALL RIGHTS RESERVED.
;
;	THIS SOFTWARE IS FURNISHED UNDER A  LICENSE AND MAY BE USED AND  COPIED
;	ONLY IN  ACCORDANCE  WITH  THE  TERMS OF  SUCH  LICENSE  AND  WITH  THE
;	INCLUSION OF THE ABOVE  COPYRIGHT NOTICE.  THIS  SOFTWARE OR ANY  OTHER
;	COPIES THEREOF MAY NOT BE PROVIDED  OR OTHERWISE MADE AVAILABLE TO  ANY
;	OTHER PERSON.  NO  TITLE TO  AND OWNERSHIP  OF THE  SOFTWARE IS  HEREBY
;	TRANSFERRED.
;
;	THE INFORMATION IN THIS  SOFTWARE IS SUBJECT  TO CHANGE WITHOUT  NOTICE
;	AND SHOULD  NOT  BE CONSTRUED  AS  A COMMITMENT  BY  DIGITAL  EQUIPMENT
;	CORPORATION.
;
;	DIGITAL ASSUMES NO  RESPONSIBILITY FOR  THE USE OR  RELIABILITY OF  ITS
;	SOFTWARE ON EQUIPMENT THAT IS NOT SUPPLIED BY DIGITAL.

COMPIL MON:SYSFLG.MAC+MON:PROLOG.MAC R:PROLOG
COMPIL MON:GLOBS.MAC R:GLOBS		;Global symbols
COMPIL MON:NIPAR.MAC R:NIPAR		;Universal for NISRV users
COMPIL MON:PHYPAR.MAC R:PHYPAR		;Universal for PHYSIO and like modules
COMPIL MON:SCAPAR.MAC R:SCAPAR		;Universal for SCA
COMPIL MON:MSCPAR.MAC R:MSCPAR		;Universal for MSCP drivers and servers
COMPIL MON:ENQPAR.MAC R:ENQPAR		;[7.1072] Universal for ENQ
COMPIL MON:CLUPAR.MAC R:CLUPAR		;[7.1076] CLUDGR parameters
COMPIL MON:CFSPAR.MAC R:CFSPAR		;[7.1190] CFS parameters
COMPIL MON:D36PAR.MAC R:D36PAR		;DECnet symbols
COMPIL MON:SCPAR.MAC R:SCPAR		;Session control symbols
COMPIL MON:CTERMD.MAC R:CTERMD		;CTERM symbols
COMPIL MON:TTYDEF.MAC R:TTYDEF		;Teletype service symbols
COMPIL MON:SERCOD.MAC R:SERCOD		;Codes and fields for SYSERR facility

COMPIL MON:SCHED.MAC R:SCHED		;Scheduler
COMPIL MON:PAGEM.MAC R:PAGEM		;Page management/working set management
COMPIL MON:PAGUTL.MAC R:PAGUTL		;Page management subroutines/utilities
COMPIL MON:TAPE.MAC R:TAPE		;Label handler and record processor
COMPIL MON:CDPSRV.MAC R:CDPSRV		;Card punch service
COMPIL MON:CDRSRV.MAC+MON:CDKLDV.MAC R:CDRSRV	;Card reader service
COMPIL MON:COMND.MAC R:COMND		;Command scanner JSYS
COMPIL MON:CRYPT.MAC R:CRYPT		;Encryption routines
COMPIL MON:DATIME.MAC R:DATIME		;Time and date routines
COMPIL MON:DEVICE.MAC R:DEVICE		;Device table (DEVTAB) routines
COMPIL MON:DIRECT.MAC R:DIRECT		;Disk directory management
COMPIL MON:DISC.MAC R:DISC		;Disk file management
COMPIL MON:ENQ.MAC R:ENQ		;ENQ and DEQ JSYS
COMPIL MON:FESRV.MAC R:FESRV		;Device code for FE devices
COMPIL MON:FILINI.MAC R:FILINI		;File system initialization
COMPIL MON:FILMSC.MAC R:FILMSC		;DTBs, PTY support
COMPIL MON:FILNFT.MAC R:FILNFT		;DECNET DAP support
COMPIL MON:FORK.MAC R:FORK		;Fork controlling JSYS and functions
COMPIL MON:FREE.MAC R:FREE		;Storage routines
COMPIL MON:FUTILI.MAC R:FUTILI		;Miscellaneous routines for file system
COMPIL MON:GETSAV.MAC R:GETSAV		;Get and save routines
COMPIL MON:GTJFN.MAC R:GTJFN		;GTJFN and GNJFN JSYS
COMPIL MON:IO.MAC R:IO			;Sequential IO routines and JSYSes
COMPIL MON:IPCF.MAC R:IPCF		;Interprocess communications facility
COMPIL MON:JSYSA.MAC R:JSYSA		;Non-file system JSYSes
COMPIL MON:JSYSF.MAC R:JSYSF		;File system JSYSes
COMPIL MON:JSYSM.MAC R:JSYSM		;[7.1200] JSYSes and support for MEXEC
COMPIL MON:LDINIT.MAC R:LDINIT		;JSYS dispatch table, monitor version
COMPIL MON:LINEPR.MAC+MON:LPFEDV.MAC R:LINEPR	;Line printer device routine
COMPIL MON:LOGNAM.MAC R:LOGNAM		;Logical name JSYSes and support
COMPIL MON:LOOKUP.MAC R:LOOKUP		;File name lookup utilities (for GTJFN)
COMPIL MON:MFLIN.MAC R:MFLIN		;Floating point input routines
COMPIL MON:MFLOUT.MAC R:MFLOUT		;Floating point outputl routines
COMPIL MON:PLT.MAC R:PLT		;Plotter service
COMPIL MON:POSTLD.MAC R:POSTLD		;Post-loading one-shot init
COMPIL MON:PTP.MAC R:PTP		;Paper tape punch service
COMPIL MON:PTR.MAC R:PTR		;Paper tape reader service
COMPIL MON:SWPALC.MAC R:SWPALC		;Swapping space allocation
COMPIL MON:SYSERR.MAC R:SYSERR		;SPEAR routines
COMPIL MON:TIMER.MAC R:TIMER		;TIMER JSYS & schedular clock routines
COMPIL MON:SCAMPI.MAC R:SCAMPI		;Systems communications architecture
COMPIL MON:CFSSRV.MAC R:CFSSRV		;Common File System
COMPIL MON:CFSUSR.MAC R:CFSUSR		;[7.1190] CFS user related stuff
COMPIL MON:PHYKLP.MAC R:PHYKLP		;Device dependent code for KLIPA port
COMPIL MON:SCSJSY.MAC R:SCSJSY		;The SCS% JSYS
COMPIL MON:PHYMSC.MAC R:PHYMSC		;MSCP driver
COMPIL MON:PHYMVR.MAC R:PHYMVR		;MSCP Server
COMPIL MON:APRSRV.MAC R:APRSRV		;Processor-dependent paging
COMPIL MON:DIAG.MAC R:DIAG		;The DIAG JSYS
COMPIL MON:DSKALC.MAC R:DSKALC		;Device independent disk code
COMPIL MON:PHYH2.MAC R:PHYH2		;Channel dependent code for RH20
COMPIL MON:PHYM2.MAC R:PHYM2		;Device dependent code for TM02/TU45
COMPIL MON:PHYM78.MAC R:PHYM78		;Device dependent code for TM78/TU78
COMPIL MON:PHYP2.MAC R:PHYP2		;Device dependent code for DX20B/RP20
COMPIL MON:PHYP4.MAC R:PHYP4		;Device dependent code for RP04 DISKS
COMPIL MON:PHYX2.MAC R:PHYX2		;Device dependent code for DX20A/TU70S
COMPIL MON:PHYSIO.MAC R:PHYSIO		;Device independent physical IO
COMPIL MON:MAGTAP.MAC R:MAGTAP		;MTA routines
COMPIL MON:MEXEC.MAC R:MEXEC		;Swappable monitor routines
COMPIL MON:MSTR.MAC R:MSTR		;Mountable structure monitor call
COMPIL MON:DTESRV.MAC R:DTESRV		;DTE support. RSX20F interface
COMPIL MON:TTYSRV.MAC R:TTYSRV		;Teletype service routines
COMPIL MON:NRTSRV.MAC R:NRTSRV		;NRT service routines
COMPIL MON:RSXSRV.MAC R:RSXSRV		;Teletype service routines
COMPIL MON:CIDLL.MAC R:CIDLL		;CI data link layer
COMPIL MON:CTHSRV.MAC R:CTHSRV		;CTERM terminal support
COMPIL MON:D36COM.MAC R:D36COM		;Common routines for DECnet
COMPIL MON:DNADLL.MAC R:DNADLL		;Common data link layer interface
COMPIL MON:JNTMAN.MAC R:JNTMAN		;TOPS20 specific network management 
COMPIL MON:LLINKS.MAC R:LLINKS		;DECnet NSP (ECL) layer
COMPIL MON:LLMOP.MAC R:LLMOP		;DECnet low level MOP support
COMPIL MON:TOPS.MAC+MON:NISRV.MAC+MON:PHYKNI.MAC R:NISRV ;KLNI device driver
COMPIL MON:NIUSR.MAC R:NIUSR		;NI% JSYS
COMPIL MON:NTMAN.MAC R:NTMAN		;Network management
COMPIL MON:ROUTER.MAC R:ROUTER		;DECnet router layer
COMPIL MON:SCJSYS.MAC R:SCJSYS		;DECnet JSYSes
COMPIL MON:SCLINK.MAC R:SCLINK		;DECnet session control layer
COMPIL MON:LATSRV.MAC R:LATSRV		;LAT host server
COMPIL MON:CLUDGR.MAC R:CLUDGR		;[7.1076] CLUDGR SYSAP
COMPIL MON:CLUFRK.MAC R:CLUFRK		;[7.1076] CLUDGR's fork
COMPIL MON:ENQSRV.MAC R:ENQSRV		;[7.1072] Cluster-wide ENQ/DEQ protocol
COMPIL MON:DOB.MAC    R:DOB		;[7.1081] DOB JSYS and code
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           