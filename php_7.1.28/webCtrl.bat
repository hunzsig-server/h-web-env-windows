====================================================
@echo off
rem �������������·�������Թ���Ա�������

echo ==================begin========================

cls 

SET XDISK=D:
SET XPATH=%XDISK%\Web\h-web-env-windows\php_7.1.28
SET APACHE_DIR=%XPATH%\Apache24\bin\
SET NGINX_DIR=%XPATH%\nginx-1.15.10\
SET REDIS_DIR=%XPATH%\Redis-x64-3.2.100\

color ff 
TITLE ANPR �������

CLS 
ECHO.# by hunzsig 20190411
ECHO %~0

:MENU

ECHO.----------------------�����б�----------------------
tasklist|findstr /i "nginx.exe"
tasklist|findstr /i "httpd.exe"
tasklist|findstr /i "redis-server.exe"
ECHO.----------------------------------------------------
ECHO.[1] ����/����[ANPRģʽ]
ECHO.[2] ����/����[APRģʽ]
ECHO.[9] �ر�
ECHO.[0] �˳� 
ECHO.���빦�ܺ�:

set /p ID=
IF "%id%"=="1" GOTO startANPR
IF "%id%"=="2" GOTO startAPR
IF "%id%"=="9" GOTO stop 
IF "%id%"=="0" EXIT
PAUSE 



:startANPR 
call :shutdown
call :startApache
call :startNginx
call :startRedis
GOTO MENU

:startAPR 
call :shutdown
call :startApache
call :startRedis
GOTO MENU

:stop 
call :shutdown
GOTO MENU

:shutdown
call :shutdownRedis
call :shutdownNginx
call :shutdownApache
goto :eof

:shutdownNginx
ECHO.Stopping Nginx...... 
taskkill /F /IM nginx.exe > nul
ECHO.OK
ECHO. 
goto :eof

:startNginx
ECHO.Start Nginx...... 
IF NOT EXIST "%NGINX_DIR%nginx.exe" (
ECHO "%NGINX_DIR%nginx.exe" not exist
goto :eof
)
%XDISK% 
cd "%NGINX_DIR%" 
start nginx.exe
ECHO.OK
ECHO.
goto :eof


:shutdownApache
ECHO.Stopping Apache...... 
taskkill /F /IM httpd.exe > nul
ECHO.OK
ECHO. 
goto :eof

:startApache
ECHO.Start Apache...... 
IF NOT EXIST "%APACHE_DIR%httpd.exe" (
ECHO "%APACHE_DIR%httpd.exe" not exist
goto :eof
)
%XDISK% 
cd "%APACHE_DIR%" 
RunHiddenConsole httpd.exe
ECHO.OK
ECHO.
goto :eof

:shutdownRedis
ECHO.Stopping Redis...... 
taskkill /F /IM redis-server.exe > nul
ECHO.OK
ECHO. 
goto :eof

:startRedis
ECHO.Start Redis...... 
IF NOT EXIST "%REDIS_DIR%redis-server.exe" (
ECHO "%REDIS_DIR%redis-server.exe" not exist
goto :eof
)
%XDISK% 
cd "%REDIS_DIR%" 
RunHiddenConsole redis-server.exe
ECHO.OK
ECHO.
goto :eof

