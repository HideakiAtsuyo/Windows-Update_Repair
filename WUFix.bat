@echo off
SC config trustedinstaller start=auto
NET stop bits
NET stop wuauserv
NET stop msiserver
NET stop cryptsvc
NET stop appidsvc
REN %Systemroot%\SoftwareDistribution SoftwareDistribution.old
REN %Systemroot%\System32\catroot2 catroot2.old
regsvr32.exe /s atl.dll
regsvr32.exe /s urlmon.dll
regsvr32.exe /s mshtml.dll
NETSH winsock reset
NETSH winsock reset proxy
rundll32.exe pnpclean.dll,RunDLL_PnpClean /DRIVERS /MAXCLEAN
DISM /Online /Cleanup-image /ScanHealth
DISM /Online /Cleanup-image /CheckHealth
DISM /Online /Cleanup-image /RestoreHealth
DISM /Online /Cleanup-image /StartComponentCleanup
SFC /ScanNow
NET start bits
NET start wuauserv
NET start msiserver
NET start cryptsvc
NET start appidsvc
