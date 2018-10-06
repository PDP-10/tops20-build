;  CMD file used to copy the bundled Monitor components

INFORMATION LOGICAL FROM*:
INFORMATION LOGICAL TO*:

;Documentation files
COPY FROM-SOURCE:ACJ.MEM TO-DOC:*.*.-1
COPY FROM-SOURCE:BUGS.MAC TO-SYSTEM:*.*.-1
COPY FROM-SOURCE:BUILD.MEM TO-DOC:*.*.-1
COPY FROM-SOURCE:EAPGMG.MEM TO-DOC:*.*.-1
COPY FROM-SOURCE:TOPS20.BWR TO-DOC:*.*.-1
COPY FROM-SOURCE:TOPS20.BWR TO-SYSTEM:*.*.-1
COPY FROM-SOURCE:TOPS20.DOC TO-DOC:*.*.-1
COPY FROM-SOURCE:TOPS20.DOC TO-SYSTEM:*.*.-1
COPY FROM-SOURCE:TOPS20.TCO TO-DOC:*.*.-1

;Monitor CMD files
COPY FROM-SOURCE:ASEMBL.CMD TO-SOURCE:*.*.-1
COPY FROM-SOURCE:APPEND.CMD TO-SOURCE:*.*.-1
COPY FROM-SOURCE:MONITR.CMD TO-SOURCE:*.*.-1

;Monitor CTL files
COPY FROM-SOURCE:LN2070.CTL TO-SOURCE:*.*.-1
COPY FROM-SOURCE:SYSTAP.CTL TO-SOURCE:*.*.-1

;Monitor CCL files
COPY FROM-SOURCE:LNKINI.CCL TO-SOURCE:*.*.-1
COPY FROM-SOURCE:LNKLBG.CCL TO-SOURCE:*.*.-1
COPY FROM-SOURCE:LNKLMX.CCL TO-SOURCE:*.*.-1
COPY FROM-SOURCE:LNKLM0.CCL TO-SOURCE:*.*.-1

;Files required to build product
COPY FROM-SOURCE:N70BIG.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:N70MAX.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:NAMAM0.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:P70BIG.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:P70MAX.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:PARAM0.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:PARLBG.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:PARLMX.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:PARLM0.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:PARAMS.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:STG.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:SYSFLG.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:VEDIT.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:VERSIO.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:KDDT.REL TO-SUBSYS:*.*.-1
COPY FROM-SOURCE:MDDT.REL TO-SUBSYS:*.*.-1

;Files required to build BOOT
COPY FROM-SOURCE:PMT.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:RP2.MAC TO-SOURCE:*.*.-1

;Library files used for symbols
COPY FROM-SOURCE:CTERMD.UNV TO-SUBSYS:*.*.-1
COPY FROM-SOURCE:D36PAR.UNV TO-SUBSYS:*.*.-1
COPY FROM-SOURCE:GLOBS.UNV TO-SUBSYS:*.*.-1
COPY FROM-SOURCE:MSCPAR.UNV TO-SUBSYS:*.*.-1
COPY FROM-SOURCE:PHYPAR.UNV TO-SUBSYS:*.*.-1
COPY FROM-SOURCE:PROLOG.UNV TO-SUBSYS:*.*.-1
COPY FROM-SOURCE:SCPAR.UNV TO-SUBSYS:*.*.-1
COPY FROM-SOURCE:SCAPAR.UNV TO-SUBSYS:*.*.-1
COPY FROM-SOURCE:SERCOD.UNV TO-SUBSYS:*.*.-1

;Final product
COPY FROM-SOURCE:2060-MONBIG.EXE TO-SYSTEM:*.*.-1
COPY FROM-SOURCE:2060-MONMAX.EXE TO-SYSTEM:*.*.-1
COPY FROM-SOURCE:BUGSTRINGS.TXT TO-SYSTEM:*.*.-1
COPY FROM-SOURCE:LDINIT.REL TO-SOURCE:*.*.-1
COPY FROM-SOURCE:LN2070.REL TO-SOURCE:*.*.-1

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       