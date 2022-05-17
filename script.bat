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
:: Code by duhyeoung.kim

SETLOCAL

:: settings
::

::OS Architecture (amd64가 맞으면 x64 아니면 x86으로 표시)
if %PROCESSOR_ARCHITECTURE% == "AMD64" ( set _OSARCH=x64) else ( set _OSARCH=x86)
echo %_OSARCH%
:: Case Name
set /p _CaseName=* Input CaseName. :
echo %_CaseName%

set /p _TestUserName=* Input TestUserName. :
echo %_TestUserName%

:SET_IS_MEMORY
set /p _IS_MEMORY=(!) DUMP PHYSICAL MEMOMRY. (y or n):
if /i "%_IS_MEMORY%" == "y" GOTO:SET_IS_DISK
if /i "%_IS_MEMORY%" == "n" GOTO:SET_IS_DISK
GOTO:SET_IS_MEMORY

:SET_IS_DISK
SET /p _IS_DISK=(!) DUMP PHYICAL DISK. (y or n):
if /i "%_IS_DISK%" == "y" GOTO:SET_OUTPUT
if /i "%_IS_DISK%" == "n" GOTO:SET_OUTPUT
GOTO:SET_IS_DISK

::file save name
:SET_OUTPUT
set _CASE_DIR=.\_output\%date::-=%_%_CaseName%_%_TestUserName%
if not exist %_CASE_DIR% mkdir %_CASE_DIR%


:: Target directory
set _TARGET_DIR=%_CASE_DIR%
if not exist %_TARGET_DIR% mkdir %_TARGET_DIR%

:: Tools Directory
set _3RD_TOOL_DIR=.\tools\3rd
set _OS_TOOL_DIR=.\tools\os

:: Logging
set _LOG=%_TARGET_DIR%\WLAS.log
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
      echo _CaseName: %_CaseName% >> %_LOG%
      echo _TestUserName: %_TestUserName% >> %_LOG%
      echo ^| >> %_LOG%
      echo _CASE_DIR: %_CaseName% >> %_LOG%
      echo _CASE_DIR: %_TestUserName% >> %_LOG%
      echo _TARGET_DIR: %_TARGET_DIR% >> %_LOG%
      echo _3RD_TOOL_DIR: %_3RD_TOOL_DIR% >> %_LOG%
      echo _OS_TOOL_DIR: %_OS_TOOL_DIR% >> %_LOG%
      echo ^| >> %_LOG%
      echo _IS_MEMORY: %_IS_MEMORY% >> %_LOG%
      echo _OSARCH: %_OSARCH% >> %_LOG%
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
if not exist %_TARGET_DIR%\memory mkdir %_TARGET_DIR%\memory

echo Creating physical memory image...
echo Creating physical memory image... >> %_LOG%


if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\winpmem\x64\winpmem_mini_x64_rc2.exe > %_TARGET_DIR%\memory\winpmem64.raw)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\winpmem\x64\winpmem_mini_x86.exe > %_TARGET_DIR%\memory\winpmem86.raw)
echo Completed physical memory image... %_TARGET_DIR% \memory\winpmem.raw
echo Completed physical memory image... %_TARGET_DIR% \memory\winpmem86.raw >> %_LOG%

::list and info-Cprocess---------------------------------
::Process 

:Process
echo.
if not exist %_TARGET_DIR%\process mkdir %_TARGET_DIR%\process
echo Process Start...
echo Process start... >> %_Log%

:: Pslist  
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\pslist\pslist64.exe  >%_TARGET_DIR%\process\pslist64.txt)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\pslist\pslist.exe    >%_TARGET_DIR%\process\pslist.txt)
echo Completed pslist64.exe ... %_TARGET_DIR%\process\pslist64.txt
echo Completed pslist.exe ... %_TARGET_DIR%\process\pslist.txt >> %_LOG%


::cProcess
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\cProcess\CProcess.exe /stext %_TARGET_DIR%\process\cprocess.txt)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\cProcess\CProcess.exe /stext %_TARGET_DIR%\process\cprocess86.txt)
echo Completed CProcess.exe ... %_TARGET_DIR%\process\cprocess.txt
echo Completed CProcess.exe ... %_TARGET_DIR%\process\cprocess86.txt >> %_LOG%


::procinterrogate(not found this .exe)
::if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\procinterrogate\procinterrogate.exe -list -md5 -ver -o >%_TARGET_DIR%\process\procinterrogate.txt)
::if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\procinterrogate\procinterrogate.exe -list -md5 -ver -o >%_TARGET_DIR%\process\procinterrogate86.txt)
::echo Completed procinterrogate.exe ... %_TARGET_DIR%\process\procinterrogate.txt
::echo Completed procinterrogate.exe ... %_TARGET_DIR%\process\procinterrogate86.txt >> %_LOG%

::Tasklist
if %_OSARCH% == x64 (%SystemRoot%\SysWOW64\tasklist.exe -V >%_TARGET_DIR%\process\tasklist.txt)
if %_OSARCH% == x86 (%SystemRoot%\System32\tasklist.exe -V >%_TARGET_DIR%\process\tasklist.txt)
echo Completed tasklist.exe ... %_TARGET_DIR%\process\tasklist.txt 
echo Completed tasklist.exe ... %_TARGET_DIR%\process\tasklist.txt >> %_LOG%

::Tree----------------------------------------------------------
::tlist 
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\tlist\tlist.exe -t >%_TARGET_DIR%\process\tlist64.txt)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\tlist\tlist.exe -t >%_TARGET_DIR%\process\tlist.txt)
echo Completed tlist.exe ... %_TARGET_DIR%\process\tlist64.txt 
echo Completed tlist.exe ... %_TARGET_DIR%\process\tlist.txt >> %_LOG%

::pslist
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\pslist\pslist64.exe -t >%_TARGET_DIR%\process\pslist64_tree.txt)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\pslist\pslist.exe   -t >%_TARGET_DIR%\process\pslist_tree.txt)
echo Completed pslist64_tree.exe ... %_TARGET_DIR%\process\pslist64_tree.txt
echo Completed pslisttree.exe ... %_TARGET_DIR%\process\pslist_tree.txt >> %_LOG%

::Handle--------------------
::handle
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\handle\handle64.exe -a >%_TARGET_DIR%\process\handle64.txt)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\handle\handle.exe   -a >%_TARGET_DIR%\process\handle.txt)
echo Completed handle.exe ... %_TARGET_DIR%\process\handle64.txt 
echo Completed handle.exe ... %_TARGET_DIR%\process\handle.txt >> %_LOG%

::openedfilesview
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\ofview-x64\OpenedFilesView.exe /stext > %_TARGET_DIR%\process\openedfilesview-64.txt)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\ofview-x32\OpenedFilesView.exe /stext > %_TARGET_DIR%\process\openedfilesview-32.txt)
echo Completed OpenedFilesView.exe ... %_TARGET_DIR%\process\openedfilesview-64.txt
echo Completed OpenedFilesView.exe ... %_TARGET_DIR%\process\openedfilesview-32.txt >> %_LOG%

::listobj
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\listobj\listobj.exe >%_TARGET_DIR%\process\listobj64.txt)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\listobj\listobj.exe >%_TARGET_DIR%\process\listobj.txt)
echo Completed listobj.exe ... %_TARGET_DIR%\process\listobj64.txt
echo Completed listobj.exe ... %_TARGET_DIR%\process\listobj.txt >> %_LOG%


::CommandLine--------------------------------
::tlist
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\tlist\tlist.exe -c >%_TARGET_DIR%\process\tlist64.txt)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\tlist\tlist.exe -c >%_TARGET_DIR%\process\tlist.txt)
echo Completed tlist.exe ... %_TARGET_DIR%\process\tlist64.txt
echo Completed tlist.exe ... %_TARGET_DIR%\process\tlist.txt >> %_LOG%

::DLL-------------------------------------
::listdlls
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\listdlls\listdlls64.exe -v > %_TARGET_DIR%\process\listdlls64.txt)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\listdlls\listdlls.exe -v > %_TARGET_DIR%\process\listdlls.txt)
echo Completed listdlls64.exe ... %_TARGET_DIR%\process\listdlls64.txt >> %_LOG%
echo Completed listdlls.exe ... %_TARGET_DIR%\process\listdlls.txt >> %_LOG%

::dllexp 
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\dllexp\dllexp64.exe /stext %_TARGET_DIR%\process\dllexp64.txt)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\dllexp\dllexp32.exe /stext %_TARGET_DIR%\process\dllexp.txt)
echo Completed dllexp.exe64 ... %_TARGET_DIR%\process\dllexp64.txt
echo Completed dllexp.exe32 ... %_TARGET_DIR%\process\dllexp.txt >> %_LOG%

::injecteddll
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\injectddll\InjectedDLL.exe /stext  %_TARGET_DIR%\process\injectddll64.txt)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\injectddll\InjectedDLL.exe /stext  %_TARGET_DIR%\process\injectddll.txt)
echo Completed InjectedDLL.exe ... %_TARGET_DIR%\process\injectddll64.txt
echo Completed InjectedDLL.exe ... %_TARGET_DIR%\process\injectddll.txt >> %_LOG%




::Service------------------------------------------------------------
:Service
echo.
if not exist %_TARGET_DIR%\service mkdir %_TARGET_DIR%\service
echo Service Start...
echo Service start... >> %_Log%


if %_OSARCH% == x64 (%SystemRoot%\SysWOW64\tasklist.exe -svc >%_TARGET_DIR%\service\tasklist_svc64.txt)
if %_OSARCH% == x86 (%SystemRoot%\System32\tasklist.exe -svc >%_TARGET_DIR%\service\tasklist_svc.txt)
echo Completed tasklist.exe -svc ... %_TARGET_DIR%\service\tasklist_svc64.txt
echo Completed tasklist.exe -svc ... %_TARGET_DIR%\service\tasklist_svc.txt >> %_LOG%

if %_OSARCH% == x64 (%SystemRoot%\SysWOW64\tasklist.exe -apps >%_TARGET_DIR%\service\tasklist_apps64.txt)
if %_OSARCH% == x86 (%SystemRoot%\System32\tasklist.exe -apps >%_TARGET_DIR%\service\tasklist_apps.txt)
echo Completed tasklist.exe -apps ... %_TARGET_DIR%\service\tasklist_apps64.txt
echo Completed tasklist.exe -apps ... %_TARGET_DIR%\service\tasklist_apps.txt >>%_LOG%

::psservice
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\pslist\psservice64.exe -v >%_TARGET_DIR%\service\psservice64.txt)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\pslist\psservice.exe -v >%_TARGET_DIR%\service\psservie.txt)
echo Completed psservice64.exe -v ... %_TARGET_DIR%\service\psservice64.txt
echo Completed psservice.exe -v ... %_TARGET_DIR%\service\psservice.txt >> %_LOG%

::tlist
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\tlist\tlist.exe -s >%_TARGET_DIR%\service\tlist64.txt)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\tlist\tlist.exe -s >%_TARGET_DIR%\service\tlist.txt)
echo Completed tlist.exe -s ... %_TARGET_DIR%\service\tlist64.txt 
echo Completed tlist.exe -s ... %_TARGET_DIR%\service\tlist.txt >> %_LOG%

::Driver---------------------------------------------------
:Driver
echo.
if not exist %_TARGET_DIR%\driver mkdir %_TARGET_DIR%\driver
echo Driver Start...
echo Driver start... >> %_Log%

::driverview
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\Driverview\DriverView64.exe /stext %_TARGET_DIR%\driver\driversiew64.txt)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\Driverview\DriverView32.exe /stext %_TARGET_DIR%\driver\driverview.txt)
echo Completed DriverView64.exe ... %_TARGET_DIR%\driver\drivers64.html
echo Completed DriverView32.exe ... %_TARGET_DIR%\driver\drivers64.html >> %_LOG%

::listdrivers 
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\listdrivers\listdrivers.exe /stext >%_TARGET_DIR%\driver\listdrivers64.txt)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\listdrivers\listdrivers.exe /stext >%_TARGET_DIR%\driver\listdrivers.txt)
echo Completed listdrivers.exe ... %_TARGET_DIR%\driver\listdrivers64.txt 
echo Completed listdrivers.exe ... %_TARGET_DIR%\driver\listdrivers.txt >> %_LOG%





::NETWORK---------------------------------------
:Network
echo.

if not exist %_TARGET_DIR%\network mkdir %_TARGET_DIR%\network
echo Network start...
echo Network start... >> %_Log%

::Promiscuois search
if %_OSARCH% == x64 ( %_3RD_TOOL_DIR%\promiscdetect_1\promiscdetect.exe > %_TARGET_DIR%\network\promiscdetect_search64.txt)
if %_OSARCH% == x86 ( %_3RD_TOOL_DIR%\promiscdetect_1\promiscdetect.exe > %_TARGET_DIR%\network\promiscdetect_search.txt)
echo Completed promiscdetect.exe ... %_TARGET_DIR%\network\promiscdetect_search64.txt
echo Completed promiscdetect.exe ... %_TARGET_DIR%\network\promiscdetect_search.txt >> %_LOG%

:: NIC MAC 
if %_OSARCH% == x64 ( %SystemRoot%\SysWOW64\getmac.exe > %_TARGET_DIR%\network\getmac64.txt)
if %_OSARCH% == x86 ( %SystemRoot%\System32\getmac.exe > %_TARGET_DIR%\network\getmac.txt)
echo Completed getmac.exe ... %_TARGET_DIR%\network\getmac64.txt
echo Completed getmac.exe ... %_TARGET_DIR%\network\getmac.txt >> %_LOG%

:: Nic Interface
if %_OSARCH% == x64 ( %SystemRoot%\SysWOW64\ipconfig.exe /all > %_TARGET_DIR%\network\ipconfig-all64.txt)
if %_OSARCH% == x86 ( %SystemRoot%\System32\ipconfig.exe /all > %_TARGET_DIR%\network\ipconfig-all.txt)
echo Completed ipconfig.exe ... %_TARGET_DIR%\network\ipconfig-all64.txt
echo Completed ipconfig.exe ... %_TARGET_DIR%\network\ipconfig-all.txt >> %_LOG%

:: DNS CASH
if %_OSARCH% == x64 ( %SystemRoot%\SysWOW64\ipconfig.exe /displaydns > %_TARGET_DIR%\network\ipconfig-cash64.txt)
if %_OSARCH% == x86 ( %SystemRoot%\System32\ipconfig.exe /displaydns > %_TARGET_DIR%\network\ipconfig-cash.txt)
echo Completed ipconfig.exe ... %_TARGET_DIR%\network\ipconfig-cash64.txt
echo Completed ipconfig.exe ... %_TARGET_DIR%\network\ipconfig-cash.txt >> %_LOG%

::Local Session-----------------문제가 있다 이말이야! 
:Local
echo.

if not exist %_TARGET_DIR%\local mkdir %_TARGET_DIR%\local
echo Local start...
echo Local start... >> %_Log%

if %_OSARCH% == x64 ( %SystemRoot%\SysWOW64\net session  \\%ComputerName% /DELETE > %_TARGET_DIR%\local\net64.txt)
if %_OSARCH% == x86 ( %SystemRoot%\System32\net session  \\%ComputerName% /DELETE > %_TARGET_DIR%\local\net.txt)
echo Completed net.exe ... %_TARGET_DIR%\local\net64.txt
echo Completed net.exe ... %_TARGET_DIR%\local\net.txt >> %_LOG%


::Network Session-------------
:Network_Session
echo.

if not exist %_TARGET_DIR%\network_session mkdir %_TARGET_DIR%\network_session
echo Network_Session...
echo Network_Session... >> %_Log%


::netstat 
if %_OSARCH% == x64 (%SystemRoot%\SysWOW64\netstat.exe -nao > %_TARGET_DIR%\network_session\tcp_ip_netstat64.txt)
if %_OSARCH% == x86 (%SystemRoot%\System32\netstat.exe -nao > %_TARGET_DIR%\network_session\tcp_ip_netstat.txt)
echo Completed net.exe ... %_TARGET_DIR%\local\tcp_ip_netstat64.txt
echo Completed net.exe ... %_TARGET_DIR%\local\tcp_ip_netstat.txt >> %_LOG%

::tcpvcon
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\tcpvcon\tcpvcon64.exe /a /c > %_TARGET_DIR%\network_session\tcp_ip_tcpvcon64.txt)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\tcpvcon\tcpvcon.exe /a /c > %_TARGET_DIR%\network_session\tcp_ip_tcpvcon.txt)
echo Completed tcpvcon64.exe ... %_TARGET_DIR% \network\tcp_ip_tcpvcon64.txt
echo Completed tcpvcon64.exe ... %_TARGET_DIR% \network\tcp_ip_tcpvcon.txt >> %_LOG%

::urlprotocolview
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\urlprotocolview\urlprotocolview.exe /stext %_TARGET_DIR%\network_session\urlprotocolview64.txt)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\urlprotocolview\urlprotocolview.exe /stext %_TARGET_DIR%\network_session\urlprotocolview.txt)
echo Completed urlprotocolview.exe ... %_TARGET_DIR% \network_session\urlprotocolview64.txt
echo Completed urlprotocolview.exe ... %_TARGET_DIR% \network_session\urlprotocolview.txt >> %_LOG%


::TCP/IP Open Port-------------------------------
:TCP_IP_Open_Port
echo.

if not exist %_TARGET_DIR%\tcp_ip_open_port mkdir %_TARGET_DIR%\tcp_ip_open_port
echo TCP_IP_Open_Port ...!!
echo TCP_IP_Open_Port ...!!  >> %_Log%

::cports
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\cports\cports.exe /stext > %_TARGET_DIR%\tcp_ip_open_port\cports64.txt)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\cports\cports.exe /stext> %_TARGET_DIR%\tcp_ip_open_port\cports.txt)
echo Completed cports.exe ... %_TARGET_DIR%\tcp_ip_open_port\cports64.txt
echo Completed cports.exe ... %_TARGET_DIR%\tcp_ip_open_port\cports.txt >> %_LOG%

::netstat
if %_OSARCH% == x64 (%SystemRoot%\SysWOW64\netstat.exe  -nao | findstr LISTENING > %_TARGET_DIR%\tcp_ip_open_port\netstat64.txt)
if %_OSARCH% == x86 (%SystemRoot%\System32\netstat.exe  -nao | findstr LISTENING > %_TARGET_DIR%\tcp_ip_open_port\netstat.txt)
echo Completed netstat.exe ... %_TARGET_DIR%\tcp_ip_open_port\netstat64.txt
echo Completed netstat.exe ... %_TARGET_DIR%\tcp_ip_open_port\netstat.txt >> %_LOG%

::LogON-------------------------------
:LogOn
echo. 
if not exist %_TARGET_DIR%\logon mkdir %_TARGET_DIR%\logon
echo LogON starts ...!
echo LogON starts ...! >> %_LOG%

::logon_user
if %_OSARCH% == x64 (%SystemRoot%\SysWOW64\net.exe  session > %_TARGET_DIR%\logon\logon_user64.txt)
if %_OSARCH% == x86 (%SystemRoot%\System32\net.exe  session > %_TARGET_DIR%\logon\logon_user.txt)
echo Completed net.exe ... %_TARGET_DIR%\logon\logon_user64.txt
echo Completed net.exe ... %_TARGET_DIR%\logon\logon_user.txt >> %_LOG%

::logonsessions
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\logonsessions\logonsessions64.exe  > %_TARGET_DIR%\logon\logonsessions64.txt)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\logonsessions\logonsessions.exe > %_TARGET_DIR%\logon\logonsessions.txt)
echo Completed logonsessions64.exe ... %_TARGET_DIR%\logon\logonsessions64.txt
echo Completed logonsessions.exe ... %_TARGET_DIR%\logon\logonsessions.txt >> %_LOG%

::psloggedon
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\psloggedon\psloggedon64.exe  > %_TARGET_DIR%\logon\psloggedon64.txt)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\psloggedon\psloggedon.exe > %_TARGET_DIR%\logon\psloggedon.txt)
echo Completed psloggedon64.exe ... %_TARGET_DIR%\logon\psloggedon64.txt
echo Completed psloggedon.exe ... %_TARGET_DIR%\logon\psloggedon.txt >> %_LOG%

::WinLogOnView 
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\WinLogOnView\WinLogOnView.exe /stext %_TARGET_DIR%\logon\winlogonview64.txt)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\WinLogOnView\WinLogOnView.exe /stext %_TARGET_DIR%\logon\winlogonview.txt)
echo Completed WinLogOnView.exe /stext ... %_TARGET_DIR%\logon\winlogonview64.txt
echo Completed WinLogOnView.exe /stext ... %_TARGET_DIR%\logon\Winlogonview.txt >> %_LOG%


::Address&Group--------------------------------------
:Address_Group
echo. 
if not exist %_TARGET_DIR%\address_group mkdir %_TARGET_DIR%\address_group
echo Address and Group start ...!
echo Address and Group start ...! >> %_LOG%

::user address list]
if %_OSARCH% == x64 (%SystemRoot%\SysWOW64\net.exe  user > %_TARGET_DIR%\address_group\user_address_list64.txt)
if %_OSARCH% == x86 (%SystemRoot%\System32\net.exe  user > %_TARGET_DIR%\address_group\user_address_list.txt)
echo Completed net.exe user ... %_TARGET_DIR%\address_group\user_address_list64.txt
echo Completed net.exe user ... %_TARGET_DIR%\address_group\user_address_list.txt >> %_LOG%

::admin Group list
if %_OSARCH% == x64 (%SystemRoot%\SysWOW64\net.exe   localgroup administrators > %_TARGET_DIR%\address_group\admin_group_list64.txt)
if %_OSARCH% == x86 (%SystemRoot%\System32\net.exe   localgroup administrators > %_TARGET_DIR%\address_group\admin_group_list.txt)
echo Completed net.exe localgroup administrators ... %_TARGET_DIR%\address_group\admin_group_list64.txt
echo Completed net.exe localgroup administrators ... %_TARGET_DIR%\address_group\admin_group_list.txt >> %_LOG%

::Active Directoy----------------------------------------
:Active_Directory
echo. 
if not exist %_TARGET_DIR%\gpo_policy mkdir %_TARGET_DIR%\gpo_policy
echo Active Directory start ...!
echo Active Directory start ...! >> %_LOG%

::gplist 
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\gplist\gplist.exe > %_TARGET_DIR%\gpo_policy\gplist64.txt)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\gplist\gplist.exe > %_TARGET_DIR%\gpo_policy\gplist.txt)
echo Completed gplist.exe ... %_TARGET_DIR%\gpo_policy\gplist64.txt
echo Completed gplist.exe ... %_TARGET_DIR%\gpo_policy\gplist.txt >> %_LOG%



::gpresult_H
if %_OSARCH% == x64 (%SystemRoot%\SysWOW64\gpresult.exe /H > %_TARGET_DIR%\gpo_policy\gpo_policy_H64.txt)
if %_OSARCH% == x86 (%SystemRoot%\System32\gpresult.exe /H > %_TARGET_DIR%\gpo_policy\gpo_policy_H.txt)
echo Completed gpresult.exe /H ... %_TARGET_DIR%\gpo_policy\gpo_policy_H64.txt
echo Completed gpresult.exe /H ... %_TARGET_DIR%\gpo_policy\gpo_policy_H.txt >> %_LOG%

::gpresult_Z
if %_OSARCH% == x64 (%SystemRoot%\SysWOW64\gpresult.exe /Z > %_TARGET_DIR%\gpo_policy\gpo_policy_Z64.txt)
if %_OSARCH% == x86 (%SystemRoot%\System32\gpresult.exe /Z > %_TARGET_DIR%\gpo_policy\gpo_policy_Z.txt)
echo Completed gpresult.exe /Z ... %_TARGET_DIR%\gpo_policy\gpo_policy_Z64.txt
echo Completed gpresult.exe /Z ... %_TARGET_DIR%\gpo_policy\gpo_policy_Z.txt >> %_LOG%

::gpresult_R
if %_OSARCH% == x64 (%SystemRoot%\SysWOW64\gpresult.exe /R > %_TARGET_DIR%\gpo_policy\gpo_policy_R64.txt)
if %_OSARCH% == x86 (%SystemRoot%\System32\gpresult.exe /R > %_TARGET_DIR%\gpo_policy\gpo_policy_R.txt)
echo Completed gpresult.exe /R ... %_TARGET_DIR%\gpo_policy\gpo_policy_R64.txt
echo Completed gpresult.exe /R ... %_TARGET_DIR%\gpo_policy\gpo_policy_R.txt >> %_LOG%


::Shared Resource-----------------------------------------
:Shared_Resource
echo. 
if not exist %_TARGET_DIR%\share_resource mkdir %_TARGET_DIR%\shared_resource
echo Shared_Resource start ...!
echo Shared_Resource start ...! >> %_LOG%

::share folder 
if %_OSARCH% == x64 (%SystemRoot%\SysWOW64\net.exe share > %_TARGET_DIR%\share_resource\share_folder64.txt)
if %_OSARCH% == x86 (%SystemRoot%\System32\net.exe share > %_TARGET_DIR%\share_resource\share_folder.txt)
echo Completed net.exe share ... %_TARGET_DIR%\share_resource\share_folder64.txt
echo Completed net.exe share ... %_TARGET_DIR%\share_resource\share_folder.txt >> %_LOG%

::share file
if %_OSARCH% == x64 (%SystemRoot%\SysWOW64\net.exe file > %_TARGET_DIR%\share_resource\share_file64.txt)
if %_OSARCH% == x86 (%SystemRoot%\System32\net.exe file > %_TARGET_DIR%\share_resource\share_file.txt)
echo Completed net.exe share file ... %_TARGET_DIR%\share_resource\share_file64.txt
echo Completed net.exe share file ... %_TARGET_DIR%\share_resource\share_file.txt >> %_LOG%


::NETBIOS-----------------------------------
:NetBIOS
echo. 
if not exist %_TARGET_DIR%\netbios mkdir %_TARGET_DIR%\netbios
echo NetBIOS start ...!
echo NetBIOS start ...! >> %_LOG%

::NBT_cash
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\nbtstat\nbtstat.exe -c > %_TARGET_DIR%\netbios\nbt_cash64.txt)
if %_OSARCH% == x86 (%SystemRoot%\System32\nbtstat.exe -c > %_TARGET_DIR%\netbios\nbt_cash.txt)
echo Completed nbtstat.exe -c ... %_TARGET_DIR%\netbios\nbt_cash64.txt
echo Completed nbtstat.exe -c ... %_TARGET_DIR%\netbios\nbt_cash.txt >> %_LOG%

::NBT_Local.
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\nbtstat\nbtstat.exe -n > %_TARGET_DIR%\netbios\nbt_local64.txt)
if %_OSARCH% == x86 (%SystemRoot%\System32\nbtstat.exe -n > %_TARGET_DIR%\netbios\nbt_local.txt)
echo Completed nbtstat.exe -n ... %_TARGET_DIR%\netbios\nbt_local64.txt
echo Completed nbtstat.exe -n ... %_TARGET_DIR%\netbios\nbt_local.txt >> %_LOG%

::NBT_Session
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\nbtstat\nbtstat.exe -s > %_TARGET_DIR%\netbios\nbt_session64.txt)
if %_OSARCH% == x86 (%SystemRoot%\System32\nbtstat.exe -s> %_TARGET_DIR%\netbios\nbt_session.txt)
echo Completed nbtstat.exe -s ... %_TARGET_DIR%\netbios\nbt_session64.txt
echo Completed nbtstat.exe -s ... %_TARGET_DIR%\netbios\nbt_session.txt >> %_LOG%


::ARP--------------------------------
:ARP
echo. 
if not exist %_TARGET_DIR%\arp mkdir %_TARGET_DIR%\arp
echo ARP start ...!
echo ARP start ...! >> %_LOG%


if %_OSARCH% == x64 (%SystemRoot%\SysWOW64\arp.exe -a -v > %_TARGET_DIR%\arp\arp64.txt)
if %_OSARCH% == x86 (%SystemRoot%\System32\arp.exe -a -v > %_TARGET_DIR%\arp\arp.txt)
echo Completed arp.exe -a -v ... %_TARGET_DIR%\arp\arp64.txt
echo Completed arp.exe -a -v ... %_TARGET_DIR%\arp\arp.txt >> %_LOG%

::route-----------------------------------------
:route
echo. 
if not exist %_TARGET_DIR%\route mkdir %_TARGET_DIR%\route
echo route start ...!
echo route start ...! >> %_LOG%

if %_OSARCH% == x64 (%SystemRoot%\SysWOW64\ROUTE.EXE PRINT -4 > %_TARGET_DIR%\route\route64.txt)
if %_OSARCH% == x86 (%SystemRoot%\System32\ROUTE.EXE PRINT -4 > %_TARGET_DIR%\route\route.txt)
echo Completed ROUTE.EXE PRINT -4 ... %_TARGET_DIR%\route\route64.txt
echo Completed ROUTE.EXE PRINT -4 ... %_TARGET_DIR%\route\route.txt >> %_LOG%

::Systeminfo-basic----------------------------------------
:Systeminfo_basic
echo. 
if not exist %_TARGET_DIR%\systeminfo_basic mkdir %_TARGET_DIR%\systeminfo_basic
echo Systeminfo_basic start ...!
echo Systeminfo_basic start ...! >> %_LOG%

::systeminfo
if %_OSARCH% == x64 (%SystemRoot%\SysWOW64\systeminfo.exe > %_TARGET_DIR%\systeminfo_basic\systeminfo64.txt)
if %_OSARCH% == x86 (%SystemRoot%\System32\systeminfo.exe > %_TARGET_DIR%\systeminfo_basic\systeminfo.txt)
echo Completed systeminfo.exe ... %_TARGET_DIR%\systeminfo_basic\systeminfo64.txt
echo Completed systeminfo.exe ... %_TARGET_DIR%\systeminfo_basic\systeminfo.txt >> %_LOG%

::psinfo
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\pslist\PsInfo64.exe -d >%_TARGET_DIR%\systeminfo_basic\psinfo64.txt)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\pslist\PsInfo.exe   -d >%_TARGET_DIR%\systeminfo_basic\psinfo.txt)
echo Completed PsInfo64.exe ... %_TARGET_DIR%\systeminfo_basic\psinfo64.txt
echo Completed PsInfo.exe ... %_TARGET_DIR%\systeminfo_basic\psinfo64.txt >> %_LOG%



::install list-----------------------------------------
:Install_list 
echo. 
if not exist %_TARGET_DIR%\installer_list mkdir %_TARGET_DIR%\installer_list
echo Installer_list  start ...!
echo Installer_list  start ...! >> %_LOG%

::Install Windows Update
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\wul\wul.exe /stext %_TARGET_DIR%\installer_list\windows_update_wul64.txt)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\wul\wul.exe /stext %_TARGET_DIR%\installer_list\windows_update_wul.txt)
echo Completed wul.exe /stext ... %_TARGET_DIR%\installer_list\windows_update_wul64.txt
echo Completed wul.exe /stext ... %_TARGET_DIR%\installer_list\windows_update_wul.txt >> %_LOG%



:: windows_update_systeminfo 
if %_OSARCH% == x64 (%SystemRoot%\SysWOW64\systeminfo > %_TARGET_DIR%\installer_list\windows_update_systeminfo64.txt)
if %_OSARCH% == x86 (%SystemRoot%\System32\systeminfo > %_TARGET_DIR%\installer_list\windows_update_systeminfo.txt)
echo Completed systeminfo.exe ... %_TARGET_DIR%\installer_list\windows_update_systeminfo64.txt
echo Completed systeminfo.exe ... %_TARGET_DIR%\installer_list\windows_update_systeminfo.txt >> %_LOG%


::Install Windows Hotfix 
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\pslist\PsInfo64.exe -h >%_TARGET_DIR%\installer_list\install_winodows_hotfix64.txt)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\pslist\PsInfo.exe -h >%_TARGET_DIR%\installer_list\install_winodows_hotfix.txt)
echo Completed PsInfo64.exe -h ... %_TARGET_DIR%\installer_list\install_winodows_hotfix64.txt
echo Completed PsInfo.exe -h ... %_TARGET_DIR%\installer_list\install_winodows_hotfix.txt >> %_LOG%

::Install Windows Software
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\pslist\PsInfo64.exe -s >%_TARGET_DIR%\installer_list\install_winodows_software64.txt)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\pslist\PsInfo.exe -s >%_TARGET_DIR%\installer_list\install_winodows_software.txt)
echo Completed PsInfo64.exe -s ... %_TARGET_DIR%\installer_list\install_winodows_software64.txt
echo Completed PsInfo.exe -s ... %_TARGET_DIR%\installer_list\install_winodows_software.txt >> %_LOG%

::Auto_set-------------------------------------
:Auto_Set 
echo. 
if not exist %_TARGET_DIR%\auto_set mkdir %_TARGET_DIR%\auto_set
echo Auto_Set  start ...!
echo Auto_Set  start ...! >> %_LOG%

::autorunsc 
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\autorunsc\autorunsc64.exe  -a * -c -h -s -u * -o /stext >%_TARGET_DIR%\auto_set\autorunsc64.txt)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\autorunsc\autorunsc.exe  -a * -c -h -s -u * -o /stext >%_TARGET_DIR%\auto_set\autorunsc.txt)
echo Completed autorunsc64.exe ... %_TARGET_DIR%\auto_set\autorunsc64.txt
echo Completed autorunsc.exe ... %_TARGET_DIR%\auto_set\autorunsc.txt >> %_LOG%

::Pipe------------------------------------
:Pipe
echo. 
if not exist %_TARGET_DIR%\pipelist mkdir %_TARGET_DIR%\pipelist
echo PipeList  start ...!
echo PipeList  start ...! >> %_LOG%

::piplist 

if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\PipeList\pipelist64.exe  >%_TARGET_DIR%\pipelist\pipelist64.txt)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\PipeList\pipelist.exe    >%_TARGET_DIR%\pipelist\pipelist.txt)
echo Completed pipelist64.exe ... %_TARGET_DIR%\pipelist\pipelist64.txt
echo Completed pipelist.exe ... %_TARGET_DIR%\pipelist\pipelist.txt >> %_LOG%

:: Non-volatile memory Starting Point

:: Psysical Disk
:Dump_DISK
if /i %_IS_DISK% == "n" GOTO:ACQ_LIVE
if not exist %_TARGET_DIR%\disk mkdir %_TARGET_DIR%\disk 
echo Creating physical disk image...
echo Creating physical disk image... >> %_LOG%

:: Psysical Disk image [dd] 완료
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\dd-0.5\dd.exe if =\\.\PhysicalDrive0 of=- bs=512 | %_3RD_TOOL_DIR%\dd-0.5\7za.exe a -si %_TARGET_DIR%\disk\pdi64.disk.7z)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\dd-0.5\dd.exe if =\\.\PhysicalDrive0 of=- bs=512 | %_3RD_TOOL_DIR%\dd-0.5\7za.exe a -si %_TARGET_DIR%\disk\pdi.disk.7z)
echo Completed physical disk image... %_TARGET_DIR%\disk\pdi64.disk.7z
echo Completed physical disk image... %_TARGET_DIR%\disk\pdi.disk.7z >> %_LOG%


::-------------------------------------------------MVMLU------------------------------------------
:MVMLU
if not exist %_TARGET_DIR%\mvmlu mkdir %_TARGET_DIR%\mvmlu
echo Starting MVMLU ...
echo Starting MVMLU ... >> %_LOG%

:: Master Boot Record 
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\dd-0.5\dd.exe if =\\.\PhysicalDrive0 of=%_TARGET_DIR%\mvmlu\mbr64.disk.7z bs=512 count=1)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\dd-0.5\dd.exe if =\\.\PhysicalDrive0 of=%_TARGET_DIR%\mvmlu\mbr.disk.7z bs=512 count=1)
echo Completed Master Boot Record if =\\.\PhysicalDrive0 of=_TARGET_DIR\mvmlu\mbr64.disk.7z bs=512 count=1 ... %_TARGET_DIR%\mvmlu\mbr64.disk.7z
echo Completed Master Boot Record if =\\.\PhysicalDrive0 of=_TARGET_DIR\mvmlu\mbr.disk.7z bs=512 count=1 ... %_TARGET_DIR%\mvmlu\mbr.disk.7z >> %_LOG%

::Volume Boot Record $VBR 
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\forecopy_handy\forecopy_handy.exe -f %SystemDrive%\$Boot %_TARGET_DIR%)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\forecopy_handy\forecopy_handy.exe -f %SystemDrive%\$Boot %_TARGET_DIR%)
echo Completed Volume Boot Record -f SystemDrive\$Boot... %_TARGET_DIR%
echo Completed Volume Boot Record -f SystemDrive\$Boot... %_TARGET_DIR%>> %_LOG%

::Master File Table $MFT
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\forecopy_handy\forecopy_handy.exe -m %_TARGET_DIR%)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\forecopy_handy\forecopy_handy.exe -m %_TARGET_DIR%)
echo Completed Master File Table -m ... %_TARGET_DIR%
echo Completed Master File Table -m ... %_TARGET_DIR% >> %_LOG%

::$LogFile
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\forecopy_handy\forecopy_handy.exe -f %SystemDrive%\$LogFile %_TARGET_DIR%)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\forecopy_handy\forecopy_handy.exe -f %SystemDrive%\$LogFile %_TARGET_DIR%)
echo Completed $LogFile -f SystemDrive\$LogFile ... %_TARGET_DIR%
echo Completed $LogFile -f SystemDrive\$LogFile ... %_TARGET_DIR% >> %_LOG%

::$UsnJrnl
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\forecopy_handy\forecopy_handy.exe -f %SystemDrive%\$Extend\$UsnJrnl:$J %_TARGET_DIR%)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\forecopy_handy\forecopy_handy.exe -f %SystemDrive%\$Extend\$UsnJrnl:$J %_TARGET_DIR%)
echo Completed $UsnJrnl -f SystemDrive\$Extend\$UsnJrnl:$J... %_TARGET_DIR%
echo Completed $UsnJrnl -f SystemDrive\$Extend\$UsnJrnl:$J... %_TARGET_DIR% >> %_LOG%


::Registry--------------------------------------
:Registry_User_Hive
echo. 
if not exist %_TARGET_DIR%\registry_userhive mkdir %_TARGET_DIR%\registry_userhive
echo Registry User Hive start ...!
echo Registry User Hive start ...! >> %_LOG%

::NTUSER.DAT
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\forecopy_handy\forecopy_handy.exe -g > %_TARGET_DIR%\registry_userhive\ntuse64.dat)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\forecopy_handy\forecopy_handy.exe -g > %_TARGET_DIR%\registry_userhive\ntuse.dat)
echo Completed NTUSER.DAT forecopy_handy.exe -g ... %_TARGET_DIR%\registry_userhive\ntuse64.dat
echo Completed NTUSER.DAT forecopy_handy.exe -g ... %_TARGET_DIR%\registry_userhive\ntuse.dat >> %_LOG%

::USRCLASS.DAT
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\forecopy_handy\forecopy_handy.exe -g > %_TARGET_DIR%\registry_userhive\usrclass64.dat)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\forecopy_handy\forecopy_handy.exe -g > %_TARGET_DIR%\registry_userhive\usrclass.dat)
echo Completed NTUSER.DAT forecopy_handy.exe -g ... %_TARGET_DIR%\registry_userhive\usrclass64.dat
echo Completed NTUSER.DAT forecopy_handy.exe -g ... %_TARGET_DIR%\registry_userhive\usrclass.dat >> %_LOG%



:Registry_System_Hive
echo. 
if not exist %_TARGET_DIR%\registry_systemhive mkdir %_TARGET_DIR%\registry_systemhive
echo Registry System Hive start ...!
echo Registry System Hive start ...! >> %_LOG%

::SAM
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\forecopy_handy\forecopy_handy.exe -g > %_TARGET_DIR%\registry_systemhive\sam64)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\forecopy_handy\forecopy_handy.exe -g > %_TARGET_DIR%\registry_systemhive\sam)
echo Completed SAM forecopy_handy.exe -g  ... %_TARGET_DIR%\registry_systemhive\sam64.sam
echo Completed SAM forecopy_handy.exe -g  ... %_TARGET_DIR%\registry_systemhive\sam.sam >> %_LOG%

::SECURITY
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\forecopy_handy\forecopy_handy.exe -g > %_TARGET_DIR%\registry_systemhive\security64)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\forecopy_handy\forecopy_handy.exe -g > %_TARGET_DIR%\registry_systemhive\security)
echo Completed SECURITY forecopy_handy.exe -g  ... %_TARGET_DIR%\registry_systemhive\security64.txt
echo Completed SECURITY forecopy_handy.exe -g  ... %_TARGET_DIR%\registry_systemhive\security.txt >> %_LOG%

::SOFTWARE
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\forecopy_handy\forecopy_handy.exe -g > %_TARGET_DIR%\registry_systemhive\software64)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\forecopy_handy\forecopy_handy.exe -g > %_TARGET_DIR%\registry_systemhive\software)
echo Completed SOFTWARE forecopy_handy.exe -g ... %_TARGET_DIR%\registry_systemhive\software64.txt
echo Completed SOFTWARE forecopy_handy.exe -g ... %_TARGET_DIR%\registry_systemhive\software.txt >> %_LOG%

::SYSTEM
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\forecopy_handy\forecopy_handy.exe -g > %_TARGET_DIR%\registry_systemhive\system64)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\forecopy_handy\forecopy_handy.exe -g > %_TARGET_DIR%\registry_systemhive\system)
echo Completed SYSTEM forecopy_handy.exe -g ... %_TARGET_DIR%\registry_systemhive\system64
echo Completed SYSTEM forecopy_handy.exe -g ... %_TARGET_DIR%\registry_systemhive\system >> %_LOG%

::DEFAULT
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\forecopy_handy\forecopy_handy.exe -g > %_TARGET_DIR%\registry_systemhive\default64)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\forecopy_handy\forecopy_handy.exe -g > %_TARGET_DIR%\registry_systemhive\default)
echo Completed DEFAULT forecopy_handy.exe -g ... %_TARGET_DIR%\registry_systemhive\default64
echo Completed DEFAULT forecopy_handy.exe -g ... %_TARGET_DIR%\registry_systemhive\default >> %_LOG%

::COMPONENTS
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\forecopy_handy\forecopy_handy.exe -g > %_TARGET_DIR%\registry_systemhive\components64)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\forecopy_handy\forecopy_handy.exe -g > %_TARGET_DIR%\registry_systemhive\components)
echo Completed COMPONENTS forecopy_handy.exe -g ... %_TARGET_DIR%\registry_systemhive\components64
echo Completed COMPONENTS forecopy_handy.exe -g ... %_TARGET_DIR%\registry_systemhive\components >> %_LOG%

::Amcache.hve
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\forecopy_handy\forecopy_handy.exe -g > %_TARGET_DIR%\registry_systemhive\amcache64.hve)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\forecopy_handy\forecopy_handy.exe -g > %_TARGET_DIR%\registry_systemhive\amcache.hve)
echo Completed Amcache.hve forecopy_handy.exe -g ... %_TARGET_DIR%\registry_systemhive\amcache64.hve
echo Completed Amcache.hve forecopy_handy.exe -g ... %_TARGET_DIR%\registry_systemhive\amcache.hve >> %_LOG%


::EventLoG--------------------------------------
:Event_Log
echo. 
if not exist %_TARGET_DIR%\eventlog mkdir %_TARGET_DIR%\eventlog
echo Event Log start ...!
echo Event Log start ...! >> %_LOG%

::Eventlog
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\forecopy_handy\forecopy_handy.exe -e  %SystemRoot%\System32\winevt\Logs %_TARGET_DIR%\eventlog\eventlog64.txt)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\forecopy_handy\forecopy_handy.exe -e  %SystemRoot%\System32\winevt\Logs %_TARGET_DIR%\eventlog\eventlog.txt)
echo Completed Eventlog forecopy_handy.exe -e  %SystemRoot%\System32\winevt\Logs ... %_TARGET_DIR%\eventlog\eventlog64.txt
echo Completed Eventlog forecopy_handy.exe -e  %SystemRoot%\System32\winevt\Logs ... %_TARGET_DIR%\eventlog\eventlog.txt >> %_LOG%

::Freepatch--------------------------------------
:Freepatch
echo Freepatch start ...!
echo Freepatch start ...! >> %_LOG%

::freepatch 
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\forecopy_handy\forecopy_handy.exe -d %SystemDrive%\Windows\Prefetch %_TARGET_DIR%)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\forecopy_handy\forecopy_handy.exe -d %SystemDrive%\Windows\Prefetch %_TARGET_DIR%)
echo Completed Freepatch forecopy_handy.exe -d %SystemDrive%\Windows\Prefetch ... %_TARGET_DIR%
echo Completed Freepatch forecopy_handy.exe -d %SystemDrive%\Windows\Prefetch ... %_TARGET_DIR% >> %_LOG%


::LNK--------------------------------------
:LNK
echo. 
if not exist %_TARGET_DIR%\lnk mkdir %_TARGET_DIR%\lnk
echo LNK start ...!
echo LNK start ...! >> %_LOG%

:: .utomaticDestinations-ms 
if %_OSARCH% == x64 (%SystemRoot%\SysWOW64\Robocopy.exe  /MIR %AppData%\microsoft\windows\recent\AutomaticDestinations %_TARGET_DIR%\LNK > %_TARGET_DIR%\LNK\JumpList_AutomaticDestinations64)
if %_OSARCH% == x86 (%SystemRoot%\System32\Robocopy.exe  /MIR %AppData%\microsoft\windows\recent\AutomaticDestinations %_TARGET_DIR%\LNK > %_TARGET_DIR%\LNK\JumpList_AutomaticDestinations)
echo Completed Robocopy.exe  /MIR %AppData%\microsoft\windows\recent\AutomaticDestinations %_TARGET_DIR%\LNK  ...  %_TARGET_DIR%\LNK\JumpList_AutomaticDestinations64.automaticDestinations-ms
echo Completed Robocopy.exe  /MIR %AppData%\microsoft\windows\recent\AutomaticDestinations %_TARGET_DIR%\LNK  ...  %_TARGET_DIR%\LNK\JumpList_AutomaticDestinations64.automaticDestinations-ms >> %_LOG%

:: .customDestinations-ms
if %_OSARCH% == x64 (%SystemRoot%\SysWOW64\Robocopy.exe   /MIR %AppData%\microsoft\windows\recent\CustomDestinations %_TARGET_DIR%\LNK > %_TARGET_DIR%\LNK\JumpList_CustomDestinations64)
if %_OSARCH% == x86 (%SystemRoot%\System32\Robocopy.exe   /MIR %AppData%\microsoft\windows\recent\CustomDestinations %_TARGET_DIR%\LNK > %_TARGET_DIR%\LNK\JumpList_CustomDestinations)
echo Completed Robocopy.exe  /MIR %AppData%\microsoft\windows\recent\CustomDestinations %_TARGET_DIR%\LNK ...  %_TARGET_DIR%\LNK\JumpList_CustomDestinations64.customDestinations-ms
echo Completed Robocopy.exe  /MIR %AppData%\microsoft\windows\recent\CustomDestinations %_TARGET_DIR%\LNK ...  %_TARGET_DIR%\LNK\JumpList_CustomDestinations64.customDestinations-ms >> %_LOG%

::Start Programs
if %_OSARCH% == x64 (%SystemRoot%\SysWOW64\Robocopy.exe  /MIR %ProgramData%\Microsoft\Windows\Start Menu\Programs %_TARGET_DIR%\LNK > %_TARGET_DIR%\LNK\JumpList_programes64)
if %_OSARCH% == x86 (%SystemRoot%\System32\Robocopy.exe  /MIR %ProgramData%\Microsoft\Windows\Start Menu\Programs %_TARGET_DIR%\LNK > %_TARGET_DIR%\LNK\JumpList_programes)
echo Completed Robocopy.exe  /MIR %ProgramData%\Microsoft\Windows\Start Menu\Programs %_TARGET_DIR%\LNK ...  %_TARGET_DIR%\LNK\JumpList_programes64
echo Completed Robocopy.exe  /MIR %ProgramData%\Microsoft\Windows\Start Menu\Programs %_TARGET_DIR%\LNK ...  %_TARGET_DIR%\LNK\JumpList_programes >> %_LOG%


::Recycle.Bin--------------------------------------
:RecycleBin
echo. 
if not exist %_TARGET_DIR%\recycleBin mkdir %_TARGET_DIR%\recycleBin
echo RecycleBin start ...!
echo RecycleBin start ...! >> %_LOG%

if %_OSARCH% == x64 (%SystemRoot%\SysWOW64\Robocopy.exe  /MIR %SystemDrive%\$Recycle.Bin\S-1-5-21-1180652474-3319797739-1632498776-1001 %_TARGET_DIR%\recycleBin\recycleBin64 /zb)
if %_OSARCH% == x86 (%SystemRoot%\System32\Robocopy.exe  /MIR %SystemDrive%\$Recycle.Bin\S-1-5-21-1180652474-3319797739-1632498776-1001 %_TARGET_DIR%\recycleBin\recycleBin /zb)
echo Completed Robocopy.exe  /MIR %SystemDrive%\$Recycle.Bin\S-1-5-21-1180652474-3319797739-1632498776-1001 %_TARGET_DIR%\RecycleBin /zb...  %_TARGET_DIR%\recycleBin\recycleBin64
echo Completed Robocopy.exe  /MIR %SystemDrive%\$Recycle.Bin\S-1-5-21-1180652474-3319797739-1632498776-1001 %_TARGET_DIR%\RecycleBin /zb...  %_TARGET_DIR%\recycleBin\recycleBin >> %_LOG%


::taskschedulerview----------------------------------
:taskscheduler
echo. 
if not exist %_TARGET_DIR%\taskscheduler mkdir %_TARGET_DIR%\taskscheduler
echo taskscheduler start ...!
echo taskscheduler start ...! >> %_LOG%


::taskschedulerview
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\taskschedulerview-x64\taskschedulerview.exe /stext > %_TARGET_DIR%\taskscheduler\taskschedulerview64.txt)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\taskschedulerview\taskschedulerview.exe /stext > %_TARGET_DIR%\taskscheduler\taskschedulerview.txt)
echo Completed taskschedulerview.exe /stext ...  %_TARGET_DIR%\taskscheduler\taskschedulerview64.txt
echo Completed taskschedulerview.exe /stext ...  %_TARGET_DIR%\taskscheduler\taskschedulerview.txt >> %_LOG%


::WER(Windows Error Reporting)-----------------------------------
:Windows_Error_Reporting
echo. 
if not exist %_TARGET_DIR%\WindowsErrorReporting mkdir %_TARGET_DIR%\WindowsErrorReporting
echo Windows Error Reporting start ...!
echo Windows Error Reporting start ...! >> %_LOG%

if %_OSARCH% == x64 (%SystemRoot%\SysWOW64\Robocopy.exe  /MIR %SystemDrive%\ProgramData\Microsoft\Windows\WER %_TARGET_DIR%\WindowsErrorReporting\WindowsErrorReporting64 /zb)
if %_OSARCH% == x86 (%SystemRoot%\System32\Robocopy.exe  /MIR %SystemDrive%\ProgramData\Microsoft\Windows\WER %_TARGET_DIR%\WindowsErrorReporting\WindowsErrorReporting /zb)
echo Completed Robocopy.exe  /MIR %SystemDrive%\ProgramData\Microsoft\Windows\WER %_TARGET_DIR%\WindowsErrorReporting /zb...  %_TARGET_DIR%\WindowsErrorReporting\WindowsErrorReporting64
echo Completed Robocopy.exe  /MIR %SystemDrive%\ProgramData\Microsoft\Windows\WER %_TARGET_DIR%\WindowsErrorReporting /zb...  %_TARGET_DIR%\WindowsErrorReporting\WindowsErrorReporting >> %_LOG%

::SRUM(System Resource Usage Monitor)--------------------------------
:System_Resource_Usage_Monitor
echo. 
if not exist %_TARGET_DIR%\SystemResourceUsageMonitor mkdir %_TARGET_DIR%\SystemResourceUsageMonitor
echo Windows Error Reporting start ...!
echo Windows Error Reporting start ...! >> %_LOG%

if %_OSARCH% == x64 (%SystemRoot%\SysWOW64\Robocopy.exe  /MIR %SystemDrive%\Windows\System32\sru %_TARGET_DIR%\SystemResourceUsageMonitor  > %_TARGET_DIR%\SystemResourceUsageMonitor\SystemResourceUsageMonitor64)
if %_OSARCH% == x86 (%SystemRoot%\System32\Robocopy.exe  /MIR %SystemDrive%\Windows\System32\sru %_TARGET_DIR%\SystemResourceUsageMonitor  > %_TARGET_DIR%\SystemResourceUsageMonitor\SystemResourceUsageMonitor)
echo Completed Robocopy.exe  /MIR %SystemDrive%\Windows\System32\sru %_TARGET_DIR%\SystemResourceUsageMonitor ...  %_TARGET_DIR%\SystemResourceUsageMonitor\SystemResourceUsageMonitor64
echo Completed Robocopy.exe  /MIR %SystemDrive%\Windows\System32\sru %_TARGET_DIR%\SystemResourceUsageMonitor ...  %_TARGET_DIR%\SystemResourceUsageMonitor\SystemResourceUsageMonitor >> %_LOG%


::VSC(Volume Shadow Copy)-----------------------------------
:Volume_Shadow_Copy
echo. 
if not exist %_TARGET_DIR%\VolumeShadowCopy mkdir %_TARGET_DIR%\VolumeShadowCopy
echo Volume Shadow Copy start ...!
echo Volume Shadow Copy start ...! >> %_LOG%

if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\shadowcopyview-x64\shadowcopyview.exe /scomma %_TARGET_DIR%\VolumeShadowCopy\shadowcopyview64)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\shadowcopyview\shadowcopyview.exe /scomma  %_TARGET_DIR%\VolumeShadowCopy\shadowcopyview)
echo Completed shadowcopyview.exe /scomma  ... %_TARGET_DIR%\VolumeShadowCopy\shadowcopyview64.txt
echo Completed shadowcopyview.exe /scomma  ... %_TARGET_DIR%\VolumeShadowCopy\shadowcopyview.txt >> %_LOG%

::WindowsTimeLine-----------------------------
:WindowsTimeLine
echo. 
if not exist %_TARGET_DIR%\WindowsTimeLine mkdir %_TARGET_DIR%\WindowsTimeLine
echo WindowsTimeLine start ...!
echo WindowsTimeLine start ...! >> %_LOG%

if %_OSARCH% == x64 (%SystemRoot%\SysWOW64\Robocopy.exe  /MIR %LOCALAPPDATA%\ConnectedDevicesPlatform %_TARGET_DIR%\WindowsTimeLine  > %_TARGET_DIR%\WindowsTimeLine\WindowsTimeLine64)
if %_OSARCH% == x86 (%SystemRoot%\System32\Robocopy.exe  /MIR %LOCALAPPDATA%\ConnectedDevicesPlatform %_TARGET_DIR%\WindowsTimeLine  > %_TARGET_DIR%\WindowsTimeLine\WindowsTimeLine)
echo Completed Robocopy.exe  /MIR %LOCALAPPDATA%\ConnectedDevicesPlatform %_TARGET_DIR%\WindowsTimeLine  %_TARGET_DIR%\WindowsTimeLine\WindowsTimeLine64
echo Completed Robocopy.exe  /MIR %LOCALAPPDATA%\ConnectedDevicesPlatform %_TARGET_DIR%\WindowsTimeLine  %_TARGET_DIR%\WindowsTimeLine\WindowsTimeLine >> %_LOG%


::SystemCache------------------------------
:SystemCache
echo. 
if not exist %_TARGET_DIR%\SystemCache mkdir %_TARGET_DIR%\SystemCache
echo SystemCache start ...!
echo SystemCache start ...! >> %_LOG%

::Shim Cache(aka. App Compatible Cache)
if %_OSARCH% == x64 (%SystemRoot%\SysWOW64\Robocopy.exe  /MIR %SystemDrive%\Windows\apppatch %_TARGET_DIR%\SystemCache > %_TARGET_DIR%\SystemCache\ShimCache64)
if %_OSARCH% == x86 (%SystemRoot%\System32\Robocopy.exe  /MIR %SystemDrive%\Windows\apppatch %_TARGET_DIR%\SystemCache > %_TARGET_DIR%\SystemCache\ShimCache)
echo Completed Robocopy.exe  /MIR %SystemDrive%\Windows\apppatch %_TARGET_DIR%\SystemCache  %_TARGET_DIR%\SystemCache\ShimCache64
echo Completed Robocopy.exe  /MIR %SystemDrive%\Windows\apppatch %_TARGET_DIR%\SystemCache  %_TARGET_DIR%\SystemCache\ShimCache >> %_LOG%

::RDP Cache
if %_OSARCH% == x64 (%SystemRoot%\SysWOW64\Robocopy.exe  /MIR %LOCALAPPDATA%\Microsoft\Terminal Server Client\Cache %_TARGET_DIR%\SystemCache > %_TARGET_DIR%\SystemCache\RDPCache_robocopy64)
if %_OSARCH% == x86 (%SystemRoot%\System32\Robocopy.exe  /MIR %LOCALAPPDATA%\Microsoft\Terminal Server Client\Cache %_TARGET_DIR%\SystemCache > %_TARGET_DIR%\SystemCache\RDPCache_robocopy)
echo Completed Robocopy.exe  /MIR %LOCALAPPDATA%\Microsoft\Terminal Server Client\Cache %_TARGET_DIR%\SystemCache  %_TARGET_DIR%\SystemCache\RDPCache64
echo Completed Robocopy.exe  /MIR %LOCALAPPDATA%\Microsoft\Terminal Server Client\Cache %_TARGET_DIR%\SystemCache  %_TARGET_DIR%\SystemCache\RDPCache >> %_LOG%

if %_OSARCH% == x64 (%SystemRoot%\SysWOW64\xcopy.exe  /Y /E /H %UserProfile%\Documents\Default.rdp %_TARGET_DIR%\SystemCache > %_TARGET_DIR%\SystemCache\RDPCache_xcopy64)
if %_OSARCH% == x86 (%SystemRoot%\System32\xcopy.exe  /Y /E /H %UserProfile%\Documents\Default.rdp %_TARGET_DIR%\SystemCache > %_TARGET_DIR%\SystemCache\RDPCache_xcopy)
echo Completed xcopy.exe  /Y /E /H %UserProfile%\Documents\Default.rdp %_TARGET_DIR%\SystemCache  %_TARGET_DIR%\SystemCache\RDPCache_xcopy64
echo Completed xcopy.exe  /Y /E /H %UserProfile%\Documents\Default.rdp %_TARGET_DIR%\SystemCache  %_TARGET_DIR%\SystemCache\RDPCache_xcopy >> %_LOG%

::Thumb Cashe
if %_OSARCH% == x64 (%SystemRoot%\SysWOW64\Robocopy.exe  /MIR %UserProfile%\AppData\Local\Microsoft\Windows\Explorer %_TARGET_DIR%\SystemCache > %_TARGET_DIR%\SystemCache\ThumbCashe64)
if %_OSARCH% == x86 (%SystemRoot%\System32\Robocopy.exe  /MIR %UserProfile%\AppData\Local\Microsoft\Windows\Explorer %_TARGET_DIR%\SystemCache > %_TARGET_DIR%\SystemCache\ThumbCashe)
echo Completed Robocopy.exe  /MIR %LOCALAPPDATA%\Microsoft\Terminal Server Client\Cache %_TARGET_DIR%\SystemCache  %_TARGET_DIR%\SystemCache\ThumbCashe64
echo Completed Robocopy.exe  /MIR %LOCALAPPDATA%\Microsoft\Terminal Server Client\Cache %_TARGET_DIR%\SystemCache  %_TARGET_DIR%\SystemCache\ThumbCashe >> %_LOG%

::Icon Cache
if %_OSARCH% == x64 (%SystemRoot%\SysWOW64\xcopy.exe  /Y /E /H %UserProfile%\AppData\Local\IconCache.db %_TARGET_DIR%\SystemCache > %_TARGET_DIR%\SystemCache\IconCache64)
if %_OSARCH% == x86 (%SystemRoot%\System32\xcopy.exe  /Y /E /H %UserProfile%\AppData\Local\IconCache.db %_TARGET_DIR%\SystemCache > %_TARGET_DIR%\SystemCache\IconCache)
echo Completed xcopy.exe  /Y /E /H %UserProfile%\AppData\Local\IconCache.db %_TARGET_DIR%\SystemCache  %_TARGET_DIR%\SystemCache\IconCache64
echo Completed xcopy.exe  /Y /E /H %UserProfile%\AppData\Local\IconCache.db %_TARGET_DIR%\SystemCache  %_TARGET_DIR%\SystemCache\IconCache >> %_LOG%


::Web_Browser---------
:Web_Browser
echo. 
if not exist %_TARGET_DIR%\web_browser mkdir %_TARGET_DIR%\web_browser
echo Web_Browser  start ...!
echo Web_Browser  start ...! >> %_LOG%


::BrowsingHistoryView
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\browsinghistoryview-x64\BrowsingHistoryView.exe  /SaveDirect /scomma %_TARGET_DIR%\web_browser\browsinghistoryview-x64.csv)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\browsinghistoryview\BrowsingHistoryView.exe      /SaveDirect /scomma %_TARGET_DIR%\web_browser\browsinghistoryview.csv)
echo Completed BrowsingHistoryView.exe ... %_TARGET_DIR%\web_browser\browsinghistoryview-x64.txt
echo Completed BrowsingHistoryView.exe ... %_TARGET_DIR%\web_browser\browsinghistoryview.txt >> %_LOG%

::BrowsingDownloadsView
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\browserdownloadsview-x64\BrowserDownloadsView.exe /SaveDirect /scomma %_TARGET_DIR%\web_browser\browserdownloadsview-x64.csv)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\browserdownloadsview\BrowserDownloadsView.exe     /SaveDirect /scomma %_TARGET_DIR%\web_browser\browserdownloadsview.csv)
echo Completed BrowsingDownloadsView.exe ... %_TARGET_DIR%\web_browser\browserdownloadsview-x64.csv
echo Completed BrowsingDownloadsView.exe ... %_TARGET_DIR%\web_browser\browserdownloadsview.csv >> %_LOG%


::BrowsingAddonsView
if %_OSARCH% == x64 (%_3RD_TOOL_DIR%\browseraddonsview-x64\BrowserAddonsView.exe  /SaveDirect   /scomma %_TARGET_DIR%\web_browser\browseraddonsview-x64.csv)
if %_OSARCH% == x86 (%_3RD_TOOL_DIR%\browseraddonsview\BrowserAddonsView.exe      /SaveDirect   /scomma %_TARGET_DIR%\web_browser\browseraddonsview.csv)
echo Completed BrowserAddonsView.exe ... %_TARGET_DIR%\web_browser\browseraddonsview-x64.csv
echo Completed BrowserAddonsView.exe ... %_TARGET_DIR%\web_browser\browseraddonsview.csv >> %_LOG%





:: Acquisution Ending Point
echo.
echo # Ending for %_DATA_TIME% >> %_LOG%

ENDLOCAL
