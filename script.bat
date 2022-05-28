@echo off
:: window-live-Response-scirpt-v1.0
:: 2022.03.12

echo.
echo "██╗██████╗     ███████╗ ██████╗██████╗ ██╗██████╗ ████████╗"
echo "██║██╔══██╗    ██╔════╝██╔════╝██╔══██╗██║██╔══██╗╚══██╔══╝"
echo "██║██████╔╝    ███████╗██║     ██████╔╝██║██████╔╝   ██║   "
echo "██║██╔══██╗    ╚════██║██║     ██╔══██╗██║██╔═══╝    ██║   "
echo "██║██║  ██║    ███████║╚██████╗██║  ██║██║██║        ██║   "
echo "╚═╝╚═╝  ╚═╝    ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝╚═╝        ╚═╝   "
echo.

:: Banner by https://manytools.org/hacker-tools/ascii-banner/
:: If the banner is broken, enter chcp 65001 in cmd
:: Give admin privileges when running bat

SETLOCAL

:: settings
::

::OS
if %PROCESSOR_ARCHITECTURE% == "AMD64" ( set _VESION=x64) else ( set _VESION=x86)
echo %_VESION%
:: Case Name
set /p _FILENAME= * FILE NAME. :
echo %_FILENAME%

set /p _USerName=* User NAME. :
echo %_USerName%

:SET_IS_MEMORY
set /p _IS_MEMORY= * DUMP PHYSICAL MEMOMRY. (y or n):
if /i "%_IS_MEMORY%" == "y" GOTO:SET_IS_DISK
if /i "%_IS_MEMORY%" == "n" GOTO:SET_IS_DISK
GOTO:SET_IS_MEMORY

:SET_IS_DISK
SET /p _IS_DISK= * DUMP PHYICAL DISK. (y or n):
if /i "%_IS_DISK%" == "y" GOTO:SET_OUTPUT
if /i "%_IS_DISK%" == "n" GOTO:SET_OUTPUT
GOTO:SET_IS_DISK

::file save name
:SET_OUTPUT
set _Data_DIR=.\_output\%date::-=%_%_FILENAME%_%_USerName%
if not exist %_Data_DIR% mkdir %_Data_DIR%


:: Target directory
set _SaveFile=%_Data_DIR%
if not exist %_SaveFile% mkdir %_SaveFile%

:: Tools Directory
set _MAINTOOL=.\tools\3rd
set _OSTOOL=.\tools\os
set _IMGTOOL=.\tools\imager
:: Logging
set _LOG=%_SaveFile%\WLAS.log
set _TIME=%TIME::=%
set _DATA_TIME=%DATE%_%_TIME%

if not exist %_LOG% (
      echo.>> %_LOG%
      echo "██╗██████╗     ███████╗ ██████╗██████╗ ██╗██████╗ ████████╗" >> %_LOG%
      echo "██║██╔══██╗    ██╔════╝██╔════╝██╔══██╗██║██╔══██╗╚══██╔══╝" >> %_LOG%
      echo "██║██████╔╝    ███████╗██║     ██████╔╝██║██████╔╝   ██║   " >> %_LOG%
      echo "██║██╔══██╗    ╚════██║██║     ██╔══██╗██║██╔═══╝    ██║   " >> %_LOG%
      echo "██║██║  ██║    ███████║╚██████╗██║  ██║██║██║        ██║   " >> %_LOG%
      echo "╚═╝╚═╝  ╚═╝    ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝╚═╝        ╚═╝   " >> %_LOG%
      echo IR_Script >>%_LOG%
      echo. >>%_LOG%
      echo _FILENAME: %_FILENAME% >> %_LOG%
      echo _USerName: %_USerName% >> %_LOG%
      echo ^| >> %_LOG%
      echo _Data_DIR: %_FILENAME% >> %_LOG%
      echo _Data_DIR: %_USerName% >> %_LOG%
      echo _SaveFile: %_SaveFile% >> %_LOG%
      echo _MAINTOOL: %_MAINTOOL% >> %_LOG%
      echo _OSTOOL: %_OSTOOL% >> %_LOG%
      echo ^| >> %_LOG%
      echo _IS_MEMORY: %_IS_MEMORY% >> %_LOG%
      echo _VESION: %_VESION% >> %_LOG%
      echo SystemRoot: %SystemRoot% >> %_LOG%
      echo ^| >> %_LOG%
      echo.
      echo #Starting for %_DATA_TIME% >> %_LOG%
      echo. >> %_LOG%
      )

:: Acquisution Starting Point
::


:: * Volatole Data
:ACQ_LIVE

::WINPMEM------------------------------------
:: Physical Memory
:Dump_Memory
if /i "%_IS_Memory%" == "n" GOTO:Dump_DISK
if not exist %_SaveFile%\memory mkdir %_SaveFile%\memory

echo Creating physical memory image...
echo Creating physical memory image... >> %_LOG%


if %_VESION% == x64 (%_MAINTOOL%\winpmem\x64\winpmem_mini_x64_rc2.exe > %_SaveFile%\memory\winpmem64.raw)
if %_VESION% == x86 (%_MAINTOOL%\winpmem\x64\winpmem_mini_x86.exe > %_SaveFile%\memory\winpmem86.raw)
echo Finished physical memory image... %_SaveFile% \memory\winpmem.raw
echo Finished physical memory image... %_SaveFile% \memory\winpmem86.raw >> %_LOG%

::list and info-Cprocess---------------------------------
::Process 

:Process
echo.
if not exist %_SaveFile%\process mkdir %_SaveFile%\process
echo Process Start...
echo Process start... >> %_Log%

:: Pslist  
if %_VESION% == x64 (%_MAINTOOL%\pslist\pslist64.exe  >%_SaveFile%\process\pslist64.txt)
if %_VESION% == x86 (%_MAINTOOL%\pslist\pslist.exe    >%_SaveFile%\process\pslist.txt)
echo Finished pslist64.exe ... %_SaveFile%\process\pslist64.txt
echo Finished pslist.exe ... %_SaveFile%\process\pslist.txt >> %_LOG%


::cProcess
if %_VESION% == x64 (%_MAINTOOL%\cProcess\CProcess.exe /stext %_SaveFile%\process\cprocess.txt)
if %_VESION% == x86 (%_MAINTOOL%\cProcess\CProcess.exe /stext %_SaveFile%\process\cprocess86.txt)
echo Finished CProcess.exe ... %_SaveFile%\process\cprocess.txt
echo Finished CProcess.exe ... %_SaveFile%\process\cprocess86.txt >> %_LOG%


::procinterrogate
if %_VESION% == x64 (%_MAINTOOL%\procinterrogate\procinterrogate.exe -list -md5 -ver -o >%_SaveFile%\process\procinterrogate.txt)
if %_VESION% == x86 (%_MAINTOOL%\procinterrogate\procinterrogate.exe -list -md5 -ver -o >%_SaveFile%\process\procinterrogate86.txt)
echo Finished procinterrogate.exe ... %_SaveFile%\process\procinterrogate.txt
echo Finished procinterrogate.exe ... %_SaveFile%\process\procinterrogate86.txt >> %_LOG%

::Tasklist
if %_VESION% == x64 (%SystemRoot%\SysWOW64\tasklist.exe -V >%_SaveFile%\process\tasklist.txt)
if %_VESION% == x86 (%SystemRoot%\System32\tasklist.exe -V >%_SaveFile%\process\tasklist.txt)
echo Finished tasklist.exe ... %_SaveFile%\process\tasklist.txt 
echo Finished tasklist.exe ... %_SaveFile%\process\tasklist.txt >> %_LOG%

::Tree----------------------------------------------------------
::tlist 
if %_VESION% == x64 (%_MAINTOOL%\tlist\tlist.exe -t >%_SaveFile%\process\tlist64.txt)
if %_VESION% == x86 (%_MAINTOOL%\tlist\tlist.exe -t >%_SaveFile%\process\tlist.txt)
echo Finished tlist.exe ... %_SaveFile%\process\tlist64.txt 
echo Finished tlist.exe ... %_SaveFile%\process\tlist.txt >> %_LOG%

::pslist
if %_VESION% == x64 (%_MAINTOOL%\pslist\pslist64.exe -t >%_SaveFile%\process\pslist64_tree.txt)
if %_VESION% == x86 (%_MAINTOOL%\pslist\pslist.exe   -t >%_SaveFile%\process\pslist_tree.txt)
echo Finished pslist64_tree.exe ... %_SaveFile%\process\pslist64_tree.txt
echo Finished pslisttree.exe ... %_SaveFile%\process\pslist_tree.txt >> %_LOG%

::Handle--------------------
::handle
if %_VESION% == x64 (%_MAINTOOL%\handle\handle64.exe -a >%_SaveFile%\process\handle64.txt)
if %_VESION% == x86 (%_MAINTOOL%\handle\handle.exe   -a >%_SaveFile%\process\handle.txt)
echo Finished handle.exe ... %_SaveFile%\process\handle64.txt 
echo Finished handle.exe ... %_SaveFile%\process\handle.txt >> %_LOG%

::openedfilesview
if %_VESION% == x64 (%_MAINTOOL%\ofview-x64\OpenedFilesView.exe /stext %_SaveFile%\process\openedfilesview-64.txt)
if %_VESION% == x86 (%_MAINTOOL%\ofview-x32\OpenedFilesView.exe /stext %_SaveFile%\process\openedfilesview-32.txt)
echo Finished OpenedFilesView.exe ... %_SaveFile%\process\openedfilesview-64.txt
echo Finished OpenedFilesView.exe ... %_SaveFile%\process\openedfilesview-32.txt >> %_LOG%

::listobj
if %_VESION% == x64 (%_MAINTOOL%\listobj\listobj.exe >%_SaveFile%\process\listobj64.txt)
if %_VESION% == x86 (%_MAINTOOL%\listobj\listobj.exe >%_SaveFile%\process\listobj.txt)
echo Finished listobj.exe ... %_SaveFile%\process\listobj64.txt
echo Finished listobj.exe ... %_SaveFile%\process\listobj.txt >> %_LOG%


::CommandLine--------------------------------
::tlist
if %_VESION% == x64 (%_MAINTOOL%\tlist\tlist.exe -c >%_SaveFile%\process\tlist64.txt)
if %_VESION% == x86 (%_MAINTOOL%\tlist\tlist.exe -c >%_SaveFile%\process\tlist.txt)
echo Finished tlist.exe ... %_SaveFile%\process\tlist64.txt
echo Finished tlist.exe ... %_SaveFile%\process\tlist.txt >> %_LOG%

::DLL-------------------------------------
::listdlls
if %_VESION% == x64 (%_MAINTOOL%\listdlls\listdlls64.exe -v > %_SaveFile%\process\listdlls64.txt)
if %_VESION% == x86 (%_MAINTOOL%\listdlls\listdlls.exe -v > %_SaveFile%\process\listdlls.txt)
echo Finished listdlls64.exe ... %_SaveFile%\process\listdlls64.txt >> %_LOG%
echo Finished listdlls.exe ... %_SaveFile%\process\listdlls.txt >> %_LOG%

::dllexp 
if %_VESION% == x64 (%_MAINTOOL%\dllexp\dllexp64.exe /stext %_SaveFile%\process\dllexp64.txt)
if %_VESION% == x86 (%_MAINTOOL%\dllexp\dllexp32.exe /stext %_SaveFile%\process\dllexp.txt)
echo Finished dllexp.exe64 ... %_SaveFile%\process\dllexp64.txt
echo Finished dllexp.exe32 ... %_SaveFile%\process\dllexp.txt >> %_LOG%

::injecteddll
if %_VESION% == x64 (%_MAINTOOL%\injectddll\InjectedDLL.exe /stext  %_SaveFile%\process\injectddll64.txt)
if %_VESION% == x86 (%_MAINTOOL%\injectddll\InjectedDLL.exe /stext  %_SaveFile%\process\injectddll.txt)
echo Finished InjectedDLL.exe ... %_SaveFile%\process\injectddll64.txt
echo Finished InjectedDLL.exe ... %_SaveFile%\process\injectddll.txt >> %_LOG%




::Service------------------------------------------------------------
:Service
echo.
if not exist %_SaveFile%\service mkdir %_SaveFile%\service
echo Service Start...
echo Service start... >> %_Log%


if %_VESION% == x64 (%SystemRoot%\SysWOW64\tasklist.exe -svc >%_SaveFile%\service\tasklist_svc64.txt)
if %_VESION% == x86 (%SystemRoot%\System32\tasklist.exe -svc >%_SaveFile%\service\tasklist_svc.txt)
echo Finished tasklist.exe -svc ... %_SaveFile%\service\tasklist_svc64.txt
echo Finished tasklist.exe -svc ... %_SaveFile%\service\tasklist_svc.txt >> %_LOG%

if %_VESION% == x64 (%SystemRoot%\SysWOW64\tasklist.exe -apps >%_SaveFile%\service\tasklist_apps64.txt)
if %_VESION% == x86 (%SystemRoot%\System32\tasklist.exe -apps >%_SaveFile%\service\tasklist_apps.txt)
echo Finished tasklist.exe -apps ... %_SaveFile%\service\tasklist_apps64.txt
echo Finished tasklist.exe -apps ... %_SaveFile%\service\tasklist_apps.txt >>%_LOG%

::psservice
if %_VESION% == x64 (%_MAINTOOL%\pslist\psservice64.exe -v >%_SaveFile%\service\psservice64.txt)
if %_VESION% == x86 (%_MAINTOOL%\pslist\psservice.exe -v >%_SaveFile%\service\psservie.txt)
echo Finished psservice64.exe -v ... %_SaveFile%\service\psservice64.txt
echo Finished psservice.exe -v ... %_SaveFile%\service\psservice.txt >> %_LOG%

::tlist
if %_VESION% == x64 (%_MAINTOOL%\tlist\tlist.exe -s >%_SaveFile%\service\tlist64.txt)
if %_VESION% == x86 (%_MAINTOOL%\tlist\tlist.exe -s >%_SaveFile%\service\tlist.txt)
echo Finished tlist.exe -s ... %_SaveFile%\service\tlist64.txt 
echo Finished tlist.exe -s ... %_SaveFile%\service\tlist.txt >> %_LOG%

::Driver---------------------------------------------------
:Driver
echo.
if not exist %_SaveFile%\driver mkdir %_SaveFile%\driver
echo Driver Start...
echo Driver start... >> %_Log%

::driverview
if %_VESION% == x64 (%_MAINTOOL%\Driverview\DriverView64.exe /stext %_SaveFile%\driver\driversiew64.txt)
if %_VESION% == x86 (%_MAINTOOL%\Driverview\DriverView32.exe /stext %_SaveFile%\driver\driverview.txt)
echo Finished DriverView64.exe ... %_SaveFile%\driver\drivers64.html
echo Finished DriverView32.exe ... %_SaveFile%\driver\drivers64.html >> %_LOG%

::listdrivers 
if %_VESION% == x64 (%_MAINTOOL%\listdrivers\listdrivers.exe /stext %_SaveFile%\driver > %_SaveFile%\driver\listdrivers64.txt)
if %_VESION% == x86 (%_MAINTOOL%\listdrivers\listdrivers.exe /stext %_SaveFile%\driver > %_SaveFile%\driver\listdrivers.txt)
echo Finished listdrivers.exe ... %_SaveFile%\driver\listdrivers64.txt 
echo Finished listdrivers.exe ... %_SaveFile%\driver\listdrivers.txt >> %_LOG%





::NETWORK---------------------------------------
:Network
echo.

if not exist %_SaveFile%\network mkdir %_SaveFile%\network
echo Network start...
echo Network start... >> %_Log%

::Promiscuois search
if %_VESION% == x64 ( %_MAINTOOL%\promiscdetect_1\promiscdetect.exe > %_SaveFile%\network\promiscdetect_search64.txt)
if %_VESION% == x86 ( %_MAINTOOL%\promiscdetect_1\promiscdetect.exe > %_SaveFile%\network\promiscdetect_search.txt)
echo Finished promiscdetect.exe ... %_SaveFile%\network\promiscdetect_search64.txt
echo Finished promiscdetect.exe ... %_SaveFile%\network\promiscdetect_search.txt >> %_LOG%

:: NIC MAC 
if %_VESION% == x64 ( %SystemRoot%\SysWOW64\getmac.exe > %_SaveFile%\network\getmac64.txt)
if %_VESION% == x86 ( %SystemRoot%\System32\getmac.exe > %_SaveFile%\network\getmac.txt)
echo Finished getmac.exe ... %_SaveFile%\network\getmac64.txt
echo Finished getmac.exe ... %_SaveFile%\network\getmac.txt >> %_LOG%

:: Nic Interface
if %_VESION% == x64 ( %SystemRoot%\SysWOW64\ipconfig.exe /all > %_SaveFile%\network\ipconfig-all64.txt)
if %_VESION% == x86 ( %SystemRoot%\System32\ipconfig.exe /all > %_SaveFile%\network\ipconfig-all.txt)
echo Finished ipconfig.exe ... %_SaveFile%\network\ipconfig-all64.txt
echo Finished ipconfig.exe ... %_SaveFile%\network\ipconfig-all.txt >> %_LOG%

:: DNS CASH
if %_VESION% == x64 ( %SystemRoot%\SysWOW64\ipconfig.exe /displaydns > %_SaveFile%\network\ipconfig-cash64.txt)
if %_VESION% == x86 ( %SystemRoot%\System32\ipconfig.exe /displaydns > %_SaveFile%\network\ipconfig-cash.txt)
echo Finished ipconfig.exe ... %_SaveFile%\network\ipconfig-cash64.txt
echo Finished ipconfig.exe ... %_SaveFile%\network\ipconfig-cash.txt >> %_LOG%

::Local Session-----------------
:Local
echo.

if not exist %_SaveFile%\local mkdir %_SaveFile%\local
echo Local start...
echo Local start... >> %_Log%

if %_VESION% == x64 ( %SystemRoot%\SysWOW64\net session  \\%ComputerName% /DELETE > %_SaveFile%\local\net64.txt)
if %_VESION% == x86 ( %SystemRoot%\System32\net session  \\%ComputerName% /DELETE > %_SaveFile%\local\net.txt)
echo Finished net.exe ... %_SaveFile%\local\net64.txt
echo Finished net.exe ... %_SaveFile%\local\net.txt >> %_LOG%


::Network Session-------------
:Network_Session
echo.

if not exist %_SaveFile%\network_session mkdir %_SaveFile%\network_session
echo Network_Session...
echo Network_Session... >> %_Log%


::netstat 
if %_VESION% == x64 (%SystemRoot%\SysWOW64\netstat.exe -nao > %_SaveFile%\network_session\tcp_ip_netstat64.txt)
if %_VESION% == x86 (%SystemRoot%\System32\netstat.exe -nao > %_SaveFile%\network_session\tcp_ip_netstat.txt)
echo Finished net.exe ... %_SaveFile%\local\tcp_ip_netstat64.txt
echo Finished net.exe ... %_SaveFile%\local\tcp_ip_netstat.txt >> %_LOG%

::tcpvcon
if %_VESION% == x64 (%_MAINTOOL%\tcpvcon\tcpvcon64.exe /a /c > %_SaveFile%\network_session\tcp_ip_tcpvcon64.txt)
if %_VESION% == x86 (%_MAINTOOL%\tcpvcon\tcpvcon.exe /a /c > %_SaveFile%\network_session\tcp_ip_tcpvcon.txt)
echo Finished tcpvcon64.exe ... %_SaveFile% \network\tcp_ip_tcpvcon64.txt
echo Finished tcpvcon64.exe ... %_SaveFile% \network\tcp_ip_tcpvcon.txt >> %_LOG%

::urlprotocolview
if %_VESION% == x64 (%_MAINTOOL%\urlprotocolview\urlprotocolview.exe /stext %_SaveFile%\network_session\urlprotocolview64.txt)
if %_VESION% == x86 (%_MAINTOOL%\urlprotocolview\urlprotocolview.exe /stext %_SaveFile%\network_session\urlprotocolview.txt)
echo Finished urlprotocolview.exe ... %_SaveFile% \network_session\urlprotocolview64.txt
echo Finished urlprotocolview.exe ... %_SaveFile% \network_session\urlprotocolview.txt >> %_LOG%


::TCP/IP Open Port-------------------------------
:TCP_IP_Open_Port
echo.

if not exist %_SaveFile%\tcp_ip_open_port mkdir %_SaveFile%\tcp_ip_open_port
echo TCP_IP_Open_Port ...!!
echo TCP_IP_Open_Port ...!!  >> %_Log%

::cports
if %_VESION% == x64 (%_MAINTOOL%\cports\cports.exe /stext > %_SaveFile%\tcp_ip_open_port\cports64.txt)
if %_VESION% == x86 (%_MAINTOOL%\cports\cports.exe /stext> %_SaveFile%\tcp_ip_open_port\cports.txt)
echo Finished cports.exe ... %_SaveFile%\tcp_ip_open_port\cports64.txt
echo Finished cports.exe ... %_SaveFile%\tcp_ip_open_port\cports.txt >> %_LOG%

::netstat
if %_VESION% == x64 (%SystemRoot%\SysWOW64\netstat.exe  -nao | findstr LISTENING > %_SaveFile%\tcp_ip_open_port\netstat64.txt)
if %_VESION% == x86 (%SystemRoot%\System32\netstat.exe  -nao | findstr LISTENING > %_SaveFile%\tcp_ip_open_port\netstat.txt)
echo Finished netstat.exe ... %_SaveFile%\tcp_ip_open_port\netstat64.txt
echo Finished netstat.exe ... %_SaveFile%\tcp_ip_open_port\netstat.txt >> %_LOG%

::LogON-------------------------------
:LogOn
echo. 
if not exist %_SaveFile%\logon mkdir %_SaveFile%\logon
echo LogON starts ...!
echo LogON starts ...! >> %_LOG%

::logon_user
if %_VESION% == x64 (%SystemRoot%\SysWOW64\net.exe  session > %_SaveFile%\logon\logon_user64.txt)
if %_VESION% == x86 (%SystemRoot%\System32\net.exe  session > %_SaveFile%\logon\logon_user.txt)
echo Finished net.exe ... %_SaveFile%\logon\logon_user64.txt
echo Finished net.exe ... %_SaveFile%\logon\logon_user.txt >> %_LOG%

::logonsessions
if %_VESION% == x64 (%_MAINTOOL%\logonsessions\logonsessions64.exe  > %_SaveFile%\logon\logonsessions64.txt)
if %_VESION% == x86 (%_MAINTOOL%\logonsessions\logonsessions.exe > %_SaveFile%\logon\logonsessions.txt)
echo Finished logonsessions64.exe ... %_SaveFile%\logon\logonsessions64.txt
echo Finished logonsessions.exe ... %_SaveFile%\logon\logonsessions.txt >> %_LOG%

::psloggedon
if %_VESION% == x64 (%_MAINTOOL%\psloggedon\psloggedon64.exe  > %_SaveFile%\logon\psloggedon64.txt)
if %_VESION% == x86 (%_MAINTOOL%\psloggedon\psloggedon.exe > %_SaveFile%\logon\psloggedon.txt)
echo Finished psloggedon64.exe ... %_SaveFile%\logon\psloggedon64.txt
echo Finished psloggedon.exe ... %_SaveFile%\logon\psloggedon.txt >> %_LOG%

::WinLogOnView 
if %_VESION% == x64 (%_MAINTOOL%\WinLogOnView\WinLogOnView.exe /stext %_SaveFile%\logon\winlogonview64.txt)
if %_VESION% == x86 (%_MAINTOOL%\WinLogOnView\WinLogOnView.exe /stext %_SaveFile%\logon\winlogonview.txt)
echo Finished WinLogOnView.exe /stext ... %_SaveFile%\logon\winlogonview64.txt
echo Finished WinLogOnView.exe /stext ... %_SaveFile%\logon\Winlogonview.txt >> %_LOG%


::Address&Group--------------------------------------
:Address_Group
echo. 
if not exist %_SaveFile%\address_group mkdir %_SaveFile%\address_group
echo Address and Group start ...!
echo Address and Group start ...! >> %_LOG%

::user address list]
if %_VESION% == x64 (%SystemRoot%\SysWOW64\net.exe  user > %_SaveFile%\address_group\user_address_list64.txt)
if %_VESION% == x86 (%SystemRoot%\System32\net.exe  user > %_SaveFile%\address_group\user_address_list.txt)
echo Finished net.exe user ... %_SaveFile%\address_group\user_address_list64.txt
echo Finished net.exe user ... %_SaveFile%\address_group\user_address_list.txt >> %_LOG%

::admin Group list
if %_VESION% == x64 (%SystemRoot%\SysWOW64\net.exe   localgroup administrators > %_SaveFile%\address_group\admin_group_list64.txt)
if %_VESION% == x86 (%SystemRoot%\System32\net.exe   localgroup administrators > %_SaveFile%\address_group\admin_group_list.txt)
echo Finished net.exe localgroup administrators ... %_SaveFile%\address_group\admin_group_list64.txt
echo Finished net.exe localgroup administrators ... %_SaveFile%\address_group\admin_group_list.txt >> %_LOG%

::Active Directoy----------------------------------------
:Active_Directory
echo. 
if not exist %_SaveFile%\gpo_policy mkdir %_SaveFile%\gpo_policy
echo Active Directory start ...!
echo Active Directory start ...! >> %_LOG%

::gplist 
if %_VESION% == x64 (%_MAINTOOL%\gplist\gplist.exe > %_SaveFile%\gpo_policy\gplist64.txt)
if %_VESION% == x86 (%_MAINTOOL%\gplist\gplist.exe > %_SaveFile%\gpo_policy\gplist.txt)
echo Finished gplist.exe ... %_SaveFile%\gpo_policy\gplist64.txt
echo Finished gplist.exe ... %_SaveFile%\gpo_policy\gplist.txt >> %_LOG%



::gpresult_H
if %_VESION% == x64 (%SystemRoot%\SysWOW64\gpresult.exe /H > %_SaveFile%\gpo_policy\gpo_policy_H64.txt)
if %_VESION% == x86 (%SystemRoot%\System32\gpresult.exe /H > %_SaveFile%\gpo_policy\gpo_policy_H.txt)
echo Finished gpresult.exe /H ... %_SaveFile%\gpo_policy\gpo_policy_H64.txt
echo Finished gpresult.exe /H ... %_SaveFile%\gpo_policy\gpo_policy_H.txt >> %_LOG%

::gpresult_Z
if %_VESION% == x64 (%SystemRoot%\SysWOW64\gpresult.exe /Z > %_SaveFile%\gpo_policy\gpo_policy_Z64.txt)
if %_VESION% == x86 (%SystemRoot%\System32\gpresult.exe /Z > %_SaveFile%\gpo_policy\gpo_policy_Z.txt)
echo Finished gpresult.exe /Z ... %_SaveFile%\gpo_policy\gpo_policy_Z64.txt
echo Finished gpresult.exe /Z ... %_SaveFile%\gpo_policy\gpo_policy_Z.txt >> %_LOG%

::gpresult_R
if %_VESION% == x64 (%SystemRoot%\SysWOW64\gpresult.exe /R > %_SaveFile%\gpo_policy\gpo_policy_R64.txt)
if %_VESION% == x86 (%SystemRoot%\System32\gpresult.exe /R > %_SaveFile%\gpo_policy\gpo_policy_R.txt)
echo Finished gpresult.exe /R ... %_SaveFile%\gpo_policy\gpo_policy_R64.txt
echo Finished gpresult.exe /R ... %_SaveFile%\gpo_policy\gpo_policy_R.txt >> %_LOG%


::Shared Resource-----------------------------------------
:Shared_Resource
echo. 
if not exist %_SaveFile%\share_resource mkdir %_SaveFile%\shared_resource
echo Shared_Resource start ...!
echo Shared_Resource start ...! >> %_LOG%

::share folder 
if %_VESION% == x64 (%SystemRoot%\SysWOW64\net.exe share > %_SaveFile%\share_resource\share_folder64.txt)
if %_VESION% == x86 (%SystemRoot%\System32\net.exe share > %_SaveFile%\share_resource\share_folder.txt)
echo Finished net.exe share ... %_SaveFile%\share_resource\share_folder64.txt
echo Finished net.exe share ... %_SaveFile%\share_resource\share_folder.txt >> %_LOG%

::share file
if %_VESION% == x64 (%SystemRoot%\SysWOW64\net.exe file > %_SaveFile%\share_resource\share_file64.txt)
if %_VESION% == x86 (%SystemRoot%\System32\net.exe file > %_SaveFile%\share_resource\share_file.txt)
echo Finished net.exe share file ... %_SaveFile%\share_resource\share_file64.txt
echo Finished net.exe share file ... %_SaveFile%\share_resource\share_file.txt >> %_LOG%


::NETBIOS-----------------------------------
:NetBIOS
echo. 
if not exist %_SaveFile%\netbios mkdir %_SaveFile%\netbios
echo NetBIOS start ...!
echo NetBIOS start ...! >> %_LOG%

::NBT_cash
if %_VESION% == x64 (%_MAINTOOL%\nbtstat\nbtstat.exe -c > %_SaveFile%\netbios\nbt_cash64.txt)
if %_VESION% == x86 (%SystemRoot%\System32\nbtstat.exe -c > %_SaveFile%\netbios\nbt_cash.txt)
echo Finished nbtstat.exe -c ... %_SaveFile%\netbios\nbt_cash64.txt
echo Finished nbtstat.exe -c ... %_SaveFile%\netbios\nbt_cash.txt >> %_LOG%

::NBT_Local.
if %_VESION% == x64 (%_MAINTOOL%\nbtstat\nbtstat.exe -n > %_SaveFile%\netbios\nbt_local64.txt)
if %_VESION% == x86 (%SystemRoot%\System32\nbtstat.exe -n > %_SaveFile%\netbios\nbt_local.txt)
echo Finished nbtstat.exe -n ... %_SaveFile%\netbios\nbt_local64.txt
echo Finished nbtstat.exe -n ... %_SaveFile%\netbios\nbt_local.txt >> %_LOG%

::NBT_Session
if %_VESION% == x64 (%_MAINTOOL%\nbtstat\nbtstat.exe -s > %_SaveFile%\netbios\nbt_session64.txt)
if %_VESION% == x86 (%SystemRoot%\System32\nbtstat.exe -s> %_SaveFile%\netbios\nbt_session.txt)
echo Finished nbtstat.exe -s ... %_SaveFile%\netbios\nbt_session64.txt
echo Finished nbtstat.exe -s ... %_SaveFile%\netbios\nbt_session.txt >> %_LOG%


::ARP--------------------------------
:ARP
echo. 
if not exist %_SaveFile%\arp mkdir %_SaveFile%\arp
echo ARP start ...!
echo ARP start ...! >> %_LOG%


if %_VESION% == x64 (%SystemRoot%\SysWOW64\arp.exe -a -v > %_SaveFile%\arp\arp64.txt)
if %_VESION% == x86 (%SystemRoot%\System32\arp.exe -a -v > %_SaveFile%\arp\arp.txt)
echo Finished arp.exe -a -v ... %_SaveFile%\arp\arp64.txt
echo Finished arp.exe -a -v ... %_SaveFile%\arp\arp.txt >> %_LOG%

::route-----------------------------------------
:route
echo. 
if not exist %_SaveFile%\route mkdir %_SaveFile%\route
echo route start ...!
echo route start ...! >> %_LOG%

if %_VESION% == x64 (%SystemRoot%\SysWOW64\ROUTE.EXE PRINT -4 > %_SaveFile%\route\route64.txt)
if %_VESION% == x86 (%SystemRoot%\System32\ROUTE.EXE PRINT -4 > %_SaveFile%\route\route.txt)
echo Finished ROUTE.EXE PRINT -4 ... %_SaveFile%\route\route64.txt
echo Finished ROUTE.EXE PRINT -4 ... %_SaveFile%\route\route.txt >> %_LOG%

::Systeminfo-basic----------------------------------------
:Systeminfo_basic
echo. 
if not exist %_SaveFile%\systeminfo_basic mkdir %_SaveFile%\systeminfo_basic
echo Systeminfo_basic start ...!
echo Systeminfo_basic start ...! >> %_LOG%

::systeminfo
if %_VESION% == x64 (%SystemRoot%\SysWOW64\systeminfo.exe > %_SaveFile%\systeminfo_basic\systeminfo64.txt)
if %_VESION% == x86 (%SystemRoot%\System32\systeminfo.exe > %_SaveFile%\systeminfo_basic\systeminfo.txt)
echo Finished systeminfo.exe ... %_SaveFile%\systeminfo_basic\systeminfo64.txt
echo Finished systeminfo.exe ... %_SaveFile%\systeminfo_basic\systeminfo.txt >> %_LOG%

::psinfo
if %_VESION% == x64 (%_MAINTOOL%\pslist\PsInfo64.exe -d >%_SaveFile%\systeminfo_basic\psinfo64.txt)
if %_VESION% == x86 (%_MAINTOOL%\pslist\PsInfo.exe   -d >%_SaveFile%\systeminfo_basic\psinfo.txt)
echo Finished PsInfo64.exe ... %_SaveFile%\systeminfo_basic\psinfo64.txt
echo Finished PsInfo.exe ... %_SaveFile%\systeminfo_basic\psinfo64.txt >> %_LOG%



::install list
:Install_list 
echo. 
if not exist %_SaveFile%\installer_list mkdir %_SaveFile%\installer_list
echo Installer_list  start ...!
echo Installer_list  start ...! >> %_LOG%

::Install Windows Update
if %_VESION% == x64 (%_MAINTOOL%\wul\wul.exe /stext %_SaveFile%\installer_list\windows_update_wul64.txt)
if %_VESION% == x86 (%_MAINTOOL%\wul\wul.exe /stext %_SaveFile%\installer_list\windows_update_wul.txt)
echo Finished wul.exe /stext ... %_SaveFile%\installer_list\windows_update_wul64.txt
echo Finished wul.exe /stext ... %_SaveFile%\installer_list\windows_update_wul.txt >> %_LOG%



:: windows_update_systeminfo 
if %_VESION% == x64 (%SystemRoot%\SysWOW64\systeminfo > %_SaveFile%\installer_list\windows_update_systeminfo64.txt)
if %_VESION% == x86 (%SystemRoot%\System32\systeminfo > %_SaveFile%\installer_list\windows_update_systeminfo.txt)
echo Finished systeminfo.exe ... %_SaveFile%\installer_list\windows_update_systeminfo64.txt
echo Finished systeminfo.exe ... %_SaveFile%\installer_list\windows_update_systeminfo.txt >> %_LOG%


::Install Windows Hotfix 
if %_VESION% == x64 (%_MAINTOOL%\pslist\PsInfo64.exe -h >%_SaveFile%\installer_list\install_winodows_hotfix64.txt)
if %_VESION% == x86 (%_MAINTOOL%\pslist\PsInfo.exe -h >%_SaveFile%\installer_list\install_winodows_hotfix.txt)
echo Finished PsInfo64.exe -h ... %_SaveFile%\installer_list\install_winodows_hotfix64.txt
echo Finished PsInfo.exe -h ... %_SaveFile%\installer_list\install_winodows_hotfix.txt >> %_LOG%

::Install Windows Software
if %_VESION% == x64 (%_MAINTOOL%\pslist\PsInfo64.exe -s >%_SaveFile%\installer_list\install_winodows_software64.txt)
if %_VESION% == x86 (%_MAINTOOL%\pslist\PsInfo.exe -s >%_SaveFile%\installer_list\install_winodows_software.txt)
echo Finished PsInfo64.exe -s ... %_SaveFile%\installer_list\install_winodows_software64.txt
echo Finished PsInfo.exe -s ... %_SaveFile%\installer_list\install_winodows_software.txt >> %_LOG%

::Auto_set
:Auto_Set 
echo. 
if not exist %_SaveFile%\auto_set mkdir %_SaveFile%\auto_set
echo Auto_Set  start ...!
echo Auto_Set  start ...! >> %_LOG%

::autorunsc 
if %_VESION% == x64 (%_MAINTOOL%\autorunsc\autorunsc64.exe  -a * -c -h -s -u * -o /stext >%_SaveFile%\auto_set\autorunsc64.txt)
if %_VESION% == x86 (%_MAINTOOL%\autorunsc\autorunsc.exe  -a * -c -h -s -u * -o /stext >%_SaveFile%\auto_set\autorunsc.txt)
echo Finished autorunsc64.exe ... %_SaveFile%\auto_set\autorunsc64.txt
echo Finished autorunsc.exe ... %_SaveFile%\auto_set\autorunsc.txt >> %_LOG%

::Pipe
:Pipe
echo. 
if not exist %_SaveFile%\pipelist mkdir %_SaveFile%\pipelist
echo PipeList  start ...!
echo PipeList  start ...! >> %_LOG%

::piplist 

if %_VESION% == x64 (%_MAINTOOL%\PipeList\pipelist64.exe  >%_SaveFile%\pipelist\pipelist64.txt)
if %_VESION% == x86 (%_MAINTOOL%\PipeList\pipelist.exe    >%_SaveFile%\pipelist\pipelist.txt)
echo Finished pipelist64.exe ... %_SaveFile%\pipelist\pipelist64.txt
echo Finished pipelist.exe ... %_SaveFile%\pipelist\pipelist.txt >> %_LOG%

:: Non-volatile memory Starting Point

:: Psysical Disk
:Dump_DISK
if /i %_IS_DISK% == "n" GOTO:ACQ_LIVE
if not exist %_SaveFile%\disk mkdir %_SaveFile%\disk 
echo Creating physical disk image...
echo Creating physical disk image... >> %_LOG%

:: Psysical Disk image
if %_VESION% == x64 (%_MAINTOOL%\dd-0.5\dd.exe if =\\.\PhysicalDrive0 of=- bs=512 | %_MAINTOOL%\dd-0.5\7za.exe a -si %_SaveFile%\disk\pdi64.disk.7z)
if %_VESION% == x86 (%_MAINTOOL%\dd-0.5\dd.exe if =\\.\PhysicalDrive0 of=- bs=512 | %_MAINTOOL%\dd-0.5\7za.exe a -si %_SaveFile%\disk\pdi.disk.7z)
echo Finished physical disk image... %_SaveFile%\disk\pdi64.disk.7z
echo Finished physical disk image... %_SaveFile%\disk\pdi.disk.7z >> %_LOG%


::MVMLU
:MVMLU
if not exist %_SaveFile%\mvmlu mkdir %_SaveFile%\mvmlu
echo Starting MVMLU ...
echo Starting MVMLU ... >> %_LOG%

:: Master Boot Record 
if %_VESION% == x64 (%_MAINTOOL%\dd-0.5\dd.exe if =\\.\PhysicalDrive0 of=%_SaveFile%\mvmlu\mbr64.disk.7z bs=512 count=1)
if %_VESION% == x86 (%_MAINTOOL%\dd-0.5\dd.exe if =\\.\PhysicalDrive0 of=%_SaveFile%\mvmlu\mbr.disk.7z bs=512 count=1)
echo Finished Master Boot Record if =\\.\PhysicalDrive0 of=_SaveFile\mvmlu\mbr64.disk.7z bs=512 count=1 ... %_SaveFile%\mvmlu\mbr64.disk.7z
echo Finished Master Boot Record if =\\.\PhysicalDrive0 of=_SaveFile\mvmlu\mbr.disk.7z bs=512 count=1 ... %_SaveFile%\mvmlu\mbr.disk.7z >> %_LOG%

::Volume Boot Record $VBR 
if %_VESION% == x64 (%_MAINTOOL%\forecopy_handy\forecopy_handy.exe -f %SystemDrive%\$Boot %_SaveFile%)
if %_VESION% == x86 (%_MAINTOOL%\forecopy_handy\forecopy_handy.exe -f %SystemDrive%\$Boot %_SaveFile%)
echo Finished Volume Boot Record -f SystemDrive\$Boot... %_SaveFile%
echo Finished Volume Boot Record -f SystemDrive\$Boot... %_SaveFile%>> %_LOG%

::Master File Table $MFT
if %_VESION% == x64 (%_MAINTOOL%\forecopy_handy\forecopy_handy.exe -m %_SaveFile%)
if %_VESION% == x86 (%_MAINTOOL%\forecopy_handy\forecopy_handy.exe -m %_SaveFile%)
echo Finished Master File Table -m ... %_SaveFile%
echo Finished Master File Table -m ... %_SaveFile% >> %_LOG%

::$LogFile
if %_VESION% == x64 (%_MAINTOOL%\forecopy_handy\forecopy_handy.exe -f %SystemDrive%\$LogFile %_SaveFile%)
if %_VESION% == x86 (%_MAINTOOL%\forecopy_handy\forecopy_handy.exe -f %SystemDrive%\$LogFile %_SaveFile%)
echo Finished $LogFile -f SystemDrive\$LogFile ... %_SaveFile%
echo Finished $LogFile -f SystemDrive\$LogFile ... %_SaveFile% >> %_LOG%

::$UsnJrnl
if %_VESION% == x64 (%_MAINTOOL%\forecopy_handy\forecopy_handy.exe -f %SystemDrive%\$Extend\$UsnJrnl:$J %_SaveFile%)
if %_VESION% == x86 (%_MAINTOOL%\forecopy_handy\forecopy_handy.exe -f %SystemDrive%\$Extend\$UsnJrnl:$J %_SaveFile%)
echo Finished $UsnJrnl -f SystemDrive\$Extend\$UsnJrnl:$J... %_SaveFile%
echo Finished $UsnJrnl -f SystemDrive\$Extend\$UsnJrnl:$J... %_SaveFile% >> %_LOG%


::Registry--------------------------------------
:Registry_User_Hive
echo. 
if not exist %_SaveFile%\registry_userhive mkdir %_SaveFile%\registry_userhive
echo Registry User Hive start ...!
echo Registry User Hive start ...! >> %_LOG%

::NTUSER.DAT
if %_VESION% == x64 (%_MAINTOOL%\forecopy_handy\forecopy_handy.exe -g > %_SaveFile%\registry_userhive\ntuse64.dat)
if %_VESION% == x86 (%_MAINTOOL%\forecopy_handy\forecopy_handy.exe -g > %_SaveFile%\registry_userhive\ntuse.dat)
echo Finished NTUSER.DAT forecopy_handy.exe -g ... %_SaveFile%\registry_userhive\ntuse64.dat
echo Finished NTUSER.DAT forecopy_handy.exe -g ... %_SaveFile%\registry_userhive\ntuse.dat >> %_LOG%

::USRCLASS.DAT
if %_VESION% == x64 (%_MAINTOOL%\forecopy_handy\forecopy_handy.exe -g > %_SaveFile%\registry_userhive\usrclass64.dat)
if %_VESION% == x86 (%_MAINTOOL%\forecopy_handy\forecopy_handy.exe -g > %_SaveFile%\registry_userhive\usrclass.dat)
echo Finished NTUSER.DAT forecopy_handy.exe -g ... %_SaveFile%\registry_userhive\usrclass64.dat
echo Finished NTUSER.DAT forecopy_handy.exe -g ... %_SaveFile%\registry_userhive\usrclass.dat >> %_LOG%



:Registry_System_Hive
echo. 
if not exist %_SaveFile%\registry_systemhive mkdir %_SaveFile%\registry_systemhive
echo Registry System Hive start ...!
echo Registry System Hive start ...! >> %_LOG%

::SAM
if %_VESION% == x64 (%_MAINTOOL%\forecopy_handy\forecopy_handy.exe -g > %_SaveFile%\registry_systemhive\sam64)
if %_VESION% == x86 (%_MAINTOOL%\forecopy_handy\forecopy_handy.exe -g > %_SaveFile%\registry_systemhive\sam)
echo Finished SAM forecopy_handy.exe -g  ... %_SaveFile%\registry_systemhive\sam64.sam
echo Finished SAM forecopy_handy.exe -g  ... %_SaveFile%\registry_systemhive\sam.sam >> %_LOG%

::SECURITY
if %_VESION% == x64 (%_MAINTOOL%\forecopy_handy\forecopy_handy.exe -g > %_SaveFile%\registry_systemhive\security64)
if %_VESION% == x86 (%_MAINTOOL%\forecopy_handy\forecopy_handy.exe -g > %_SaveFile%\registry_systemhive\security)
echo Finished SECURITY forecopy_handy.exe -g  ... %_SaveFile%\registry_systemhive\security64.txt
echo Finished SECURITY forecopy_handy.exe -g  ... %_SaveFile%\registry_systemhive\security.txt >> %_LOG%

::SOFTWARE
if %_VESION% == x64 (%_MAINTOOL%\forecopy_handy\forecopy_handy.exe -g > %_SaveFile%\registry_systemhive\software64)
if %_VESION% == x86 (%_MAINTOOL%\forecopy_handy\forecopy_handy.exe -g > %_SaveFile%\registry_systemhive\software)
echo Finished SOFTWARE forecopy_handy.exe -g ... %_SaveFile%\registry_systemhive\software64.txt
echo Finished SOFTWARE forecopy_handy.exe -g ... %_SaveFile%\registry_systemhive\software.txt >> %_LOG%

::SYSTEM
if %_VESION% == x64 (%_MAINTOOL%\forecopy_handy\forecopy_handy.exe -g > %_SaveFile%\registry_systemhive\system64)
if %_VESION% == x86 (%_MAINTOOL%\forecopy_handy\forecopy_handy.exe -g > %_SaveFile%\registry_systemhive\system)
echo Finished SYSTEM forecopy_handy.exe -g ... %_SaveFile%\registry_systemhive\system64
echo Finished SYSTEM forecopy_handy.exe -g ... %_SaveFile%\registry_systemhive\system >> %_LOG%

::DEFAULT
if %_VESION% == x64 (%_MAINTOOL%\forecopy_handy\forecopy_handy.exe -g > %_SaveFile%\registry_systemhive\default64)
if %_VESION% == x86 (%_MAINTOOL%\forecopy_handy\forecopy_handy.exe -g > %_SaveFile%\registry_systemhive\default)
echo Finished DEFAULT forecopy_handy.exe -g ... %_SaveFile%\registry_systemhive\default64
echo Finished DEFAULT forecopy_handy.exe -g ... %_SaveFile%\registry_systemhive\default >> %_LOG%

::COMPONENTS
if %_VESION% == x64 (%_MAINTOOL%\forecopy_handy\forecopy_handy.exe -g > %_SaveFile%\registry_systemhive\components64)
if %_VESION% == x86 (%_MAINTOOL%\forecopy_handy\forecopy_handy.exe -g > %_SaveFile%\registry_systemhive\components)
echo Finished COMPONENTS forecopy_handy.exe -g ... %_SaveFile%\registry_systemhive\components64
echo Finished COMPONENTS forecopy_handy.exe -g ... %_SaveFile%\registry_systemhive\components >> %_LOG%

::Amcache.hve
if %_VESION% == x64 (%_MAINTOOL%\forecopy_handy\forecopy_handy.exe -g > %_SaveFile%\registry_systemhive\amcache64.hve)
if %_VESION% == x86 (%_MAINTOOL%\forecopy_handy\forecopy_handy.exe -g > %_SaveFile%\registry_systemhive\amcache.hve)
echo Finished Amcache.hve forecopy_handy.exe -g ... %_SaveFile%\registry_systemhive\amcache64.hve
echo Finished Amcache.hve forecopy_handy.exe -g ... %_SaveFile%\registry_systemhive\amcache.hve >> %_LOG%


::EventLoG
:Event_Log
echo. 
if not exist %_SaveFile%\eventlog mkdir %_SaveFile%\eventlog
echo Event Log start ...!
echo Event Log start ...! >> %_LOG%

::Eventlog
if %_VESION% == x64 (%_MAINTOOL%\forecopy_handy\forecopy_handy.exe -e  %SystemRoot%\System32\winevt\Logs %_SaveFile%\eventlog)
if %_VESION% == x86 (%_MAINTOOL%\forecopy_handy\forecopy_handy.exe -e  %SystemRoot%\System32\winevt\Logs %_SaveFile%\eventlog)
echo Finished Eventlog forecopy_handy.exe -e  %SystemRoot%\System32\winevt\Logs ... %_SaveFile%\eventlog\eventlog64.txt
echo Finished Eventlog forecopy_handy.exe -e  %SystemRoot%\System32\winevt\Logs ... %_SaveFile%\eventlog\eventlog.txt >> %_LOG%

::Freepatch
:Freepatch
echo Freepatch start ...!
echo Freepatch start ...! >> %_LOG%

::freepatch 
if %_VESION% == x64 (%_MAINTOOL%\forecopy_handy\forecopy_handy.exe -d %SystemDrive%\Windows\Prefetch %_SaveFile%)
if %_VESION% == x86 (%_MAINTOOL%\forecopy_handy\forecopy_handy.exe -d %SystemDrive%\Windows\Prefetch %_SaveFile%)
echo Finished Freepatch forecopy_handy.exe -d %SystemDrive%\Windows\Prefetch ... %_SaveFile%
echo Finished Freepatch forecopy_handy.exe -d %SystemDrive%\Windows\Prefetch ... %_SaveFile% >> %_LOG%


::LNK
:LNK
echo. 
if not exist %_SaveFile%\lnk mkdir %_SaveFile%\lnk
echo LNK start ...!
echo LNK start ...! >> %_LOG%

:: .utomaticDestinations-ms 
if %_VESION% == x64 (%SystemRoot%\SysWOW64\Robocopy.exe  /MIR %AppData%\microsoft\windows\recent\AutomaticDestinations %_SaveFile%\LNK > %_SaveFile%\LNK\JumpList_AutomaticDestinations64)
if %_VESION% == x86 (%SystemRoot%\System32\Robocopy.exe  /MIR %AppData%\microsoft\windows\recent\AutomaticDestinations %_SaveFile%\LNK > %_SaveFile%\LNK\JumpList_AutomaticDestinations)
echo Finished Robocopy.exe  /MIR %AppData%\microsoft\windows\recent\AutomaticDestinations %_SaveFile%\LNK  ...  %_SaveFile%\LNK\JumpList_AutomaticDestinations64.automaticDestinations-ms
echo Finished Robocopy.exe  /MIR %AppData%\microsoft\windows\recent\AutomaticDestinations %_SaveFile%\LNK  ...  %_SaveFile%\LNK\JumpList_AutomaticDestinations64.automaticDestinations-ms >> %_LOG%

:: .customDestinations-ms
if %_VESION% == x64 (%SystemRoot%\SysWOW64\Robocopy.exe   /MIR %AppData%\microsoft\windows\recent\CustomDestinations %_SaveFile%\LNK > %_SaveFile%\LNK\JumpList_CustomDestinations64)
if %_VESION% == x86 (%SystemRoot%\System32\Robocopy.exe   /MIR %AppData%\microsoft\windows\recent\CustomDestinations %_SaveFile%\LNK > %_SaveFile%\LNK\JumpList_CustomDestinations)
echo Finished Robocopy.exe  /MIR %AppData%\microsoft\windows\recent\CustomDestinations %_SaveFile%\LNK ...  %_SaveFile%\LNK\JumpList_CustomDestinations64.customDestinations-ms
echo Finished Robocopy.exe  /MIR %AppData%\microsoft\windows\recent\CustomDestinations %_SaveFile%\LNK ...  %_SaveFile%\LNK\JumpList_CustomDestinations64.customDestinations-ms >> %_LOG%

::Start Programs
if %_VESION% == x64 (%SystemRoot%\SysWOW64\Robocopy.exe  /MIR %ProgramData%\Microsoft\Windows\Start Menu\Programs %_SaveFile%\LNK > %_SaveFile%\LNK\JumpList_programes64)
if %_VESION% == x86 (%SystemRoot%\System32\Robocopy.exe  /MIR %ProgramData%\Microsoft\Windows\Start Menu\Programs %_SaveFile%\LNK > %_SaveFile%\LNK\JumpList_programes)
echo Finished Robocopy.exe  /MIR %ProgramData%\Microsoft\Windows\Start Menu\Programs %_SaveFile%\LNK ...  %_SaveFile%\LNK\JumpList_programes64
echo Finished Robocopy.exe  /MIR %ProgramData%\Microsoft\Windows\Start Menu\Programs %_SaveFile%\LNK ...  %_SaveFile%\LNK\JumpList_programes >> %_LOG%


::Recycle.Bin
:RecycleBin
echo. 
if not exist %_SaveFile%\recycleBin mkdir %_SaveFile%\recycleBin
echo RecycleBin start ...!
echo RecycleBin start ...! >> %_LOG%

if %_VESION% == x64 (%SystemRoot%\SysWOW64\Robocopy.exe  /MIR %SystemDrive%\$Recycle.Bin\%UserName%  %_SaveFile%\recycleBin\recycleBin64 /zb)
if %_VESION% == x86 (%SystemRoot%\System32\Robocopy.exe  /MIR %SystemDrive%\$Recycle.Bin\%UserName%  %_SaveFile%\recycleBin\recycleBin /zb)
echo Finished Robocopy.exe  /MIR %SystemDrive%\$Recycle.Bin\%UserName% %_SaveFile%\RecycleBin /zb...  %_SaveFile%\recycleBin\recycleBin64
echo Finished Robocopy.exe  /MIR %SystemDrive%\$Recycle.Bin\%UserName% %_SaveFile%\RecycleBin /zb...  %_SaveFile%\recycleBin\recycleBin >> %_LOG%


::taskschedulerview
:taskscheduler
echo. 
if not exist %_SaveFile%\taskscheduler mkdir %_SaveFile%\taskscheduler
echo taskscheduler start ...!
echo taskscheduler start ...! >> %_LOG%


::taskschedulerview
if %_VESION% == x64 (%_MAINTOOL%\taskschedulerview-x64\taskschedulerview.exe /stext > %_SaveFile%\taskscheduler\taskschedulerview64.txt)
if %_VESION% == x86 (%_MAINTOOL%\taskschedulerview\taskschedulerview.exe /stext > %_SaveFile%\taskscheduler\taskschedulerview.txt)
echo Finished taskschedulerview.exe /stext ...  %_SaveFile%\taskscheduler\taskschedulerview64.txt
echo Finished taskschedulerview.exe /stext ...  %_SaveFile%\taskscheduler\taskschedulerview.txt >> %_LOG%


::WER(Windows Error Reporting)
:Windows_Error_Reporting
echo. 
if not exist %_SaveFile%\WindowsErrorReporting mkdir %_SaveFile%\WindowsErrorReporting
echo Windows Error Reporting start ...!
echo Windows Error Reporting start ...! >> %_LOG%

if %_VESION% == x64 (%SystemRoot%\SysWOW64\Robocopy.exe  /MIR %SystemDrive%\ProgramData\Microsoft\Windows\WER %_SaveFile%\WindowsErrorReporting\WindowsErrorReporting64 /zb)
if %_VESION% == x86 (%SystemRoot%\System32\Robocopy.exe  /MIR %SystemDrive%\ProgramData\Microsoft\Windows\WER %_SaveFile%\WindowsErrorReporting\WindowsErrorReporting /zb)
echo Finished Robocopy.exe  /MIR %SystemDrive%\ProgramData\Microsoft\Windows\WER %_SaveFile%\WindowsErrorReporting /zb...  %_SaveFile%\WindowsErrorReporting\WindowsErrorReporting64
echo Finished Robocopy.exe  /MIR %SystemDrive%\ProgramData\Microsoft\Windows\WER %_SaveFile%\WindowsErrorReporting /zb...  %_SaveFile%\WindowsErrorReporting\WindowsErrorReporting >> %_LOG%

::SRUM(System Resource Usage Monitor)
:System_Resource_Usage_Monitor
echo. 
if not exist %_SaveFile%\SystemResourceUsageMonitor mkdir %_SaveFile%\SystemResourceUsageMonitor
echo Windows Error Reporting start ...!
echo Windows Error Reporting start ...! >> %_LOG%

if %_VESION% == x64 (%SystemRoot%\SysWOW64\Robocopy.exe  /MIR %SystemDrive%\Windows\System32\sru %_SaveFile%\SystemResourceUsageMonitor  > %_SaveFile%\SystemResourceUsageMonitor\SystemResourceUsageMonitor64)
if %_VESION% == x86 (%SystemRoot%\System32\Robocopy.exe  /MIR %SystemDrive%\Windows\System32\sru %_SaveFile%\SystemResourceUsageMonitor  > %_SaveFile%\SystemResourceUsageMonitor\SystemResourceUsageMonitor)
echo Finished Robocopy.exe  /MIR %SystemDrive%\Windows\System32\sru %_SaveFile%\SystemResourceUsageMonitor ...  %_SaveFile%\SystemResourceUsageMonitor\SystemResourceUsageMonitor64
echo Finished Robocopy.exe  /MIR %SystemDrive%\Windows\System32\sru %_SaveFile%\SystemResourceUsageMonitor ...  %_SaveFile%\SystemResourceUsageMonitor\SystemResourceUsageMonitor >> %_LOG%


::VSC(Volume Shadow Copy)
:Volume_Shadow_Copy
echo. 
if not exist %_SaveFile%\VolumeShadowCopy mkdir %_SaveFile%\VolumeShadowCopy
echo Volume Shadow Copy start ...!
echo Volume Shadow Copy start ...! >> %_LOG%

if %_VESION% == x64 (%_MAINTOOL%\shadowcopyview-x64\shadowcopyview.exe /scomma %_SaveFile%\VolumeShadowCopy\shadowcopyview64)
if %_VESION% == x86 (%_MAINTOOL%\shadowcopyview\shadowcopyview.exe /scomma  %_SaveFile%\VolumeShadowCopy\shadowcopyview)
echo Finished shadowcopyview.exe /scomma  ... %_SaveFile%\VolumeShadowCopy\shadowcopyview64.txt
echo Finished shadowcopyview.exe /scomma  ... %_SaveFile%\VolumeShadowCopy\shadowcopyview.txt >> %_LOG%

::WindowsTimeLine
:WindowsTimeLine
echo. 
if not exist %_SaveFile%\WindowsTimeLine mkdir %_SaveFile%\WindowsTimeLine
echo WindowsTimeLine start ...!
echo WindowsTimeLine start ...! >> %_LOG%

if %_VESION% == x64 (%SystemRoot%\SysWOW64\Robocopy.exe  /MIR %LOCALAPPDATA%\ConnectedDevicesPlatform %_SaveFile%\WindowsTimeLine  > %_SaveFile%\WindowsTimeLine\WindowsTimeLine64)
if %_VESION% == x86 (%SystemRoot%\System32\Robocopy.exe  /MIR %LOCALAPPDATA%\ConnectedDevicesPlatform %_SaveFile%\WindowsTimeLine  > %_SaveFile%\WindowsTimeLine\WindowsTimeLine)
echo Finished Robocopy.exe  /MIR %LOCALAPPDATA%\ConnectedDevicesPlatform %_SaveFile%\WindowsTimeLine  %_SaveFile%\WindowsTimeLine\WindowsTimeLine64
echo Finished Robocopy.exe  /MIR %LOCALAPPDATA%\ConnectedDevicesPlatform %_SaveFile%\WindowsTimeLine  %_SaveFile%\WindowsTimeLine\WindowsTimeLine >> %_LOG%


::SystemCache
:SystemCache
echo. 
if not exist %_SaveFile%\SystemCache mkdir %_SaveFile%\SystemCache
echo SystemCache start ...!
echo SystemCache start ...! >> %_LOG%

::Shim Cache(aka. App Compatible Cache)
if %_VESION% == x64 (%SystemRoot%\SysWOW64\Robocopy.exe  /MIR %SystemDrive%\Windows\apppatch %_SaveFile%\SystemCache > %_SaveFile%\SystemCache\ShimCache64)
if %_VESION% == x86 (%SystemRoot%\System32\Robocopy.exe  /MIR %SystemDrive%\Windows\apppatch %_SaveFile%\SystemCache > %_SaveFile%\SystemCache\ShimCache)
echo Finished Robocopy.exe  /MIR %SystemDrive%\Windows\apppatch %_SaveFile%\SystemCache  %_SaveFile%\SystemCache\ShimCache64
echo Finished Robocopy.exe  /MIR %SystemDrive%\Windows\apppatch %_SaveFile%\SystemCache  %_SaveFile%\SystemCache\ShimCache >> %_LOG%

::RDP Cache
if %_VESION% == x64 (%SystemRoot%\SysWOW64\Robocopy.exe  /MIR %LOCALAPPDATA%\Microsoft\Terminal Server Client\Cache %_SaveFile%\SystemCache > %_SaveFile%\SystemCache\RDPCache_robocopy64)
if %_VESION% == x86 (%SystemRoot%\System32\Robocopy.exe  /MIR %LOCALAPPDATA%\Microsoft\Terminal Server Client\Cache %_SaveFile%\SystemCache > %_SaveFile%\SystemCache\RDPCache_robocopy)
echo Finished Robocopy.exe  /MIR %LOCALAPPDATA%\Microsoft\Terminal Server Client\Cache %_SaveFile%\SystemCache  %_SaveFile%\SystemCache\RDPCache64
echo Finished Robocopy.exe  /MIR %LOCALAPPDATA%\Microsoft\Terminal Server Client\Cache %_SaveFile%\SystemCache  %_SaveFile%\SystemCache\RDPCache >> %_LOG%

if %_VESION% == x64 (%SystemRoot%\SysWOW64\xcopy.exe  /Y /E /H %UserProfile%\Documents\Default.rdp %_SaveFile%\SystemCache > %_SaveFile%\SystemCache\RDPCache_xcopy64)
if %_VESION% == x86 (%SystemRoot%\System32\xcopy.exe  /Y /E /H %UserProfile%\Documents\Default.rdp %_SaveFile%\SystemCache > %_SaveFile%\SystemCache\RDPCache_xcopy)
echo Finished xcopy.exe  /Y /E /H %UserProfile%\Documents\Default.rdp %_SaveFile%\SystemCache  %_SaveFile%\SystemCache\RDPCache_xcopy64
echo Finished xcopy.exe  /Y /E /H %UserProfile%\Documents\Default.rdp %_SaveFile%\SystemCache  %_SaveFile%\SystemCache\RDPCache_xcopy >> %_LOG%

::Thumb Cashe
if %_VESION% == x64 (%SystemRoot%\SysWOW64\Robocopy.exe  /MIR %UserProfile%\AppData\Local\Microsoft\Windows\Explorer %_SaveFile%\SystemCache > %_SaveFile%\SystemCache\ThumbCashe64)
if %_VESION% == x86 (%SystemRoot%\System32\Robocopy.exe  /MIR %UserProfile%\AppData\Local\Microsoft\Windows\Explorer %_SaveFile%\SystemCache > %_SaveFile%\SystemCache\ThumbCashe)
echo Finished Robocopy.exe  /MIR %LOCALAPPDATA%\Microsoft\Terminal Server Client\Cache %_SaveFile%\SystemCache  %_SaveFile%\SystemCache\ThumbCashe64
echo Finished Robocopy.exe  /MIR %LOCALAPPDATA%\Microsoft\Terminal Server Client\Cache %_SaveFile%\SystemCache  %_SaveFile%\SystemCache\ThumbCashe >> %_LOG%

::Icon Cache
if %_VESION% == x64 (%SystemRoot%\SysWOW64\xcopy.exe  /Y /E /H %UserProfile%\AppData\Local\IconCache.db %_SaveFile%\SystemCache > %_SaveFile%\SystemCache\IconCache64)
if %_VESION% == x86 (%SystemRoot%\System32\xcopy.exe  /Y /E /H %UserProfile%\AppData\Local\IconCache.db %_SaveFile%\SystemCache > %_SaveFile%\SystemCache\IconCache)
echo Finished xcopy.exe  /Y /E /H %UserProfile%\AppData\Local\IconCache.db %_SaveFile%\SystemCache  %_SaveFile%\SystemCache\IconCache64
echo Finished xcopy.exe  /Y /E /H %UserProfile%\AppData\Local\IconCache.db %_SaveFile%\SystemCache  %_SaveFile%\SystemCache\IconCache >> %_LOG%


::Web_Browser
:Web_Browser
echo. 
if not exist %_SaveFile%\web_browser mkdir %_SaveFile%\web_browser
echo Web_Browser  start ...!
echo Web_Browser  start ...! >> %_LOG%


::BrowsingHistoryView
if %_VESION% == x64 (%_MAINTOOL%\browsinghistoryview-x64\BrowsingHistoryView.exe  /SaveDirect /scomma %_SaveFile%\web_browser\browsinghistoryview-x64.csv)
if %_VESION% == x86 (%_MAINTOOL%\browsinghistoryview\BrowsingHistoryView.exe      /SaveDirect /scomma %_SaveFile%\web_browser\browsinghistoryview.csv)
echo Finished BrowsingHistoryView.exe ... %_SaveFile%\web_browser\browsinghistoryview-x64.txt
echo Finished BrowsingHistoryView.exe ... %_SaveFile%\web_browser\browsinghistoryview.txt >> %_LOG%

::BrowsingDownloadsView
if %_VESION% == x64 (%_MAINTOOL%\browserdownloadsview-x64\BrowserDownloadsView.exe /SaveDirect /scomma %_SaveFile%\web_browser\browserdownloadsview-x64.csv)
if %_VESION% == x86 (%_MAINTOOL%\browserdownloadsview\BrowserDownloadsView.exe     /SaveDirect /scomma %_SaveFile%\web_browser\browserdownloadsview.csv)
echo Finished BrowsingDownloadsView.exe ... %_SaveFile%\web_browser\browserdownloadsview-x64.csv
echo Finished BrowsingDownloadsView.exe ... %_SaveFile%\web_browser\browserdownloadsview.csv >> %_LOG%


::BrowsingAddonsView
if %_VESION% == x64 (%_MAINTOOL%\browseraddonsview-x64\BrowserAddonsView.exe  /SaveDirect   /scomma %_SaveFile%\web_browser\browseraddonsview-x64.csv)
if %_VESION% == x86 (%_MAINTOOL%\browseraddonsview\BrowserAddonsView.exe      /SaveDirect   /scomma %_SaveFile%\web_browser\browseraddonsview.csv)
echo Finished BrowserAddonsView.exe ... %_SaveFile%\web_browser\browseraddonsview-x64.csv
echo Finished BrowserAddonsView.exe ... %_SaveFile%\web_browser\browseraddonsview.csv >> %_LOG%




echo.
echo # Ending for %_DATA_TIME% >> %_LOG%

ENDLOCAL
