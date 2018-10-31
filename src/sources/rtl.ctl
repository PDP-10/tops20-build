! RTL.CTL
! Build the V1.1  RTL software from REL's
!
!	COPYRIGHT (C) DIGITAL EQUIPMENT CORPORATION 1984, 1986.
!	ALL RIGHTS RESERVED.
!
!	THIS SOFTWARE IS FURNISHED UNDER A LICENSE AND MAY  BE  USED  AND
!	COPIED ONLY IN ACCORDANCE WITH THE TERMS OF SUCH LICENSE AND WITH
!	THE INCLUSION OF THE ABOVE COPYRIGHT NOTICE.   THIS  SOFTWARE  OR
!	ANY  OTHER  COPIES  THEREOF MAY NOT BE PROVIDED OR OTHERWISE MADE
!	AVAILABLE TO ANY OTHER PERSON.  NO TITLE TO AND OWNERSHIP OF  THE
!	SOFTWARE IS HEREBY TRANSFERRED.
!
!	THE INFORMATION IN THIS SOFTWARE IS  SUBJECT  TO  CHANGE  WITHOUT
!	NOTICE  AND  SHOULD  NOT  BE CONSTRUED AS A COMMITMENT BY DIGITAL
!	EQUIPMENT CORPORATION.
!
!	DIGITAL ASSUMES NO RESPONSIBILITY FOR THE USE OR  RELIABILITY  OF
!	ITS SOFTWARE ON EQUIPMENT THAT IS NOT SUPPLIED BY DIGITAL.
!
! Submit connected to build directory.
!    @SUBMIT RTL/UNIQUE:NO/RESTART:YES/TIME:0:10:0
!
@NOERROR
@DEL DYNRL1.REL
@APPEND COPYR.REL,RTLDYN.REL,FAKDYN.REL,SIG.REL,MEM.REL,FACERR.REL,-
@  FAO.REL,DYNTRP.REL,MTHDYN.REL,RTLMSC.REL,-
@  DYNBOO.REL,RTLJCK.REL,RTLZER.REL,RTLLDB.REL,ZERBOO.REL DYNRL1.REL
@LINK
RTL.EXE/SAVE
RTL.MAP/MAP
DYNRL1/INCLUDE:(COPYR,RTLDYN,FAKDYN,SIG,MEM,FACERR,FAO,DYNTRP,MTHDYN,RTLMSC)
MTHLIB/SEARCH
SYS:MACREL
/GO
! 
! [51] Add checkpoint
BLD1::@CHKPNT BLD1
!
! Make PDV
@RUN RTL

! Make pure part read-only; this will get errors for pages that
! don't exist, but will set the rest correctly
@SET PAGE-ACCESS 400:763  NO WRITE  NO COPY-ON-WRITE
@SAVE RTL
!
! [51] Add GLOBbing
@GLOB
*DYNLIB=COPYR,DYNBOO,DYNTRP,FACERR,FAKDYN,FAO,MEM,MTHDYN
*DYNLIB=RTLMSC,RTLDYN,RTLZER,SIG,ZERBOO^[
*^Z
!
! [End of RTL.CTL]
    