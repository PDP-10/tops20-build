;THIS CONTROL FILES SUBMITS ALL THE BUILDS NEEDED FOR DYNLIB AND RTL TO
;BUILD
;
@SUBMIT PKGBLD:DYN1F.CTL/BAT:SUP/OUT:NO/NOT:YES/TIME:1:00:00/LOGN:PKGLOG:[LOGS.UTILITIES.DYNLIB]DYN1F.LOG
@SUBMIT PKGBLD:DYN1R.CTL/BAT:SUP/OUT:NO/NOT:YES/TIME:1:00:00/LOGN:PKGLOG:[LOGS.UTILITIES.DYNLIB]DYN1R.LOG
@SUBMIT PKGBLD:DYN2F.CTL/BAT:SUP/OUT:NO/NOT:YES/TIME:1:00:00/LOGN:PKGLOG:[LOGS.UTILITIES.DYNLIB]DYN2F.LOG
@SUBMIT PKGBLD:DYNLIB.CTL/BAT:SUP/OUT:NO/NOT:YES/TIME:1:00:00/LOGN:PKGLOG:[LOGS.UTILITIES.DYNLIB]DYNLIB.LOG
@SUBMIT PKGBLD:RTLBLD.CTL/BAT:SUP/OUT:NO/NOT:YES/TIME:1:00:00/LOGN:PKGLOG:[LOGS.UTILITIES.DYNLIB]RTLBLD.LOG


