!GALGEN.CTL

!
!                COPYRIGHT (C) 1979,1980,1981,1982,1984,1987,1988
!                    DIGITAL EQUIPMENT CORPORATION
!
!     THIS SOFTWARE IS FURNISHED UNDER A LICENSE AND MAY  BE  USED
!     AND COPIED ONLY IN ACCORDANCE WITH THE TERMS OF SUCH LICENSE
!     AND WITH THE INCLUSION OF THE ABOVE COPYRIGHT NOTICE.   THIS
!     SOFTWARE  OR ANY OTHER COPIES THEREOF MAY NOT BE PROVIDED OR
!     OTHERWISE MADE AVAILABLE TO ANY OTHER PERSON.  NO  TITLE  TO

!     AND OWNERSHIP OF THE SOFTWARE IS HEREBY TRANSFERRED.
!
!     THE INFORMATION  IN  THIS  SOFTWARE  IS  SUBJECT  TO  CHANGE
!     WITHOUT  NOTICE  AND SHOULD NOT BE CONSTRUED AS A COMMITMENT
!     BY DIGITAL EQUIPMENT CORPORATION.
!
!     DIGITAL ASSUMES NO RESPONSIBILITY FOR THE USE OR RELIABILITY
!     OF  ITS  SOFTWARE  ON  EQUIPMENT  WHICH  IS  NOT SUPPLIED BY
!     DIGITAL.


!This Control File Assembles, Loads, and saves GALGEN

!System Files

!	MONSYM.UNV

!Required Files in Your Area

!	GLXMAC.UNV	Library Macro and Symbol Definitions
!	GLXLIB.REL	Library Load Module
!	QSRMAC.UNV

!Source Files

!	GALGEN.MAC

!Output Files

!	GALGEN.EXE

@TAKE BATCH.CMD

@DEF REL: DSK:,REL:
@DEF UNV: DSK:,UNV:

@VDIR	GALGEN.MAC

COMP::
@COMPILE/COMPILE GALGEN.MAC

@Load GALGEN

@SAVE GALGEN

@VDIRECT GALGEN.EXE,
@CHECK
@SE
@


@PLEASE	GALGEN Assembly Successful
@NOERROR
@MODIFY BATCH GALAXY/DEP:-1

%CERR::
%ERR::
@PLEASE	Error During GALGEN Assembly
%FIN::
