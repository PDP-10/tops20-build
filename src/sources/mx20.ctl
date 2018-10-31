!++
!   MX20.CTL
!
!       This file is used to build MX. It assumes all the sources will be
!	 in the connected directory.
!
!       The EXE and all the RELs will be created in the connected directory.
!	The .RELs are given approprate Copyright protection.
!
!--
@SET TRAP FILE
@BLISS
!
!Compile the libraries
!
*mxnlib/lib
*mxlib/lib
*tbl/lib
!
!Compile the nml-maintained modules
!
*m20int
*mxnmem
*mxnpag
*mxnque
*mxntbl
*mxntxt
!
!Compile the mx-maintained modules
!
*mxdata
*mxhost
*mxlcl
*mxqman
*mxufil
*tbl
*mxerr
*mxdcnt
*m20ipc
*mxnskd
*mxnnet
*/exit
!
!Assemble the macro modules.
!
@MACRO
*cpyryt=cpyryt
*senvax=senvax
*lisvax=lisvax
*smtsen=smtsen
*smtlis=smtlis
*mxnt20=mxnt20
*nettab=nettab
*mxver=mxver
*^z
!
!Prepend copyright information to each .REL file
!
APPEND::
@RENAME m20int.REL TEMP.REL
@COPY CPYRYT.REL m20int.REL
@APPEND TEMP.REL m20int.REL
@RENAME m20ipc.REL TEMP.REL
@COPY CPYRYT.REL m20ipc.REL
@APPEND TEMP.REL m20ipc.REL
@RENAME mxnmem.REL TEMP.REL
@COPY CPYRYT.REL mxnmem.REL
@APPEND TEMP.REL mxnmem.REL
@RENAME mxnpag.REL TEMP.REL
@COPY CPYRYT.REL mxnpag.REL
@APPEND TEMP.REL mxnpag.REL
@RENAME mxnque.REL TEMP.REL
@COPY CPYRYT.REL mxnque.REL
@APPEND TEMP.REL mxnque.REL
@RENAME mxnskd.REL TEMP.REL
@COPY CPYRYT.REL mxnskd.REL
@APPEND TEMP.REL mxnskd.REL
@RENAME mxnt20.REL TEMP.REL
@COPY CPYRYT.REL mxnt20.REL
@APPEND TEMP.REL mxnt20.REL
@RENAME mxntbl.REL TEMP.REL
@COPY CPYRYT.REL mxntbl.REL
@APPEND TEMP.REL mxntbl.REL
@RENAME mxntxt.REL TEMP.REL
@COPY CPYRYT.REL mxntxt.REL
@APPEND TEMP.REL mxntxt.REL
@RENAME mxnnet.REL TEMP.REL
@COPY CPYRYT.REL mxnnet.REL
@APPEND TEMP.REL mxnnet.REL
@RENAME mxdata.REL TEMP.REL
@COPY CPYRYT.REL mxdata.REL
@APPEND TEMP.REL mxdata.REL
@RENAME mxhost.REL TEMP.REL
@COPY CPYRYT.REL mxhost.REL
@APPEND TEMP.REL mxhost.REL
@RENAME mxlcl.REL TEMP.REL
@COPY CPYRYT.REL mxlcl.REL
@APPEND TEMP.REL mxlcl.REL
@RENAME mxqman.REL TEMP.REL
@COPY CPYRYT.REL mxqman.REL
@APPEND TEMP.REL mxqman.REL
@RENAME mxufil.REL TEMP.REL
@COPY CPYRYT.REL mxufil.REL
@APPEND TEMP.REL mxufil.REL
@RENAME mxerr.REL TEMP.REL
@COPY CPYRYT.REL mxerr.REL
@APPEND TEMP.REL mxerr.REL
@RENAME mxdcnt.REL TEMP.REL
@COPY CPYRYT.REL mxdcnt.REL
@APPEND TEMP.REL mxdcnt.REL
@RENAME tbl.REL TEMP.REL
@COPY CPYRYT.REL tbl.REL
@APPEND TEMP.REL tbl.REL
@RENAME nettab.REL TEMP.REL
@COPY CPYRYT.REL nettab.REL
@APPEND TEMP.REL nettab.REL
@RENAME mxver.REL TEMP.REL
@COPY CPYRYT.REL mxver.REL
@APPEND TEMP.REL mxver.REL
@RENAME smtlis.REL TEMP.REL
@COPY CPYRYT.REL smtlis.REL
@APPEND TEMP.REL smtlis.REL
@RENAME smtsen.REL TEMP.REL
@COPY CPYRYT.REL smtsen.REL
@APPEND TEMP.REL smtsen.REL
@RENAME senvax.REL TEMP.REL
@COPY CPYRYT.REL senvax.REL
@APPEND TEMP.REL senvax.REL
@RENAME lisvax.REL TEMP.REL
@COPY CPYRYT.REL lisvax.REL
@APPEND TEMP.REL lisvax.REL
@DELETE TEMP.REL
@EXPUNGE
!
!Link all modules
!
@LINK
*m20int,-
*m20ipc,-
*mxnmem,-
*mxnpag,-
*mxnque,-
*mxnskd,-
*mxnt20,-
*mxntbl,-
*mxntxt,-
*mxnnet,-
*mxdata,-
*mxhost,-
*mxlcl,-
*mxqman,-
*mxufil,-
*mxerr,-
*mxdcnt,-
*tbl,-
*nettab,-
*mxver,-
*smtlis,-
*smtsen,-
*senvax,-
*lisvax
*/save MX
*/go
@
