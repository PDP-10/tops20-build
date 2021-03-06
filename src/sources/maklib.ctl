! JOB %2B(104) TO MAKE MAKLIB.EXE FROM MAKLIB.MAC
! MAKLIB.CTL %2B, RELEASED WITH MAKLIB VERSION 2B
!SUBMIT WITH COMMAND MAKLIB/RESTART
!
!COPYRIGHT (C) 1975, 1981
!
!THIS SOFTWARE IS FURNISHED UNDER A LICENSE AND MAY BE USED AND COPIED
!ONLY  IN  ACCORDANCE  WITH  THE  TERMS  OF  SUCH LICENSE AND WITH THE
!INCLUSION OF THE ABOVE COPYRIGHT NOTICE.  THIS SOFTWARE OR ANY  OTHER
!COPIES THEREOF MAY NOT BE PROVIDED OR OTHERWISE MADE AVAILABLE TO ANY
!OTHER PERSON.  NO TITLE TO AND OWNERSHIP OF THE  SOFTWARE  IS  HEREBY
!TRANSFERRED.
!
!THE INFORMATION IN THIS SOFTWARE IS SUBJECT TO CHANGE WITHOUT  NOTICE
!AND  SHOULD  NOT  BE  CONSTRUED  AS A COMMITMENT BY DIGITAL EQUIPMENT
!CORPORATION.
!
!DIGITAL ASSUMES NO RESPONSIBILITY FOR THE USE OR RELIABILITY  OF  ITS
!SOFTWARE ON EQUIPMENT WHICH IS NOT SUPPLIED BY DIGITAL.
!
!
!THIS CONTROL FILE IS PROVIDED FOR INFORMATION PURPOSES ONLY.  THE
!PURPOSE OF THE FILE IS TO DOCUMENT THE PROCEDURES USED TO BUILD
!THE DISTRIBUTED SOFTWARE.  IT IS UNLIKELY TO BE ABLE TO BE EXECUTED
!WITHOUT MODIFICATION ON OTHER SYSTEMS.  IN PARTICULAR, ATTENTION
!SHOULD BE GIVEN TO ERSATZ DEVICES AND STRUCTURE NAMES, PPN'S AND
!OTHER SUCH SYSTEM PARAMETERS.  SUBMIT TIMES MAY VARY DEPENDING ON
!CONFIGURATION AND LOAD.  THE AVAILABILITY OF SUFFICIENT DISK SPACE
!AND CORE IS MANDATORY.  THIS CONTROL FILE HAS NOT BEEN EXTENSIVELY
!TESTED ON ALTERNATE CONFIGURATIONS.  IT HAS BEEN USED SUCCESSFULLY
!FOR THE PURPOSE FOR WHICH IT IS INTENDED: TO BUILD THE DISTRIBUTED
!SOFTWARE.
!
! SUBMIT WITH THE SWITCH "/TAG:CREF" TO OBTAIN
!   A .CRF LISTING OF THE SOURCE FILE
!
! REQUIRED FILES:
!
!SYS:	MACRO.EXE
!	LINK.EXE
!	PA1050.EXE
!	CREF.EXE
!	MACTEN.UNV
!	UUOSYM.UNV
!	SCNMAC.UNV
!     	SCAN.REL
!	WILD.REL
!	HELPER.REL
!
!DSK:	MAKLIB.MAC
!
! OUTPUT FILES:
!	MAKLIB.EXE
!
! OUTPUT LISTINGS:
!	MAKLIB.MAP
!	MAKLIB.LOG
!	MAKLIB.LST
!
@DEF FOO: NUL:
@GOTO A
!
CREF:: @DEF FOO: DSK:
!
A::
! Make a record of what is being used
!
@TAK BATCH.CMD
@INFO LOGICAL ALL
!
! Show what we are using for input
!
@VDIRECTORY MAKLIB.MAC,
@CHECKSUM SEQUENTIALLY
@SEPARATE
@
!
@VDIRECTORY SYS:MACRO.EXE,SYS:LINK.EXE,SYS:PA1050.EXE,SYS:CREF.EXE,
@CHECKSUM SEQUENTIALLY
@SEPARATE
@
!
@VDIRECTORY SYS:WILD.REL,SYS:SCAN.REL,SYS:HELPER.REL ,
@CHECKSUM SEQUENTIALLY
@SEPARATE
@
!
@VDIRECTORY SYS:MACTEN.UNV,SYS:UUOSYM.UNV,SYS:SCNMAC.UNV,
@CHECKSUM SEQUENTIALLY
@SEPARATE
@
!
@GET SYS:MACRO
@INFORMATION VERSION
@GET SYS:LINK
@INFORMATION VERSION
@GET SYS:PA1050
@INFORMATION VERSION
@GET SYS:CREF
@INFORMATION VERSION
!
! Create REL file
!
@COMPILE/CREF/COMPILE MAKLIB
!
! Make a CREF listing
!
@R CREF
*FOO:MAKLIB.LST=MAKLIB.CRF
!
!
! Create EXE file
!
@LOAD /MAP MAKLIB
@SAVE MAKLIB
@INFORMATION VERSION
!
! Try it just to make sure it works
!
@RUN DSK:MAKLIB
*TTY:=MAKLIB.REL/LIST
!
!
! Show what our output is
!
@VDIRECT MAKLIB.EXE,
@CHECKSUM SEQUENTIALLY
@SEPARATE
@
!
! Remove all temporary files
!
%FIN:
@DELETE MAKLIB.REL
@
!
![END OF MAKLIB.CTL]
