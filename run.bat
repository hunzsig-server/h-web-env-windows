====================================================
@echo off
rem �������������·�������Թ���Ա�������

echo ==================begin========================

cls 

SET DISK=D:
SET DEP=%DISK%\Web\h-web-env-windows\dependent
SET NGINX_DIR=%DEP%\nginx-1.15.10\
SET REDIS_DIR=%DEP%\Redis-x64-3.2.100\
SET RunHiddenConsole=%DEP%\RunHiddenConsole

color ff 
TITLE PHP - ��ʱ�������

CLS 
ECHO.# by hunzsig
ECHO %~0

:MENU

ECHO.----------------------�����б�----------------------
tasklist|findstr /i "nginx.exe"
tasklist|findstr /i "httpd.exe"
tasklist|findstr /i "redis-server.exe"
ECHO.----------------------------------------------------
ECHO.[1] ����/����
ECHO.[9] �ر�
ECHO.[0] �˳� 
ECHO.���������:
set /p ID=
IF "%id%"=="1" GOTO start
IF "%id%"=="9" GOTO stop 
IF "%id%"=="0" EXIT
PAUSE 

:start
ECHO.����PHP�汾��(5.6-7.3):
set /p VERSION=
SET APACHE_DIR=%DISK%\Web\h-web-env-windows\php_%version%\bin\
IF NOT EXIST "%APACHE_DIR%httpd.exe" (
ECHO "Not support this php version��"
GOTO MENU
)
call :shutdown
call :startApache
call :startNginx
call :startRedis
GOTO MENU


:stop 
call :shutdown
GOTO MENU

:shutdown
ECHO.Stopping All...... 
taskkill /F /IM nginx.exe > nul
taskkill /F /IM httpd.exe > nul
taskkill /F /IM redis-server.exe > nul
ECHO.[All][stoped]
goto :eof


:startApache
IF NOT EXIST "%APACHE_DIR%httpd.exe" (
ECHO "[Default][Apache][not exist]"
goto :eof
)
%XDISK% 
cd "%APACHE_DIR%" 
%RunHiddenConsole% httpd.exe
ECHO.[Default][PHP][OK]
ECHO.[Default][Apache][OK]
goto :eof


:startNginx
IF NOT EXIST "%NGINX_DIR%nginx.exe" (
ECHO "[Dependent][Nginx][hasn't been decompressed yet]"
goto :eof
)
%XDISK% 
cd "%NGINX_DIR%" 
start nginx.exe
ECHO.[Dependent][Nginx][OK]
goto :eof


:startRedis
IF NOT EXIST "%REDIS_DIR%redis-server.exe" (
ECHO "[Dependent][Redis][hasn't been decompressed yet]"
goto :eof
)
%XDISK% 
cd "%REDIS_DIR%" 
%RunHiddenConsole% redis-server.exe
ECHO.[Dependent][Redis][OK]
goto :eof

