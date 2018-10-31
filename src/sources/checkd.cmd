!COMMAND FILE FOR OBTAINING ALL FILES RELEVANT TO BUILDING CHECKD
INFORMATION LOGICAL FROM*:
INFORMATION LOGICAL TO*:

;Files required to build product
COPY FROM-SOURCE:CHECKD.CMD TO-SOURCE:*.*.-1
COPY FROM-SOURCE:CHECKD.CTL TO-SOURCE:*.*.-1
COPY FROM-SOURCE:CHECKD.MAC TO-SOURCE:*.*.-1

;Documentation for product
COPY FROM-HLP:CHECKD.HLP TO-HLP:*.*.-1
COPY FROM-DOC:CHECKD.DOC TO-DOC:*.*.-1

;Final product
COPY FROM-SUBSYS:CHECKD.EXE TO-SUBSYS:*.*.-1
COPY FROM-SUBSYS:CHECKD.EXE TO-SYSTEM:*.*.-1
