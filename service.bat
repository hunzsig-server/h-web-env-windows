@echo off
:: BatchGotAdmin
:-------------------------------------
REM --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
echo Requesting administrative privileges...
goto UACPrompt
) else ( goto gotAdmin )
:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
exit /B
:gotAdmin
if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
pushd "%CD%"
CD /D "%~dp0"






echo ==================begin========================

cls 

SET DISK=D:
SET DEP=%DISK%\Web\h-web-env-windows\dependent
SET NGINX_DIR=%DEP%\nginx-1.15.10\
SET REDIS_DIR=%DEP%\Redis-x64-3.2.100\
SET RABBITMQ_DIR=%DEP%\rabbitmq_server-3.7.15\sbin\
SET ELASTICSEARCH_DIR=%DEP%\elasticsearch-7.0.1\bin\
SET KIBANA_DIR=%DEP%\kibana-7.0.1\bin\
SET APM_DIR=%DEP%\apm-server-7.0.1\

color ff 
TITLE PHP - �������

CLS 
ECHO.# by hunzsig
ECHO %~0

:MENU

ECHO.----------------------�����б�----------------------
tasklist|findstr /i "nginx.exe"
tasklist|findstr /i "httpd.exe"
tasklist|findstr /i "redis-server.exe"
ECHO.----------------------------------------------------
ECHO.����PHP�汾��:
set /p VERSION=
SET APACHE_DIR=%DISK%\Web\h-web-env-windows\php_%version%\bin\
IF NOT EXIST "%APACHE_DIR%httpd.exe" (
ECHO "Not support this php version��"
GOTO MENU
)
ECHO.----------------------------------------------------
ECHO.[1] ��������
ECHO.[2] ֹͣ����
ECHO.[3] ע�����
ECHO.[9] ɾ������
ECHO.[0] �˳� 
ECHO.���빦�ܺ�:

set /p ID=
IF "%id%"=="1" GOTO start
IF "%id%"=="2" GOTO stop
IF "%id%"=="3" GOTO register
IF "%id%"=="9" GOTO remove 
IF "%id%"=="0" EXIT
PAUSE 



:start
call :startX
GOTO MENU
:stop
call :stopX
GOTO MENU
:register 
call :registerX
GOTO MENU
:remove
call :removeX
GOTO MENU






:startX
IF NOT EXIST "%APACHE_DIR%httpd.exe" (
ECHO.[Default][Apache][not exist]
) ELSE (
%DISK%
cd "%APACHE_DIR%"
httpd.exe -k start
ECHO.[Default][PHP][START]
ECHO.[Default][Apache][START]
)
IF NOT EXIST "%NGINX_DIR%nginx.exe" (
ECHO.[Dependent][Nginx][hasn't been decompressed yet]
) ELSE (
%DISK%
cd "%NGINX_DIR%"
winsw.exe start
ECHO.[Dependent][Nginx][START]
)
IF NOT EXIST "%REDIS_DIR%redis-server.exe" (
ECHO.[Dependent][Redis][hasn't been decompressed yet]
) ELSE (
%DISK%
cd "%REDIS_DIR%"
redis-server --service-start
ECHO.[Dependent][Redis][START]
)
goto :eof







:stopX
IF NOT EXIST "%APACHE_DIR%httpd.exe" (
ECHO.[Default][Apache][not exist]
) ELSE (
%DISK%
cd "%APACHE_DIR%"
httpd.exe -k stop
ECHO.[Default][Apache][STOP]
ECHO.[Default][PHP][STOP]
)
IF NOT EXIST "%NGINX_DIR%nginx.exe" (
ECHO.[Dependent][Nginx][hasn't been decompressed yet]
) ELSE (
%DISK%
cd "%NGINX_DIR%"
winsw.exe stop
taskkill /F /IM nginx.exe > nul
ECHO.[Dependent][Nginx][STOP]
)
IF NOT EXIST "%REDIS_DIR%redis-server.exe" (
ECHO.[Dependent][Redis][hasn't been decompressed yet]
) ELSE (
%DISK%
cd "%REDIS_DIR%"
redis-server --service-stop
ECHO.[Dependent][Redis][STOP]
)
goto :eof




:registerX
IF NOT EXIST "%APACHE_DIR%httpd.exe" (
ECHO.[Default][Apache][not exist]
) ELSE (
%DISK%
cd "%APACHE_DIR%"
httpd.exe -k install
ECHO.[Default][PHP][REG]
ECHO.[Default][Apache][REG]
)
IF NOT EXIST "%NGINX_DIR%nginx.exe" (
ECHO.[Dependent][Nginx][hasn't been decompressed yet]
) ELSE (
%DISK%
cd "%NGINX_DIR%"
winsw.exe install
ECHO.[Dependent][Nginx][REG]
)
IF NOT EXIST "%REDIS_DIR%redis-server.exe" (
ECHO.[Dependent][Redis][hasn't been decompressed yet]
) ELSE (
%DISK%
cd "%REDIS_DIR%"
redis-server.exe --service-install redis.windows.conf --loglevel verbose
ECHO.[Dependent][Redis][REG]
)
goto :eof







:removeX
IF NOT EXIST "%APACHE_DIR%httpd.exe" (
ECHO.[Default][Apache][not exist]
) ELSE (
%DISK%
cd "%APACHE_DIR%"
httpd.exe -k uninstall
ECHO.[Default][PHP][DEL]
ECHO.[Default][Apache][DEL]
)
IF NOT EXIST "%NGINX_DIR%nginx.exe" (
ECHO.[Dependent][Nginx][hasn't been decompressed yet]
) ELSE (
%DISK%
cd "%NGINX_DIR%"
winsw.exe uninstall
ECHO.[Dependent][Nginx][DEL]
)
IF NOT EXIST "%REDIS_DIR%redis-server.exe" (
ECHO.[Dependent][Redis][hasn't been decompressed yet]
) ELSE (
%DISK%
cd "%REDIS_DIR%"
redis-server --service-uninstall
ECHO.[Dependent][Redis][DEL]
)
goto :eof

