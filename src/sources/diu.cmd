;Control file to fill the connected directory with DIU sources for building.
;@enable
;@DEFINE FROM: GREEN:<DATA-INTERCHANGE.DIU.V1>,GREEN:<RMS.3-BUILD>
;
;diu uses dil.rel
;
COPY FROM-SOURCE:DIL.REL		TO-SOURCE:
;
;DOC AND HLP FILES
;
COPY FROM-SOURCE:DIU.HLP		TO-SUBSYS:
COPY FROM-DOC:DIU.DOC			TO-DOC:
COPY FROM-DOC:DIU1.BWR			TO-DOC:
COPY FROM-DOC:DIU1.DOC			TO-DOC:
;
;FINAL PRODUCT
;
COPY FROM-SUBSYS:DIU.EXE		TO-SUBSYS:
;
;SOURCES
;
COPY FROM-SOURCE:DIU.CTL		TO-SOURCE:
COPY FROM-SOURCE:DIU.CMD		TO-SOURCE:
COPY FROM-SOURCE:ACTSYM.R36		TO-SOURCE:
COPY FROM-SOURCE:BLISSNET.REQ		TO-SOURCE:
COPY FROM-SOURCE:BLISSNET20.R36		TO-SOURCE:
COPY FROM-SOURCE:CONDIT.REQ		TO-SOURCE:
COPY FROM-SOURCE:DAP.REQ		TO-SOURCE:
COPY FROM-SOURCE:DAPERR.B36		TO-SOURCE:
COPY FROM-SOURCE:DIU.R36		TO-SOURCE:
COPY FROM-SOURCE:DIU.RNH		TO-SOURCE:
COPY FROM-SOURCE:DIU1.CTL		TO-SOURCE:
COPY FROM-SOURCE:DIU1.RND		TO-SOURCE:
COPY FROM-SOURCE:DIU1.RNO		TO-SOURCE:
COPY FROM-SOURCE:DIU20.B36		TO-SOURCE:
COPY FROM-SOURCE:DIUACN.BLI		TO-SOURCE:
COPY FROM-SOURCE:DIUACT.B36		TO-SOURCE:
COPY FROM-SOURCE:DIUACTION.REQ		TO-SOURCE:
COPY FROM-SOURCE:DIUASK.B36		TO-SOURCE:
COPY FROM-SOURCE:DIUAU1.BLI		TO-SOURCE:
COPY FROM-SOURCE:DIUAU2.BLI		TO-SOURCE:
COPY FROM-SOURCE:DIUC20.B36		TO-SOURCE:
COPY FROM-SOURCE:DIUCLE.BLI		TO-SOURCE:
COPY FROM-SOURCE:DIUCMD.B36		TO-SOURCE:
COPY FROM-SOURCE:DIUCOMMAND.R36		TO-SOURCE:
COPY FROM-SOURCE:DIUCRX.REQ		TO-SOURCE:
COPY FROM-SOURCE:DIUCSR.B36		TO-SOURCE:
COPY FROM-SOURCE:DIUD.CTL		TO-SOURCE:
COPY FROM-SOURCE:DIUDAT.BLI		TO-SOURCE:
COPY FROM-SOURCE:DIUDDL.REQ		TO-SOURCE:
COPY FROM-SOURCE:DIUDEB.BLI		TO-SOURCE:
COPY FROM-SOURCE:DIUDEB.REQ		TO-SOURCE:
COPY FROM-SOURCE:DIUDEF.B36		TO-SOURCE:
COPY FROM-SOURCE:DIUDIR.B36		TO-SOURCE:
COPY FROM-SOURCE:DIUDIS.BLI		TO-SOURCE:
COPY FROM-SOURCE:DIUDIX.R36		TO-SOURCE:
COPY FROM-SOURCE:DIUDMP.BLI		TO-SOURCE:
COPY FROM-SOURCE:DIUDO.B36		TO-SOURCE:
COPY FROM-SOURCE:DIUERR.B36		TO-SOURCE:
COPY FROM-SOURCE:DIUETR.BLI		TO-SOURCE:
COPY FROM-SOURCE:DIUGTR.BLI		TO-SOURCE:
COPY FROM-SOURCE:DIUHLP.B36		TO-SOURCE:
COPY FROM-SOURCE:DIUIP2.B36		TO-SOURCE:
COPY FROM-SOURCE:DIUIP2.R36		TO-SOURCE:
COPY FROM-SOURCE:DIUJB2.B36		TO-SOURCE:
COPY FROM-SOURCE:DIULAN.BLI		TO-SOURCE:
COPY FROM-SOURCE:DIULEX.BLI		TO-SOURCE:
COPY FROM-SOURCE:DIULG2.B36		TO-SOURCE:
COPY FROM-SOURCE:DIULRT.BLI		TO-SOURCE:
COPY FROM-SOURCE:DIULTR.BLI		TO-SOURCE:
COPY FROM-SOURCE:DIUMAP.BLI		TO-SOURCE:
COPY FROM-SOURCE:DIUMAT.BLI		TO-SOURCE:
COPY FROM-SOURCE:DIUMLB.bli		TO-SOURCE:
COPY FROM-SOURCE:DIUMMP.BLI		TO-SOURCE:
COPY FROM-SOURCE:DIUMOD.B36		TO-SOURCE:
COPY FROM-SOURCE:DIUNOT.B36		TO-SOURCE:
COPY FROM-SOURCE:DIUPAR.BLI		TO-SOURCE:
COPY FROM-SOURCE:DIUPATBLSEXT.REQ	TO-SOURCE:
COPY FROM-SOURCE:DIUPATBLSEXT.REQ	TO-SOURCE:
COPY FROM-SOURCE:DIUPATDATA.REQ		TO-SOURCE:
COPY FROM-SOURCE:DIUPATDATA.REQ		TO-SOURCE:
COPY FROM-SOURCE:DIUPATDEB.REQ		TO-SOURCE:
COPY FROM-SOURCE:DIUPATERROR.REQ	TO-SOURCE:
COPY FROM-SOURCE:DIUPATLANGSP.REQ	TO-SOURCE:
COPY FROM-SOURCE:DIUPATLANGSP.REQ	TO-SOURCE:
COPY FROM-SOURCE:DIUPATLRTUNE.REQ	TO-SOURCE:
COPY FROM-SOURCE:DIUPATPARSER.REQ	TO-SOURCE:
COPY FROM-SOURCE:DIUPATPORTAL.REQ	TO-SOURCE:
COPY FROM-SOURCE:DIUPATPROLOG.REQ	TO-SOURCE:
COPY FROM-SOURCE:DIUPATREQPRO.REQ	TO-SOURCE:
COPY FROM-SOURCE:DIUPATSWITCH.REQ	TO-SOURCE:
COPY FROM-SOURCE:DIUPATTOKEN.REQ	TO-SOURCE:
COPY FROM-SOURCE:DIUPC2.B36		TO-SOURCE:
COPY FROM-SOURCE:DIUPDB.BLI		TO-SOURCE:
COPY FROM-SOURCE:DIUPER.BLI		TO-SOURCE:
COPY FROM-SOURCE:DIUPOR.BLI		TO-SOURCE:
COPY FROM-SOURCE:DIUPS2.B36		TO-SOURCE:
COPY FROM-SOURCE:DIUQUE.B36		TO-SOURCE:
COPY FROM-SOURCE:DIUQUT.B36		TO-SOURCE:
COPY FROM-SOURCE:DIUSCH.B36		TO-SOURCE:
COPY FROM-SOURCE:DIUSEM.BLI		TO-SOURCE:
COPY FROM-SOURCE:DIUSHD.B36		TO-SOURCE:
COPY FROM-SOURCE:DIUSHO.B36		TO-SOURCE:
COPY FROM-SOURCE:DIUSPL.B36		TO-SOURCE:
COPY FROM-SOURCE:DIUSTR.B36		TO-SOURCE:
COPY FROM-SOURCE:DIUT20.B36		TO-SOURCE:
COPY FROM-SOURCE:DIUTLB.bli		TO-SOURCE:
COPY FROM-SOURCE:DIUTOK.BLI		TO-SOURCE:
COPY FROM-SOURCE:DIUTPA.B36		TO-SOURCE:
COPY FROM-SOURCE:DIUTPAMAC.R36		TO-SOURCE:
COPY FROM-SOURCE:DIUTUT.BLI		TO-SOURCE:
COPY FROM-SOURCE:DIUVER.MAC		TO-SOURCE:
COPY FROM-SOURCE:DIUWLD.B36		TO-SOURCE:
COPY FROM-SOURCE:DIXB36.R36		TO-SOURCE:
COPY FROM-SOURCE:FAO.B36		TO-SOURCE:
COPY FROM-SOURCE:FAO.R36		TO-SOURCE:
COPY FROM-SOURCE:FAOPUT.bli		TO-SOURCE:
COPY FROM-SOURCE:JSYSDEF.R36		TO-SOURCE:
COPY FROM-SOURCE:MONSYM.R36		TO-SOURCE:
COPY FROM-SOURCE:RMSERM.B36		TO-SOURCE:
COPY FROM-SOURCE:RMSERT.B36		TO-SOURCE:
COPY FROM-SOURCE:RMSUSR.R36		TO-SOURCE:
COPY FROM-SOURCE:TOPS20.R36		TO-SOURCE:
COPY FROM-SOURCE:XPNERR.B36		TO-SOURCE:
COPY FROM-SOURCE:XPNPSI.MAC		TO-SOURCE:
