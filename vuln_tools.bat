@ECHO OFF

title windows server checklist

color F0

:: 지역변수 -> 지역이 끝나면 변수 제거
SETLOCAL

:: :: 관리자 권한으로 실행했을 때 system32 위의 경로가 아닌 배치파일이 있는 경로로 강제지정
PUSHD %~DP0

:: ComputerName
set hostname=%COMPUTERNAME%

:: OS Architecture
if "%PROCESSOR_ARCHITECTURE%" == "AMD64" ( set _yoursystem=윈도우즈x64 ) else ( set _yoursystem=윈도우즈x86 )
echo.
echo 사용 중인 시스템은 %_yoursystem%입니다.
echo.

:: Case Name
set /p CaseName=(!) 작업자 이름을 입력해주세요. :
echo.
echo 입력하신 작업자 이름은 %CaseName%입니다.
echo.

:SET_Ss_Disk
set /p _Ss_Disk=(!) 프로그램을 시작하시겠습니까? (n 입력 시 프로그램 종료):
if /i "%_Ss_Disk%" == "y" GOTO:SELECT
if /i "%_Ss_Disk%" == "n" GOTO:END

:SELECT
echo.
echo (!) 1_Page. 아래 목록에서 원하는 숫자를 입력해주세요.
echo -------------------------------------------------------------------------------------------------
echo                                  1. 전체 확인
echo.
echo                                  2. Administrator 계정 이름 변경 또는 보안성 강화 확인
echo.
echo                                  3. Guest 계정 비활성화 확인
echo.
echo                                  4. 불필요한 계정 제거 확인
echo.
echo                                  5. 계정 잠금 임계값 설정 확인
echo.
echo                                  6. 해독 가능한 암호화를 사용하여 암호 저장 해제 확인
echo.
echo                                  7. 관리자 그룹에 최소한의 사용자 포함 확인
echo.
echo                                  8. 공유 권한 및 사용자 그룹 설정 확인
echo.
echo                                  9. 하드디스크 기본 공유 제거 확인
echo.
echo                                  10. 불필요한 서비스 제거 확인
echo.
echo                                  11. IIS 서비스 구동 점검 확인
echo.
echo                                  12. IIS 디렉토리 리스팅 제거
echo.
echo                                  13. IIS CGI 실행 제한
echo.
echo                                  14. ■ 다음 페이지 확인 ■
echo.
echo                                  15. 프로그램 종료
echo -------------------------------------------------------------------------------------------------
set /p Select=(!) 입력 : 

if "%Select%"=="1" GOTO:all
if "%Select%"=="2" GOTO:w-01
if "%Select%"=="3" GOTO:w-02
if "%Select%"=="4" GOTO:w-03
if "%Select%"=="5" GOTO:w-04
if "%Select%"=="6" GOTO:w-05
if "%Select%"=="7" GOTO:w-06
if "%Select%"=="8" GOTO:w-07
if "%Select%"=="9" GOTO:w-08
if "%Select%"=="10" GOTO:w-09
if "%Select%"=="11" GOTO:w-10
if "%Select%"=="12" GOTO:w-11
if "%Select%"=="13" GOTO:w-12
if "%Select%"=="14" GOTO:SELECT_01
if "%Select%"=="15" GOTO:END

GOTO:SELECT
::--------------------------------------------------

:SELECT_01
echo.
echo.
echo (!) 2_Page. 아래 목록에서 원하는 숫자를 입력해주세요.
echo -------------------------------------------------------------------------------------------------
echo                                  1. 전체 확인
echo.
echo                                  2. Administrator 계정 이름 변경 또는 보안성 강화 확인
echo.
echo                                  3. Guest 계정 비활성화 확인
echo.
echo                                  4. 불필요한 계정 제거 확인
echo.
echo                                  5. 계정 잠금 임계값 설정 확인
echo.
echo                                  6. 해독 가능한 암호화를 사용하여 암호 저장 해제 확인
echo.
echo                                  7. 관리자 그룹에 최소한의 사용자 포함 확인
echo.
echo                                  8. 공유 권한 및 사용자 그룹 설정 확인
echo.
echo                                  9. 하드디스크 기본 공유 제거 확인
echo.
echo                                  10. 불필요한 서비스 제거 확인
echo.
echo                                  11. IIS 서비스 구동 점검 확인
echo.
echo                                  12. 프로그램 종료
echo -------------------------------------------------------------------------------------------------
set /p Select=(!) 입력 :




::------------------------------------------
:w-01
echo.
echo (W-01) Administrator 계정 이름 변경 또는 보안성 강화 확인
echo.
echo ●양호 : Administrator 계정이 없는 경우
echo.
echo ●취약 : Administrator 계정을 사용하는 경우
echo.
echo ●현재 사용 중인 계정 리스트
net user > 1-1.txt 
type 1-1.txt | find /i "Administrator" 
echo.
if %errorlevel% == 1 echo ●점검 결과 양호합니다.
if not %errorlevel% == 1 echo √점검 결과 취약점이 존재합니다.

del 1-1.txt

echo.
echo.
echo (!) 조치방법
echo.
echo ●Administrator Default 계정 이름 변경 및 보안성이 있는 비밀번호 설정
::if not errorlevel 1 echo 어드민 계정이 발견 되었습니다.  
::if not errorlevel 1 set /p flag="admin 계정이름을 변경 하시겠습니까? <Y/N>"
::if /i "%flag%" =="y" (set /p name="변경할 계정이름을 입력해 주세요 :") 
::if /i "%flag%" =="y" (wmic useraccount where name='Administrator' call rename "%name%")
::if /i "%flag%" =="y" echo 계정이름이 "%name%"으로 변경 되었습니다.
::if errorlevel 0 echo 어드민 계정이 없습니다 [안전]

pause
GOTO:SELECT
::------------------------------------------
:w-02
echo.
echo (W-02) Guest 계정 비활성화 확인
echo.
echo ●양호 : Guest 계정이 비활성화 상태
echo.
echo ●취약 : Guest 계정이 활성화 상태
echo.
net user > 1-2.txt 
type 1-2.txt | find /i "guest" 
echo.
if %errorlevel% == 1 echo (!) ●점검 결과 양호합니다.
if not %errorlevel% == 1 echo (!) √점검 결과 취약점이 존재합니다.

del 1-2.txt

echo.
echo.
echo (!) 조치방법
echo.
echo ●Guest 계정 비활성화
::IF Errorlevel 1 echo 양호하여 조치 활동이 없습니다. 
::if not errorlevel 1 echo "Guest 계정이 활성화 되어 있습니다"
::if not errorlevel 1 set /p flag="Guest 계정이 비활성화 하겠습니까? <Y/N>"
::if /i "%flag%"=="y"  net user guest /active:no 
::if /i "%flag%" =="y" echo Guest 계정이 비활성화 되어 있습니다. 

pause
GOTO:SELECT
::------------------------------------------
:w-03
echo.
echo (W-03) 불필요한 계정 제거
echo.
echo ●양호 : 불필요한 계정이 존재하지 않는 경우
echo.
echo ●취약 : 불필요한 계정이 존재하는 경우
echo.
net user
echo.

echo (!) 조치방법
echo.
echo ●현재 계정 현황 확인 후 불필요한 계정 삭제

pause
GOTO:SELECT
::------------------------------------------
:w-04
echo.
echo (W-04) 계정 잠금 임계값 설정
echo.
echo ●양호 : 임계값이 "5" 이하인 경우
echo.
echo ●취약 : 임계값이 "6" 이상인 경우
secedit /export /cfg ./test.txt > NUL
type test.txt | findstr /i "lockoutbadcount" | findstr /i "0 1 2 3 4 5" > NUL
echo.
if %errorlevel% == 0 echo ●점검 결과 양호합니다.
if not %errorlevel% == 0 echo √점검 결과 취약점이 존재합니다.

del test.txt

echo.
echo (!) 조치방법
echo.
echo ●계정 잠금 임계값을 "5" 이하의 값으로 설정

pause
GOTO:SELECT
::------------------------------------------
:w-05
echo.
echo (W-05) 해독 가능한 암호화를 사용하여 암호 저장 해제
echo.
echo ●양호 : 해독 가능한 암호화 사용하여 암호 저장 정책이 "사용 안 함"인 경우
echo.
echo ●취약 : 해독 가능한 암호화 사용하여 암호 저장 정책이 "사용"인 경우
secedit /export /cfg ./test.txt > NUL
type test.txt | findstr /i "PasswordComplexity" > NUL
echo.
if %errorlevel% == 1 echo ●점검 결과 양호합니다.
if not %errorlevel% == 1 echo √점검 결과 취약점이 존재합니다.

del test.txt

echo.
echo (!) 조치방법
echo.
echo ●"해독 가능한 암호화를 사용하여 암호 저장"을 "사용 안 함"으로 설정

pause
GOTO:SELECT
::------------------------------------------
:w-06
echo.
echo (W-06) 관리자 그룹에 최소한의 사용자 포함
echo.
echo ●양호 : Administrators 그룹에 포함된 불필요한 계정 제거 그룹 사용자 1명 이하 유지 또는 불필요한 관리자 계정이 존재하지 않는 경우
echo.
echo ●취약 : Administrators 그룹에 포함된 불필요한 계정 제거 그룹 내 불필요한 관리자 계정이 존재하는 경우
echo.
net localgroup administrators
echo.
echo 이 작업에서는 불필요한 계정이 확인되지 않았다면 넘어가셔도 됩니다.
echo.
echo (!)불필요한 계정 확인 시 조치방법
echo.
echo Administrators 그룹에 포함된 불필요한 계정 제거

pause
GOTO:SELECT
::------------------------------------------
:w-07
echo.
echo (W-7) 공유 권한 및 사용자 그룹 설정
echo.
echo ●양호 : 일반 공유 디렉토리가 없거나 공유 디렉토리 접근 권한에 Everyone 권한이 없는 경우
echo.
echo ●취약 : 일반 공유 디렉토리의 접근 권한에 Everyone 권한이 있는 경우
echo.
secedit /export /cfg ./test.txt > NUL
type test.txt | findstr /i "EveryoneIncludesAnonymous" > NUL
if %errorlevel% == 1 echo ●점검 결과 양호합니다.
if not %errorlevel% == 1 echo √점검 결과 취약점이 존재합니다.

del test.txt

echo.
echo (!) 조치방법
echo.
echo ●공유 디렉토리 접근 권한에서 Everyone 권한 제거 후 필요한 계정 추가

pause
GOTO:SELECT
::------------------------------------------
:w-08
echo.
echo (W-8) 하드디스크 기본 공유 제거
echo.
echo 양호 : 레지스트리의 AutoShareServer (WinNT: AutoShareWks)가 0이며 기본 공유가 존재하지 않는 경우
echo.
echo 취약 : 레지스트리의 AutoShareServer (WinNT: AutoShareWks)가 1이거나 기본 공유가 존재하는 경우
echo.
reg query "HKLM\SYSTEM\CurrentControlSet\Services\lanmanserver\parameters" | findstr /i "AutoShareServer" > NUL
if %errorlevel% == 1 echo ●점검 결과 양호합니다.
if not %errorlevel% == 1 echo √점검 결과 취약점이 존재합니다.
echo.
echo (!) 조치방법
echo.
echo ●기본 공유 중지 후 레지스트리 값 설정

pause
GOTO:SELECT
::------------------------------------------
:w-09
echo.
echo (W-9) 불필요한 서비스 제거
echo.
echo ●양호 : 일반적으로 불필요한 서비스가 중지되어 있는 경우
echo.
echo ●취약 : 일반적으로 불필요한 서비스가 구동 중인 경우
echo.
::type exitservice.txt > %notservice%
net start >> service.txt
::불필요한 서비스들 listup해서 넣어주면 가능함.

::파일 내용 abc 변수에 저장..(오류)
::type exitservice.txt > %abc%

::파일 내용을 반복문으로 읽어오는 형식
::delims=xx -> xx부분으로 구분하여 변수i에 넣고 읽어오는 형식
::하지만 set 변수에 넣는건 오류가나서 노가다로 일단 진행
::for /f "delims=" %%i in (exitservice.txt) do echo %%i

::type service.txt | findstr winlogbeat
::해당 서비스가 있으면 그 해당 서비스 종료권고
if service.txt == "Alerter" echo Alerter service exit now!
if not service.txt == "Alerter" echo saft

if service.txt == "automatic updates" echo automatic updates service exit now!
if not service.txt == "automatic updates" echo saft

if service.txt == "clipbook" echo clipbook service exit now!
if not service.txt == "clipbook" echo saft

if service.txt == "computer browser" echo computer browser service exit now!
if not service.txt == "computer browser" echo saft

if service.txt == "cryptographic" echo cryptographic service exit now!
if not service.txt == "cryptographic" echo saft

echo.
echo 리스트에 존재하는 서비스가 실행 중인 경우 사용하지 않는다면 "사용 안 함" 설정 권고

echo.
echo (!) 조치방법
echo.
echo ●불필요한 서비스 중지 후 "사용 안 함" 설정

pause
GOTO:SELECT
::------------------------------------------
:w-10
echo.
echo (W-10) IIS 서비스 구동 점검
echo.
echo ●양호 : IIS 서비스가 필요하지 않아 이용하지 않는 경우
echo.
echo ●취약 : IIS 서비스를 필요로 하지 않지만 사용하는 경우
echo.
net start > service.txt

type service.txt | find /i "IIS Admin"
type service.txt | find /i "World Wide Web Publishing Service"

if service.txt == "IIS Admin" echo vnlnerable
if not service.txt == "IIS Admin" echo safe

if service.txt == "World Wide Web Publishing Service" echo vnlnerable
if not service.txt == "World Wide Web Publishing Service" echo safe
echo.
echo IIS 서비스를 사용하지 않는 경우 서비스 "사용 안 함" 조치 권고
echo.
echo (!) 조치방법
echo.
echo ●IIS 서비스를 사용하지 않는 경우 IIS 서비스 중지

pause
GOTO:SELECT

::------------------------------------------
:w-11
echo.
echo (W-11) IIS 디렉토리 리스팅 제거
echo.
echo ●양호 : "디렉토리 검색" 체크하지 않음
echo.
echo ●취약 : "디렉토리 검색" 체크함 ※ 조치 시 마스터 속성과 모든 사이트에 적용함
echo.

type C:\Windows\System32\inetsrv\config\applicationHost.config > IIS_setting_conf.txt

type C:\Windows\System32\inetsrv\metabase.xml > IIS_setting_met.txt

type IIS_setting_conf.txt | find /I "directoryBrowse"

type IIS_setting_met.txt | find /I "directoryBrowse"


echo %errorlevel% 


if %errorlevel% == 1 echo safe

if not errorlevel == 1 echo vnlnerable

echo.
echo IIS 서비스를 사용하지 않는 경우 서비스 "사용 안 함" 조치 권고
echo.
echo (!) 조치방법
echo.
echo ●사용하지 않는 경우 IIS 서비스 중지, 사용할 경우 디렉토리 검색 체크 해제

pause
GOTO:SELECT
::------------------------------------------
:w-12
echo.
echo (W-12) IIS CGI 실행 제한
echo.
echo ●양호 : 해당 디렉토리 Everyone에 모든 권한, 수정 권한, 쓰기 권한이 부여되지 않은 경우
echo.
echo ●취약 : 해당 디렉토리 Everyone에 모든 권한, 수정 권한, 쓰기 권한이 부여되어 있는 경우
echo.

echo.
echo IIS 서비스를 사용하지 않는 경우 서비스 "사용 안 함" 조치 권고
echo.
echo (!) 조치방법
echo.
echo ●사용하지 않는 경우 IIS 서비스 중지, 사용할 경우 Everyone에 모든 권한, 수정 권한, 쓰기 권한 제거 후 Administrators, System 그룹 추가(모든 권한)

pause
GOTO:SELECT
::------------------------------------------
:w-13
echo.
echo (W-13) IIS 상위 디렉토리 접근 금지 설정 적용 여부 점검
echo.
echo ●양호 : 상위 디렉토리 접근 기능을 제거한 경우
echo.
echo ●취약 : 상위 디렉토리 접근 기능을 제거하지 않은 경우 ※ 조치 시 마스터 속성과 모든 사이트에 적용함
echo.

type C:\Windows\System32\inetsrv > IIS_dir_conf.txt
type IIS_dir_conf.txt | find /I "enableParentPaths" | find /I "true" 
find /i "asp enableParentPaths' | find /i "true" >nul 2>&1 

echo %errorlevel%

if %errorlevel% == 1 echo safe

if not errorlevel == 1 echo vnlnerable

echo.
echo IIS 서비스를 사용하지 않는 경우 서비스 "사용 안 함" 조치 권고
echo.
echo (!) 조치방법
echo.
echo ●사용하지 않는 경우 IIS 서비스 중지, 사용할 경우 상위 디렉토리 접근 기능 제거

pause
GOTO:SELECT
::------------------------------------------
:w-18
echo.
echo (W-18) IIS DB 연결 취약점 점검
echo.
echo ●양호 : .ass 매핑 시 특정 동작만 가능하도록 제한하여 설정한 경우 도는 매핑이 없을 경우
echo.
echo ●취약 : .ass 매핑 시 모든 동작이 가능하도록 설정한 경우
echo.

echo.
echo IIS 서비스를 사용하지 않는 경우 서비스 "사용 안 함" 조치 권고
echo.
echo (!) 조치방법
echo.
echo ●사용하지 않는 경우 IIS 서비스 중지, 사용할 경우 .ass 매핑을 특정 동작만 가능하도록 추가(IIS 6.0) / ass 설정을 false 함(7.0, 8.0, 10.0)

pause
GOTO:SELECT
::------------------------------------------
:w-21
echo.
echo (W-21) IIS 미사용 스크립트 매핑 제거
echo.
echo ●양호 : 취약한 매핑(.htr .idc .stm .shtm .shtml .printer .htw .ida .idq)이 존재하지 않는 경우
echo.
echo ●취약 : 취약한 매핑(.htr .idc .stm .shtm .shtml .printer .htw .ida .idq)이 존재하는 경우 ※ 조치 시 마스터 속성과 모든 사이트에 적용함
echo.

echo.
echo IIS 서비스를 사용하지 않는 경우 서비스 "사용 안 함" 조치 권고
echo.
echo (!) 조치방법
echo.
echo ●사용하지 않는 경우 IIS 서비스 중지, 사용할 경우 취약한 매핑 제거

pause
GOTO:SELECT
::------------------------------------------
:w-24
echo.
echo (W-24) NetBIOS 바인딩 서비스 구동 점검
echo.
echo ●양호 : TCP/IP와 NetBIOS 간의 바인딩이 제거 되어 있는 경우
echo.
echo ●취약 : TCP/IP와 NetBIOS 간의 바인딩이 제거 되어있지 않은 경우
echo.

reg query "HKLM\SYSTEM\CurrentControlSet\Services\NetBT\Parameters\Interfaces" /s    >> ./bios.txt  
Type bios.txt | find /i “NetbiosOptions=1”
If %errorlevel% == 1 echo ●점검 결과 양호합니다. 
If not %errorlevel% == 1 echo √점검 결과 취약점이 존재합니다. 

del bios.txt

echo.
echo (!) 조치방법
echo.
echo ●네트워크 제어판을 이용하여 TCP/IP와 NetBIOS 간의 바인딩(binding) 제거

pause
GOTO:SELECT
::------------------------------------------
:w-26
echo.
echo (W-26) FTP 디렉토리 접근 권한 설정
echo.
echo ●양호 : FTP 홈 디렉토리에 Everyone 권한이 없는 경우
echo.
echo ●취약 : FTP 홈 디렉토리에 Everyone 권한이 있는 경우
echo.

net start | find "FTP" > nul
if %errorlevel% == 1 echo ●점검 결과 양호합니다. 
if not %errorlevel% == 1 GOTO FTP

:FTP
echo √점검 결과 취약점이 존재합니다.
echo.							
echo C:\Inetpun\ftproot 접근 권한 
echo.							
icacls "C:\Inetpub\ftproot" | find /v "파일을 처리했으며"	
echo.							
echo 

set /p FTPCheck=(!) FTP 디렉터리를 추가하겠습니까? (Y/N) :
if %FTPCheck% == y goto FTPCheckYes
if %FTPCheck% == n goto FTPEND

:FTPCheckYes
echo Ex) C:\Inetpub\ftproot
set /p FTPDirectory = FTP 디렉터리를 입력하세요 : 
echo.
echo 입력 받은 ftp 디렉터리 : %FTPDirectory% 
echo. 
icacls "%FTPDirectory%" | find /v "파일을 처리했으며"

:FTPEND
echo END

echo.
echo (!) 조치방법
echo.
echo ●FTP 홈 디렉토리에서 Everyone 권한 삭제, 각 사용자에게 적절한 권한 부여

pause
GOTO:SELECT
::------------------------------------------
:w-29
echo.
echo (W-29) DNS Zone Transfer 설정
echo.
echo ●양호 : 아래 기준에 해당될 경우
echo 1. DNS 서비스를 사용하지 않는 경우
echo 2. 영역 전송 허용을 하지 않는 경우
echo 3. 특정 서버로만 설정이 되어 있는 경우
echo.
echo ●취약 : 위 3개 기준 중 하나라도 해당 되지 않는 경우
echo.

echo.
echo 
echo.
echo (!) 조치방법
echo.
echo ●불필요 시 서비스 중지/사용 안 함, 사용하는 경우 영역 전송을 특정 서버로 제한하거나 "영역 전송 허용"에 체크 해제

pause
GOTO:SELECT
::------------------------------------------
:w-38
echo.
echo (W-38) 화면보호기 설정
echo.
echo ●양호 : 화면 보호기를 설정하고 대기 시간이 10분 이하의 값으로 설정되어 있으며, 화면 보호기 해제를 위한 암호를 사용하는 경우
echo.
echo ●취약 : 화면 보호기가 설정되지 않았거나 암호를 사용하지 않은 경우 또는, 화면 보호기 대기 시간이 10분을 초과한 값으로 설정되어 있는 경우
echo.

reg query "HKEY_CURRENT_USER\Control Panel\Desktop" | find /i "ScreenSaveActive" | find "1" > NUL
reg query "HKEY_CURRENT_USER\Control Panel\Desktop" | find /i "ScreenSaverIsSecure"  | find "1" > NUL
reg query "HKEY_CURRENT_USER\Control Panel\Desktop" | find /I "ScreenSaveTimeOut" > NUL

if %errorlevel% == 0 echo ●점검 결과 양호합니다. 
if not %errorlevel% == 0 echo √점검 결과 취약점이 존재합니다.
echo.
echo (!) 조치방법
echo.
echo ●화면 보호기 사용, 대기 시간 10분, 암호 사용

pause
GOTO:SELECT
::------------------------------------------
:w-41
echo.
echo (W-41) 보안감사를 로그할 수 없는 경우 즉시 시스템 종료 해제
echo.
echo ●양호 : "보안 감사를 로그할 수 없는 경우 즉시 시스템 종료" 정책이 "사용 안 함"으로 되어 있는 경우
echo.
echo ●취약 : "보안 감사를 로그할 수 없는 경우 즉시 시스템 종료" 정책이 "사용"으로 되어 있는 경우
echo.

Secede /export /cfg ./test.txt > NUL
type test.txt | find /i "crashonauditfail=0” > NUL
echo  
If %errorlevel% == 1 echo ●점검 결과 양호합니다. 
If not %errorlevel% == 1 echo √점검 결과 취약점이 존재합니다. 

del test.txt

echo.
echo (!) 조치방법
echo.
echo ●보안 감사를 로그할 수 없는 경우 즉시 시스템 종료 -> 사용 안 함

pause
GOTO:SELECT
::------------------------------------------
:w-43
echo.
echo (W-43) Autologon 기능 제어
echo.
echo ●양호 : AutoAdminLogon 값이 없거나 0으로 설정되어 있는 경우
echo.
echo ●취약 : AutoAdminLogon 값이 1로 설정되어 있는 경우
echo.


reg query "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" | findstr /i "AutoAdminLogon" | find "1" > NUL
if %errorlevel% == 0 echo ●점검 결과 양호합니다. 
if not %errorlevel% == 0 echo √점검 결과 취약점이 존재합니다.

echo.
echo (!) 조치방법
echo.
echo ●해당 레지스트리 값이 존재하는 경우 0으로 설정

pause
GOTO:SELECT
::------------------------------------------
:w-44
echo.
echo (W-44) 이동식 미디어 포맷 및 꺼내기 허용
echo.
echo ●양호 : "이동식 미디어 포맷 및 꺼내기 허용" 정책이 "Administrator"로 되어 있는 경우
echo.
echo ●취약 : "이동식 미디어 포맷 및 꺼내기 허용" 정책이 "Administrator"로 되어있지 않은 경우
echo.

secedit /export /cfg ./test.txt > NUL
type test.txt | find /i "AllocateDASD" | findstr /i 0 > NUL
if %errorlevel% == 0 echo ●점검 결과 양호합니다. 
if not %errorlevel% == 0 echo √점검 결과 취약점이 존재합니다.

del test.txt

echo.
echo (!) 조치방법
echo.
echo ●"이동식 미디어 포맷 및 꺼내기 허용" 정책을 "Administrator"로 변경

pause
GOTO:SELECT

::------------------------------------------
:w-47
echo.
echo (W-47) 계정 잠금 기간 설정
echo.
echo ●양호 : "계정 잠금 기간" 및 "계정 잠금 기간 원래대로 설정 기간"이 설정되어 있는 경우(60분 이상의 값으로 설정하기를 권고함)
echo.
echo ●취약 : "계정 잠금 기간" 및 "잠금 기간 원래대로 설정 기간"이 설정되지 않은 경우
echo.
secedit /export /cfg ./test.inf /areas SECURITYPOLICY > Nul
echo LockoutDuration = 60 > test.inf 

If %errorlevel% == 1 echo ●점검 결과 양호합니다. 
If not %errorlevel% == 1 echo √점검 결과 취약점이 존재합니다. 
echo.
echo (!) 조치방법
echo.
echo ●"계정 잠금 기간" 및 "잠금 기간 원래대로 설정 기간" 60분 설정

pause
GOTO:SELECT

::------------------------------------------
:w-48
echo.
echo (W-48) 패스워드 복잡성 설정
echo.
echo ●양호 : "암호는 복잡성을 만족해야 함" 정책이 "사용"으로 되어 있는 경우
echo.
echo ●취약 : "암호는 복잡성을 만족해야 함" 정책이 "사용 안 함"으로 되어 있는 경우
echo.

[System Access]
secedit /export /cfg ./test.inf /areas SECURITYPOLICY > NUL
echo PasswordComplexity = 1 > test.inf

If %errorlevel% == 1 echo ●점검 결과 양호합니다. 
If not %errorlevel% == 1 echo √점검 결과 취약점이 존재합니다. 

echo.
echo (!) 조치방법
echo.
echo ●암호는 복잡성을 만족해야 함 -> 사용

pause
GOTO:SELECT

::------------------------------------------
:w-52
echo.
echo (W-52) 마지막 사용자 이름 표시 안함
echo.
echo ●양호 : "마지막 사용자 이름 표시 안 함"이 "사용"으로 설정되어 있는 경우
echo.
echo ●취약 : "마지막 사용 이름 표시 안 함"이 "사용 안 함"으로 설정되어 있는 경우
echo.

reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" | findstr /I "dontdisplaylastusername" | find "1" > NUL
if %errorlevel% == 0 echo ●점검 결과 양호합니다.
if not %errorlevel% == 0 echo √점검 결과 취약점이 존재합니다. 

echo.
echo (!) 조치방법
echo.
echo ● Windows NT : 마지막으로 로그온한 사용자 이름 표시 안 함 -> 설정 후 저장
echo ● Windows 2000 : 로그온 스크린에 마지막 사용자 이름 표시 안 함 -> 사용
echo ● Windows 2003, 2008, 2012, 2016, 2019 : 대화형 로그온: 마지막 사용자 이름 표시 안 함 -> 사용

pause
GOTO:SELECT


::-----------------------------------ALL---------------------------------------
:all
echo.
echo (W-01) Administrator 계정 이름 변경 또는 보안성 강화 확인 > Vuln_Results.txt
echo. >> Vuln_Results.txt
echo ●양호 : Administrator 계정이 없는 경우
echo.
echo ●취약 : Administrator 계정을 사용하는 경우
echo.
echo ●현재 사용 중인 계정 리스트
net user > 1-1.txt 
type 1-1.txt | find /i "Administrator" 
echo.
if %errorlevel% == 1 echo ●점검 결과 양호합니다. >> Vuln_Results.txt
if not %errorlevel% == 1 echo √점검 결과 취약점이 존재합니다. >> Vuln_Results.txt

del 1-1.txt

echo. >> Vuln_Results.txt
echo. >> Vuln_Results.txt
echo (!) 조치방법
echo.
echo ●Administrator Default 계정 이름 변경 및 보안성이 있는 비밀번호 설정
::if not errorlevel 1 echo 어드민 계정이 발견 되었습니다.  
::if not errorlevel 1 set /p flag="admin 계정이름을 변경 하시겠습니까? <Y/N>"
::if /i "%flag%" =="y" (set /p name="변경할 계정이름을 입력해 주세요 :") 
::if /i "%flag%" =="y" (wmic useraccount where name='Administrator' call rename "%name%")
::if /i "%flag%" =="y" echo 계정이름이 "%name%"으로 변경 되었습니다.
::if errorlevel 0 echo 어드민 계정이 없습니다 [안전]

::------------------------------------------

echo.
echo (W-02) Guest 계정 비활성화 확인 >> Vuln_Results.txt
echo. >> Vuln_Results.txt
echo ●양호 : Guest 계정이 비활성화 상태
echo.
echo ●취약 : Guest 계정이 활성화 상태
echo.
net user > 1-2.txt 
type 1-2.txt | find /i "guest" 
echo.
if %errorlevel% == 1 echo ●점검 결과 양호합니다. >> Vuln_Results.txt
if not %errorlevel% == 1 echo √점검 결과 취약점이 존재합니다. >> Vuln_Results.txt

del 1-2.txt

echo. >> Vuln_Results.txt
echo. >> Vuln_Results.txt
echo (!) 조치방법
echo.
echo ●Guest 계정 비활성화
::IF Errorlevel 1 echo 양호하여 조치 활동이 없습니다. 
::if not errorlevel 1 echo "Guest 계정이 활성화 되어 있습니다"
::if not errorlevel 1 set /p flag="Guest 계정이 비활성화 하겠습니까? <Y/N>"
::if /i "%flag%"=="y"  net user guest /active:no 
::if /i "%flag%" =="y" echo Guest 계정이 비활성화 되어 있습니다. 

::------------------------------------------

echo.
echo (W-03) 불필요한 계정 제거 >> Vuln_Results.txt
echo.
echo ●양호 : 불필요한 계정이 존재하지 않는 경우
echo.
echo ●취약 : 불필요한 계정이 존재하는 경우
echo.
net user >> Vuln_Results.txt 
echo. >> Vuln_Results.txt
echo 계정 리스트를 확인해주세요. >> Vuln_Results.txt


echo (!) 조치방법
echo. >> Vuln_Results.txt
echo ●현재 계정 현황 확인 후 불필요한 계정 삭제

::------------------------------------------

echo.
echo (W-04) 계정 잠금 임계값 설정 >> Vuln_Results.txt
echo. >> Vuln_Results.txt
echo ●양호 : 임계값이 "5" 이하인 경우
echo.
echo ●취약 : 임계값이 "6" 이상인 경우
secedit /export /cfg ./test.txt > NUL
type test.txt | findstr /i "lockoutbadcount" | findstr /i "0 1 2 3 4 5" > NUL
echo.
if %errorlevel% == 0 echo ●점검 결과 양호합니다. >> Vuln_Results.txt
if not %errorlevel% == 0 echo √점검 결과 취약점이 존재합니다. >> Vuln_Results.txt

del test.txt

echo. >> Vuln_Results.txt
echo (!) 조치방법
echo.
echo ●계정 잠금 임계값을 "5" 이하의 값으로 설정

::------------------------------------------

echo.
echo (W-05) 해독 가능한 암호화를 사용하여 암호 저장 해제 >> Vuln_Results.txt
echo. >> Vuln_Results.txt
echo ●양호 : 해독 가능한 암호화 사용하여 암호 저장 정책이 "사용 안 함"인 경우
echo.
echo ●취약 : 해독 가능한 암호화 사용하여 암호 저장 정책이 "사용"인 경우
secedit /export /cfg ./test.txt > NUL
type test.txt | findstr /i "PasswordComplexity" > NUL
echo. 
if %errorlevel% == 1 echo ●점검 결과 양호합니다. >> Vuln_Results.txt
if not %errorlevel% == 1 echo √점검 결과 취약점이 존재합니다. >> Vuln_Results.txt

del test.txt

echo. >> Vuln_Results.txt
echo (!) 조치방법
echo. >> Vuln_Results.txt
echo ●"해독 가능한 암호화를 사용하여 암호 저장"을 "사용 안 함"으로 설정

::------------------------------------------

echo.
echo (W-06) 관리자 그룹에 최소한의 사용자 포함 >> Vuln_Results.txt
echo. >> Vuln_Results.txt
echo ●양호 : Administrators 그룹에 포함된 불필요한 계정 제거 그룹 사용자 1명 이하 유지 또는 불필요한 관리자 계정이 존재하지 않는 경우
echo.
echo ●취약 : Administrators 그룹에 포함된 불필요한 계정 제거 그룹 내 불필요한 관리자 계정이 존재하는 경우
echo.
net localgroup administrators >> Vuln_Results.txt 
echo.
echo 이 작업에서는 불필요한 계정이 확인되지 않았다면 넘어가셔도 됩니다. >> Vuln_Results.txt
echo. >> Vuln_Results.txt
echo (!)불필요한 계정 확인 시 조치방법
echo. >> Vuln_Results.txt
echo Administrators 그룹에 포함된 불필요한 계정 제거

::------------------------------------------

echo.
echo (W-7) 공유 권한 및 사용자 그룹 설정 >> Vuln_Results.txt
echo. >> Vuln_Results.txt
echo ●양호 : 일반 공유 디렉토리가 없거나 공유 디렉토리 접근 권한에 Everyone 권한이 없는 경우
echo.
echo ●취약 : 일반 공유 디렉토리의 접근 권한에 Everyone 권한이 있는 경우
echo.
secedit /export /cfg ./test.txt > NUL
type test.txt | findstr /i "EveryoneIncludesAnonymous" > NUL
if %errorlevel% == 1 echo ●점검 결과 양호합니다. >> Vuln_Results.txt
if not %errorlevel% == 1 echo √점검 결과 취약점이 존재합니다. >> Vuln_Results.txt

del test.txt

echo. >> Vuln_Results.txt
echo (!) 조치방법
echo. >> Vuln_Results.txt
echo ●공유 디렉토리 접근 권한에서 Everyone 권한 제거 후 필요한 계정 추가

::------------------------------------------

echo.
echo (W-8) 하드디스크 기본 공유 제거 >> Vuln_Results.txt
echo. >> Vuln_Results.txt
echo 양호 : 레지스트리의 AutoShareServer (WinNT: AutoShareWks)가 0이며 기본 공유가 존재하지 않는 경우
echo.
echo 취약 : 레지스트리의 AutoShareServer (WinNT: AutoShareWks)가 1이거나 기본 공유가 존재하는 경우
echo.
reg query "HKLM\SYSTEM\CurrentControlSet\Services\lanmanserver\parameters" | findstr /i "AutoShareServer" > NUL
if %errorlevel% == 1 echo ●점검 결과 양호합니다. >> Vuln_Results.txt
if not %errorlevel% == 1 echo √점검 결과 취약점이 존재합니다. >> Vuln_Results.txt
echo (!) 조치방법
echo. >> Vuln_Results.txt
echo ●기본 공유 중지 후 레지스트리 값 설정

::------------------------------------------

echo. >> Vuln_Results.txt
echo (W-9) 불필요한 서비스 제거 >> Vuln_Results.txt
echo.
echo ●양호 : 일반적으로 불필요한 서비스가 중지되어 있는 경우
echo.
echo ●취약 : 일반적으로 불필요한 서비스가 구동 중인 경우
echo.

net start >> ./service.txt

if service.txt == "Alerter" echo Alerter service exit now!
if not service.txt == "Alerter" echo saft

if service.txt == "automatic updates" echo automatic updates service exit now!
if not service.txt == "automatic updates" echo saft

if service.txt == "clipbook" echo clipbook service exit now!
if not service.txt == "clipbook" echo saft

if service.txt == "computer browser" echo computer browser service exit now!
if not service.txt == "computer browser" echo saft

if service.txt == "cryptographic" echo cryptographic service exit now!
if not service.txt == "cryptographic" echo saft

echo.
echo 리스트에 존재하는 서비스가 실행 중인 경우 사용하지 않는다면 "사용 안 함" 설정 권고

echo.
echo (!) 조치방법
echo.
echo ●불필요한 서비스 중지 후 "사용 안 함" 설정

::------------------------------------------

echo.
echo (W-10) IIS 서비스 구동 점검
echo.
echo ●양호 : IIS 서비스가 필요하지 않아 이용하지 않는 경우
echo.
echo ●취약 : IIS 서비스를 필요로 하지 않지만 사용하는 경우
echo.

net start > service.txt

type service.txt | find /i "IIS Admin"
type service.txt | find /i "World Wide Web Publishing Service"

if service.txt == "IIS Admin" echo vnlnerable
if not service.txt == "IIS Admin" echo safe

if service.txt == "World Wide Web Publishing Service" echo vnlnerable
if not service.txt == "World Wide Web Publishing Service" echo safe

echo.
echo IIS 서비스를 사용하지 않는 경우 서비스 "사용 안 함" 조치 권고
echo.
echo (!) 조치방법
echo.
echo ●IIS 서비스를 사용하지 않는 경우 IIS 서비스 중지
echo.
echo.
echo.

echo 전체 결과값은 동일 디렉토리에 생성된 Vuln_Results.txt에서 확인 가능합니다. 

pause
GOTO:SELECT

:END