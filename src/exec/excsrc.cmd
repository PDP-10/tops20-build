;Command file to copy the EXEC sources.
INFORMATION LOGICAL-NAMES FROM*:
INFORMATION LOGICAL-NAMES TO*:

;Files required to build product
COPY FROM-SOURCE:EXCSRC.CMD TO-SOURCE:*.*.-1
COPY FROM-SOURCE:EXEC.CTL TO-SOURCE:*.*.-1
COPY FROM-SOURCE:MKEXEC.CMD TO-SOURCE:*.*.-1
COPY FROM-SOURCE:LOEXEC.CCL TO-SOURCE:*.*.-1

;Source modules
COPY FROM-SOURCE:EDEXEC.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:EXECVR.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:EXECSU.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:EXECSE.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:EXECQU.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:EXECPR.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:EXECP.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:EXECMT.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:EXECIN.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:EXECGL.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:EXECF0.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:EXECED.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:EXECDE.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:EXECCS.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:EXEC4.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:EXEC3.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:EXEC2.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:EXEC1.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:EXEC0.MAC TO-SOURCE:*.*.-1

;Command module to allow all flavors of the EXEC
COPY FROM-SOURCE:EXECCA.MAC TO-SOURCE:*.*.-1

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                