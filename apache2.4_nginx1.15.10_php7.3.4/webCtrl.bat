====================================================
@echo off
rem �������������·�������Թ���Ա�������

echo ==================begin========================

cls 

SET XDISK=D:
SET XPATH=%XDISK%\Web\h-web-env-windows\apache2.4_nginx1.15.10_php7.3.4
SET NGINX_DIR=%XPATH%\nginx-1.15.10\
SET APACHE_DIR=%XPATH%\Apache24\bin\

color ff 
TITLE NAP�������

CLS 
ECHO.# Nginx+Apache+Php
ECHO.# by hunzsig 20190403

:MENU

ECHO.----------------------�����б�----------------------
tasklist|findstr /i "nginx.exe"
tasklist|findstr /i "httpd.exe"
ECHO.----------------------------------------------------
ECHO.[1] ����/����[NAPģʽ]
ECHO.[2] ����/����[APģʽ]
ECHO.[9] �ر�
ECHO.[0] �˳� 
ECHO.���빦�ܺ�:

set /p ID=
IF "%id%"=="1" GOTO startNAP
IF "%id%"=="2" GOTO startAP
IF "%id%"=="9" GOTO stop 
IF "%id%"=="0" EXIT
PAUSE 



:startNAP 
call :shutdown
call :startNginx
call :startApache
GOTO MENU

:startAP 
call :shutdown
call :startApache
GOTO MENU

:stop 
call :shutdown
GOTO MENU

:shutdown
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

