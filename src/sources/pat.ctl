;<6.UTILITIES>PAT.CTL.3,  1-Sep-84 12:06:46, Edit by PURRETTA
;<4.UTILITIES>PAT.CTL.2, 11-Apr-78 14:41:33, Edit by HELLIWELL
!
! NAME: PAT.CTL
! DATE: 1-SEP-84
!
!THIS CONTROL FILE IS PROVIDED FOR INFORMATION PURPOSES ONLY.  THE
!PURPOSE OF THE FILE IS TO DOCUMENT THE PROCEDURES USED TO BUILD
!THE DISTRIBUTED SOFTWARE.  IT IS UNLIKELY THAT THIS CONTROL FILE
!WILL BE ABLE TO BE SUBMITTED WITHOUT MODIFICATION ON CONSUMER
!SYSTEMS.  PARTICULAR ATTENTION SHOULD BE GIVEN TO ERSATZ DEVICES
!AND STRUCTURE NAMES, PPN'S, AND OTHER SUCH PARAMETERS.  SUBMIT
!TIMES MAY VARY DEPENDING ON SYSTEM CONFIGURATION AND LOAD.  THE
!AVAILABILITY OF SUFFICIENT DISK SPACE AND CORE IS MANDATORY.
!
! FUNCTION:	THIS CONTROL FILE BUILDS THE COMPATABILITY
!		PACKAGE (PAT) FROM ITS BASIC SOURCES.  A
!		EXE FILE WITH WRITE PROTECTION APPROPRIATE FOR
!		PLACEMENT IN SYS: IS ALSO CREATED.
!
! SUBMIT WITH THE SWITCH "/TAG:CREF" TO OBTAIN 
!   A .CRF LISTING OF THE SOURCE FILE
!
! Required source files:
!DSK:	PAT.MAC
!
! Required files (on SYS:):
!SYS:	MONSYM.UNV
!SYS:	MACSYM.UNV
!
! Required programs (on SYS:):
!SYS:	MACRO.EXE
!SYS:	LINK.EXE
!SYS:	PA1050.EXE
!SYS:	CREF.EXE
!
! Output files:
!	PAT.EXE
!	PA1050.EXE
!
! Output listing files:
!	PAT.LST
!
@DEF FOO: NUL:
@GOTO A
!
CREF:: @DEF FOO: DSK:
!
A::
@TAKE BATCH.CMD
!
@INFORMATION LOGICAL-NAMES ALL
!
! TAKE A CHECKSUMMED DIRECTORY OF ALL THE INPUT FILES
!
@VDIRECT SYS:MACRO.EXE,SYS:LINK.EXE,SYS:PA1050.EXE,SYS:CREF.EXE,SYS:*DDT.EXE,PAT.MAC,
@CHECKSUM SEQ
@
@VDIRECT SYS:MONSYM.UNV,SYS:MACSYM.UNV,
@CHECKSUM SEQ
@
@
@RUN SYS:MACRO
@INFORMATION VERSION
@GET SYS:LINK
@INFORMATION VERSION
@GET SYS:PA1050
@INFORMATION VERSION
@GET SYS:CREF
@INFORMATION VERSION
!
! Create PAT.EXE
!
@COMPILE /COMPILE/CREF PAT.MAC
@LOAD PAT.REL
!
@START
!
@INFORMATION MEMORY-USAGE
!
@SAVE PAT
!
! Write an EXE file with write protection
!
@GET PAT
@START
*MAKEPFG

!
@GET PA1050
@INFORMATION VERSION
!
! Create listing
!
@R CREF
*FOO:PAT.LST=PAT.CRF
!
@VDIRECT PAT.EXE,PA1050.EXE,
@CHECKSUM SEQ
@
!
! Delete unnecessary .REL files
! 
@DELETE PAT.REL
!
![End PAT.CTL]
