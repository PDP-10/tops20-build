! UPD ID= 8674, RIP:<7.MONITOR>LN2070.CTL.9,   1-Mar-88 16:00:05 by GSCOTT
;TCO 7.1245 - Add tag MONDEV which builds 2060-MONMAX from sources.
! UPD ID= 8395, RIP:<7.MONITOR>LN2070.CTL.8,  27-Jan-88 11:17:35 by GSCOTT
;More of TCO 7.1195 - Set EDDTF in all monitor builds.
! UPD ID= 8381, RIP:<7.MONITOR>LN2070.CTL.7,  24-Jan-88 23:37:51 by GSCOTT
;More of TCO 7.1195 - A stray "v" at MLINK2, thanks DF112
! UPD ID= 8378, RIP:<7.MONITOR>LN2070.CTL.5,  22-Jan-88 16:45:45 by GSCOTT
;More of TCO 7.1195 - Add tags for linking (doesn't compile STG or VERSIO).
! UPD ID= 8374, RIP:<7.MONITOR>LN2070.CTL.3,  22-Jan-88 11:52:50 by GSCOTT
;More of TCO 7.1195 - put all local mods into a single file
! UPD ID= 8365, RIP:<7.MONITOR>LN2070.CTL.2,  22-Jan-88 11:11:25 by GSCOTT
;TCO 7.1195 - Rework pass 2 PSECT stuff and make APPEND.CMD do the appends.
;This means that modules can be added by modifying APPEND.CMD, and that LNKNEW
;and PARNEW are used immediately.  Also make tag SINGLE work.
! UPD ID= 8354, RIP:<7.MONITOR>LN2070.CTL.11,  20-Jan-88 11:40:09 by RASPUZZI
;TCO 7.1190 - CFSSRV is split into CFSSRV and CFSUSR.
! UPD ID= 210, RIP:<7.MONITOR>LN2070.CTL.10,  23-Oct-87 15:50:25 by GSCOTT
;TCO 7.1081 - Add DOB to APPENDed files
! UPD ID= 189, RIP:<7.MONITOR>LN2070.CTL.9,  21-Oct-87 17:38:20 by RASPUZZI
;TCO 7.1076 - Add CLUFRK and CLUDGR to APPENDed files.
! UPD ID= 168, RIP:<7.MONITOR>LN2070.CTL.8,  19-Oct-87 17:17:35 by LOMARTIRE
;TCO 7.1072 - Add ENQSRV to APPENDed files
;RIP:<7.MONITOR>LN2070.CTL.4,  28-Aug-87 13:30:00, Edit by LOMARTIRE
;Add the /COUNTERS so PSECT overflow fixup is easier
;RIP:<7.MONITOR>LN2070.CTL.4,  5-Aug-87 13:30:00, Edit by LOMARTIRE
;Do not do a DIR of 2070-*
;RIP:<7.MONITOR>LN2070.CTL.1,  4-Aug-87 14:30:00, Edit by WADDINGTON
;Use N70BIG.MAC, P70BIG.MAC, N70MAX.MAC, P70MAX.MAC, P7BLNK.CCL & P7MLNK.CCL
;instead of 60's leftovers.  (Cosmetic change)
;RIP:<7.MONITOR>LN2070.CTL.1,  18-May-87 9:00:00, Edit by LOMARTIRE
;Convert from 6.1 Autopatch to 7.0 Development
;SNARK:<WEEKLY>LN2061W.CTL.21 28-Feb-86 15:08:21, Edit by MCCOLLUM
;Set SAVTRE to -1 and DTBUGX to 0 in DDT section of all monitor builds
;USE THIS FOR 6.1 MAINTENANCE BUILDS - MAKE AN LN2061.REL  EVANS 13-AUG-85
;REL61:<BUILD.MONITOR>LN2060.CTL.2 21-Aug-85 15:13:35, Edit by DMCDANIEL
;Change from using single LNK files to seperate ones.
! UPD ID= 4038, SNARK:<6.MONITOR>LN2060.CTL.40,   2-Apr-84 11:20:02 by PURRETTA
! UPD ID= 3999, SNARK:<6.MONITOR>LN2060.CTL.39,  28-Mar-84 20:40:30 by PURRETTA
! UPD ID= 3760, SNARK:<6.MONITOR>LN2060.CTL.38,  26-Feb-84 16:33:20 by PURRETTA
! UPD ID= 3734, SNARK:<6.MONITOR>LN2060.CTL.37,  22-Feb-84 16:16:48 by PURRETTA
;<6.MONITOR>LN2060.CTL.35,  1-Feb-84 22:24:16, EDIT BY MURPHY
! UPD ID= 3147, SNARK:<6.MONITOR>LN2060.CTL.33,  15-Nov-83 00:38:16 by MOSER
;ADD PHYMVR
;<6.MONITOR>LN2060.CTL.30, 27-Jul-83 12:25:38, Edit by PURRETTA
;Remove KCCNSL
;Automatic re-link if PSECT overlaps.
;<6.MONITOR>LN2060.CTL.27, 14-May-83 13:29:39, Edit by PURRETTA
;Split ASEMBL.CMD into ASMBL1.CMD and ASMBL2.CMD
! UPD ID= 2320, SNARK:<6.MONITOR>LN2060.CTL.26,  20-Apr-83 16:51:31 by HALL
!Try again on previous edit
! UPD ID= 2318, SNARK:<6.MONITOR>LN2060.CTL.25,  20-Apr-83 13:14:14 by HALL
!Add CTSMON
! UPD ID= 2316, SNARK:<6.MONITOR>LN2060.CTL.24,  20-Apr-83 11:40:51 by HALL
!Really remove CISRV and LCSSRV
! UPD ID= 2315, SNARK:<6.MONITOR>LN2060.CTL.23,  20-Apr-83 07:37:52 by HALL
!Fix typo in previous edit. Remove PAGFIL
! UPD ID= 1921, SNARK:<6.MONITOR>LN2060.CTL.20,   7-Mar-83 20:14:20 by CDUNN
!Add SCAMPI, SCSJSY, CFSSRV, PHYKLP, and PHYMSC
! UPD ID= 1665, SNARK:<6.MONITOR>LN2060.CTL.19,  16-Jan-83 21:39:12 by GRANT
!TCO 6.1454 - Add NTMAN and remove NSPINT
! UPD ID= 1658, SNARK:<6.MONITOR>LN2060.CTL.18,  14-Jan-83 08:06:48 by HALL
!TCO 6.1463 - SPILT PAGEM INTO 3 MODULES
! UPD ID= 1144, SNARK:<6.MONITOR>LN2060.CTL.17,   3-Sep-82 18:35:57 by LEACHE
!Add CRYPT
!
! NAME: LN2070.CTL
! DATE: 21-JUN-78
!
!
! FUNCTION:	THIS CONTROL FILE BUILDS THE LN2070
!		MONITORS FROM SOURCES.
!
!TO ASSEMBLE AND BUILD ALL STANDARD LN2070 MONITORS:
!SUBMIT LN2070/TIME:2:0:0
!
!TO LOAD ALL STANDARD LN2070 MONITORS USING LN2070.REL:
!SUBMIT LN2070/TAG:ALL/TIME:1:0:0
!
!TO LOAD JUST ONE LN2070 MONITOR USING PARAM0 AND LN2070.REL:
!SUBMIT LN2070/TAG:SINGLE/TIME:1:0:0
!


@GOTO BEGIN

TRAP::
@SET TRAP FILE-OPENINGS
@GOTO BEGIN

FORCE::
@SET DEFAULT COMPILE MAC /COMPILE
@GOTO BEGIN

CREF::
@SET DEFAULT COMPILE MAC /CREF
@GOTO BEGIN

BEGIN::

! Local mods go here

@TAKE BATCH.CMD

! List all logical names

@INFORMATION LOGICAL-NAMES ALL

! Take a checksummed directory of all the input files, get versions

@VDIRECT SYS:LINK.EXE.0,SYS:CREF.EXE.0,SYS:MACRO.EXE.0,SYS:PA1050.EXE.0,
@CHECKSUM SEQ
@
@VDIRECT SYS:MONSYM.UNV.0,SYS:MACSYM.UNV.0,SYS:MACREL.REL.0,
@CHECKSUM SEQ
@
@
@R MACRO
@INFORMATION VERSION
@R LINK
@INFORMATION VERSION
@R CREF
@INFORMATION VERSION

! Before doing anything, see if we are connected to a reasonable directory.  A
! reasonable directory will have SYSFLG.MAC which determines processor
! conditionals.  Also, you will see what processor you are assembling for.

@TYPE MON:SYSFLG.MAC
@IF(ERROR) @GOTO E

! Compile the source modules

COMPIL::
@TAKE MON:ASEMBL.CMD

! Make the library file

APPEND::
@TAKE MON:APPEND.CMD

@GOTO ALL1

ALL::

! Build 2020-MONBIG and 2060-MONMAX monitors using LN2070.REL

! Local mods go here

@TAKE BATCH.CMD

! Get all logical names listed

@INFORMATION LOGICAL-NAMES ALL

! Take a checksummed directory of all the input files, get versions

@VDIRECT SYS:LINK.EXE.0,SYS:CREF.EXE.0,SYS:MACRO.EXE.0,SYS:PA1050.EXE.0,
@CHECKSUM SEQ
@
@VDIRECT SYS:MONSYM.UNV.0,SYS:MACSYM.UNV.0,SYS:MACREL.REL.0,
@CHECKSUM SEQ
@
@
@R MACRO
@INFORMATION VERSION
@R LINK
@INFORMATION VERSION
@R CREF
@INFORMATION VERSION

ALL1::


MONBIG::
@CHKPNT MONBIG
!
! Build a 2060-MONBIG
!
! Uses the following files:
!	LNKLBG.CCL
!	PARLBG.MAC
!	MON:N70BIG.MAC
!	MON:P70BIG.MAC
!	MON:VERSIO.MAC
!	MON:PARAMS.MAC
!	MON:STG.MAC
!	MON:LN2070.REL

! Local mods go here

@TAKE BATCH.CMD

! Build STG and VERSIO

@DELETE MON.*,STG.REL,VERSIO.REL
@EXPUNG
@COMPILE /COMP MON:N70BIG.MAC+MON:VEDIT.MAC+MON:VERSIO.MAC R:VERSIO
@COMPILE /COMP MON:P70BIG.MAC+MON:PARLBG.MAC+MON:PARAMS.MAC+MON:STG.MAC R:STG

! Link monitor

BLINK::
@R LINK
*@LNKLBG.CCL
*@MON:LNKINI.CCL
*LN2070/S, -
*/NOLOCALS, -
*/SYSLIB, -
*/COUNTERS, -
*/G
@EXP
@GET MON
@IF (ERROR) @GOTO BMNOK
@START 142
*06M
=BUGHLT<HLTADR12B
=BUGCHK<CHKADR11B
=G
@IF (NOERROR) @GOTO BMOK

! Try again with revised PSECTs

BLINK2::
@DELETE MON.*,STG.REL
@EXPUNG
@COMPILE /COMP MON:P70BIG.MAC+PARNEW.MAC+MON:PARAMS.MAC+MON:STG.MAC STG
@R LINK
*@LNKNEW.CCL
*@MON:LNKINI.CCL
*LN2070/S, -
*/NOLOCALS, -
*/SYSLIB, -
*/COUNT/G
@EXP
@GET MON
@IF (ERROR) @GOTO BMNOK
@START 142
*06M
=BUGHLT<HLTADR12B
=BUGCHK<CHKADR11B
=G
@COPY LNKLBG.CCL.0 LNKLBG.OLD
@COPY PARLBG.MAC.0 PARLBG.OLD
@COPY LNKNEW.CCL.0 LNKLBG.CCL
@COPY PARNEW.MAC.0 PARLBG.MAC
BMOK::
@RENAME MONITR.EXE.0 2060-MONBIG.EXE
BMNOK::
@GOTO MONMAX



MONDEV::

! Quick build of the monitor for development, makes 2060-MONMAX like MONMAX
! does, however MONDEV compiles all sources first.  Uses all of the files that
! MONMAX does plus must have access to all sources referred to in ASEMBL and
! APPEND.CMD.  No checksummed directories or logical name listings are done
! here.

! Local mods go here

@TAKE BATCH.CMD

! Assemble the sources

@TAKE MON:ASEMBL.CMD

! Create the library file

APPEND::
@TAKE MON:APPEND.CMD



MONMAX::
@CHKPNT MONMAX
!
! Build a 2060-MONMAX monitor
!
! Uses the following files:
!	LNKLMX.CCL
!	PARLMX.MAC
!	MON:N70MAX.MAC
!	MON:P70MAX.MAC
!	MON:VERSIO.MAC
!	MON:PARAMS.MAC
!	MON:STG.MAC
!	MON:LN2070.REL

! Local mods go here

@TAKE BATCH.CMD

! Build STG and VERSIO

@DELETE MON.*,STG.REL,VERSIO.REL
@EXPUNG
@COMPILE /COMP MON:N70MAX.MAC+MON:VEDIT.MAC+MON:VERSIO.MAC R:VERSIO
@COMPILE /COMP MON:P70MAX.MAC+MON:PARLMX.MAC+MON:PARAMS.MAC+MON:STG.MAC R:STG

! Link monitor

MLINK::
@R LINK
*@LNKLMX.CCL
*@MON:LNKINI.CCL
*LN2070/S, -
*/NOLOCALS, -
*/SYSLIB, -
*/COUNTERS, -
*/G
@EXP
@GET MON
@IF (ERROR) @GOTO MMNOK
@START 142
*06M
=BUGHLT<HLTADR12B
=BUGCHK<CHKADR11B
=G
@IF (NOERROR) @GOTO MMOK

! Try again with revised PSECTs

MLINK2::
@DELETE MON.*,STG.REL
@EXPUNG
@COMPILE /COMP MON:P70MAX.MAC+PARNEW.MAC+MON:PARAMS.MAC+MON:STG.MAC STG
@R LINK
*@LNKNEW.CCL
*@MON:LNKINI.CCL
*LN2070/S, -
*/NOLOCALS, -
*/SYSLIB, -
*/COUNTERS, -
*/G
@EXP
@GET MON
@IF (ERROR) @GOTO MMNOK
@START 142
*06M
=BUGHLT<HLTADR12B
=BUGCHK<CHKADR11B
=G
@COPY LNKLMX.CCL.0 LNKLMX.OLD
@COPY PARLMX.MAC.0 PARLMX.OLD
@COPY LNKNEW.CCL.0 LNKLMX.CCL
@COPY PARNEW.MAC.0 PARLMX.MAC
MMOK::
@RENAME MONITR.EXE.0 2060-MONMAX.EXE
MMNOK::
@DIR 2060-*.EXE.0,
@CHECKSUM SEQ
@
@GOTO E


SINGLE::
!
! Build customer MONITR.EXE using PARAM0, NAMAM0, and LN2070.REL
!
! Uses the following files:
!	LNKLM0.CCL
!	PARLM0.MAC
!	MON:NAMAM0.MAC
!	MON:PARAM0.MAC
!	MON:VERSIO.MAC
!	MON:PARAMS.MAC
!	MON:STG.MAC
!	MON:LN2070.REL

! Local mods go here

@TAKE BATCH.CMD

! Get logical name listing

@INFORMATION LOGICAL-NAMES ALL

! Take a checksummed directory of all the input files, get versions

@VDIRECT SYS:LINK.EXE.0,SYS:CREF.EXE.0,SYS:MACRO.EXE.0,SYS:PA1050.EXE.0,
@CHECKSUM SEQ
@
@VDIRECT SYS:MONSYM.UNV.0,SYS:MACSYM.UNV.0,SYS:MACREL.REL.0,
@CHECKSUM SEQ
@
@
@R MACRO
@INFORMATION VERSION
@R LINK
@INFORMATION VERSION
@R CREF
@INFORMATION VERSION

! Build STG and VERSIO

@DELETE MON.*,STG.REL,VERSIO.REL,MONITR.EXE
@EXPUNG
@COMPILE /COMP MON:NAMAM0.MAC+MON:VEDIT.MAC+MON:VERSIO.MAC R:VERSIO
@COMPILE /COMP MON:PARAM0.MAC+MON:PARLM0.MAC+MON:PARAMS.MAC+MON:STG.MAC R:STG

! Link monitor

SLINK::
@R LINK
*@LNKLM0.CCL
*@MON:LNKINI.CCL
*LN2070/S, -
*/NOLOCALS, -
*/SYSLIB, -
*/COUNTERS, -
*/G
@EXP
@GET MON
@IF (ERROR) @GOTO MNOK
@START 142
*06M
=BUGHLT<HLTADR12B
=BUGCHK<CHKADR11B
G
@IF (NOERROR) @GOTO MOK

! Try again with revised PSECTs

SLINK2::
@DELETE MON.*,STG.REL
@EXPUNG
@COMPILE /COMP MON:PARAM0.MAC+PARNEW.MAC+MON:PARAMS.MAC+MON:STG.MAC STG
@R LINK
*@LNKNEW.CCL
*@MON:LNKINI.CCL
*LN2070/S, -
*/NOLOCALS, -
*/SYSLIB, -
*/COUNTERS, -
*/G
@EXP
@GET MON
@IF (ERROR) @GOTO MNOK
@START 142
*06M
=BUGHLT<HLTADR12B
=BUGCHK<CHKADR11B
=G
@COPY LNKLM0.CCL.0 LNKLM0.OLD
@COPY PARLM0.MAC.0 PARLM0.OLD
@COPY LNKNEW.CCL.0 LNKLM0.CCL
@COPY PARNEW.MAC.0 PARLM0.MAC
MOK::
@DIR MONITR.EXE.0,
@CHECKSUM SEQ
@
MNOK::


%ERR::
E::
!
@DELETE MON.*
!END OF LN2070.CTL
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      