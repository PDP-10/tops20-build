!JOB%53B(71) TO MAKE CREF.EXE FROM CREF.MAC
!SUBMIT WITH COMMAND  CREF/RESTART:1
!
!
!COPYRIGHT (C) 1974,1977,1978,1979,1980,1981 BY
!DIGITAL EQUIPMENT CORPORATION, MAYNARD, MASS.
!
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
!
! Required source files:
!DSK:	CREF.MAC
!
! Required files (on SYS:):
!SYS:	HELPER.REL
!SYS:	UUOSYM.UNV
!
! Required programs (on SYS:):
!SYS:	MACRO.EXE
!SYS:	LINK.EXE
!SYS:	PA1050.EXE
!
! Output files:
!	CREF.EXE
!
! Output listing files:
!	CREF.CRF
!	CREF.MAP
!	CREF.LOG
!
!*********************************
!
@TAK BATCH.CMD
!
@I LOG ALL
!
@GET SYS:MACRO
@I VERSION
@GET SYS:LINK
@I VERSION
@GET SYS:PA1050
@I VERSION
!
!  Make a record of what is being used
!
@VDIRECT CREF.MAC,SYS:MACRO.EXE,SYS:LINK.EXE,SYS:PA1050.EXE,SYS:UUOSYM.UNV,SYS:HELPER.REL,
@CHECKSUM SEQ
@SEPARATE
@
!  Make CREF.EXE
!
@COMPILE/COMPILE/CREF CREF.MAC
@LINK
*/MAP, CREF.REL,SYS:HELPER.REL /GO
@SAVE
@GET CREF.EXE
@INFORMATION VERSION
@VDIRECT CREF.EXE,
@CHECKSUM
@
!
!  Test help file
!
@RUN CREF
*/H
@
!
!  Delete temporary files, and general cleanup
!
@
%FIN::
@DELETE CREF.REL
@
!End of CREF.CTL
