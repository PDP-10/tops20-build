; UPD ID= 8476, RIP:<7.MONITOR>APPEND.CMD.11,   9-Feb-88 11:48:34 by GSCOTT
;TCO 7.1218 - Update copyright notice.
; UPD ID= 8384, RIP:<7.MONITOR>APPEND.CMD.10,  27-Jan-88 10:28:25 by GSCOTT
;TCO 7.1200 - Add JSYSM
;RIP:<7.MONITOR>APPEND.CMD.9 22-Jan-88 11:24:18, Edit by GSCOTT
;TCO 7.1195 - Create as file to produce LN2070.REL from discrete .REL files

;	COPYRIGHT (c) DIGITAL EQUIPMENT CORPORATION 1988.
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

DELETE LN2070.REL
APPEND R:TTYSRV.REL,R:NRTSRV.REL,R:RSXSRV.REL,R:CIDLL.REL R:LN2070.REL 
APPEND R:CTHSRV.REL,R:D36COM.REL,R:DNADLL.REL,R:JNTMAN.REL R:LN2070.REL
APPEND R:LLINKS.REL,R:LLMOP.REL,R:NISRV.REL R:LN2070.REL
APPEND R:NIUSR.REL,R:NTMAN.REL R:LN2070.REL
APPEND R:ROUTER.REL,R:SCJSYS.REL,R:SCLINK.REL,R:LATSRV.REL R:LN2070.REL
APPEND R:SCAMPI.REL,R:SCSJSY.REL,R:PHYKLP.REL,R:PHYMSC.REL R:LN2070.REL
APPEND R:CFSSRV.REL,R:CFSUSR.REL R:LN2070.REL
APPEND R:ENQSRV.REL,R:APRSRV.REL,R:SCHED.REL,R:PAGEM.REL R:LN2070.REL
APPEND R:PAGUTL.REL,R:PHYMVR.REL,R:FORK.REL R:LN2070.REL	;[7.1200]
APPEND R:MEXEC.REL,R:JSYSM.REL,R:GETSAV.REL R:LN2070.REL	;[7.1200]
APPEND R:SYSERR.REL,R:COMND.REL,R:DEVICE.REL R:LN2070.REL
APPEND R:DIRECT.REL,R:ENQ.REL,R:FREE.REL,R:FUTILI.REL,R:GTJFN.REL R:LN2070.REL
APPEND R:IO.REL,R:IPCF.REL,R:JSYSA.REL,R:JSYSF.REL,R:LOGNAM.REL R:LN2070.REL
APPEND R:LOOKUP.REL,R:MSTR.REL,R:SWPALC.REL R:LN2070.REL
APPEND R:DISC.REL,R:FILINI.REL R:LN2070.REL
APPEND R:FILMSC.REL,R:MFLIN.REL,R:MFLOUT.REL,R:DATIME.REL R:LN2070.REL
APPEND R:PHYSIO.REL,R:DIAG.REL,R:DSKALC.REL R:LN2070.REL
APPEND R:PHYH2.REL,R:PHYP4.REL R:LN2070.REL
APPEND R:PHYP2.REL,R:PHYM78.REL,R:FESRV.REL,R:MAGTAP.REL R:LN2070.REL
APPEND R:TAPE.REL,R:TIMER.REL,R:PHYM2.REL,R:PHYX2.REL,R:DTESRV.REL R:LN2070.REL
APPEND R:LINEPR.REL,R:CDPSRV.REL,R:PLT.REL,R:PTP.REL,R:PTR.REL R:LN2070.REL
APPEND R:CDRSRV.REL,R:FILNFT.REL R:LN2070.REL
APPEND R:CRYPT.REL,R:DOB.REL R:LN2070.REL
APPEND R:CLUDGR.REL,R:CLUFRK.REL,R:POSTLD.REL R:LN2070.REL
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     