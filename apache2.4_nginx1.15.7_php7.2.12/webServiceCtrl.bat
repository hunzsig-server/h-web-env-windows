====================================================
@echo off
rem �������������·�������Թ���Ա�������

echo ==================begin========================

cls 

SET XDISK=D:
SET XPATH=%XDISK%\Web\h-web-env-windows\apache2.4_nginx1.15.7_php7.2.12
SET NGINX_DIR=%XPATH%\nginx-1.15.7\
SET APACHE_DIR=%XPATH%\Apache24\bin\

color ff 
TITLE NAP�������

CLS 
ECHO.# Nginx+Apache Service
ECHO.# by hunzsig 20190403

:MENU

ECHO.----------------------�����б�----------------------
tasklist|findstr /i "nginx.exe"
tasklist|findstr /i "httpd.exe"
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
ECHO.Start Nginx...... 
IF NOT EXIST "%NGINX_DIR%nginx.exe" (
ECHO "%NGINX_DIR%nginx.exe" not exist
goto :eof
)
%XDISK% 
cd "%NGINX_DIR%" 
winsw.exe start
ECHO.
ECHO.Start Apache...... 
IF NOT EXIST "%APACHE_DIR%httpd.exe" (
ECHO "%APACHE_DIR%httpd.exe" not exist
goto :eof
)
%XDISK% 
cd "%APACHE_DIR%" 
httpd.exe -k start
ECHO.
goto :eof

:stopX
ECHO.Stop Nginx...... 
IF NOT EXIST "%NGINX_DIR%nginx.exe" (
ECHO "%NGINX_DIR%nginx.exe" not exist
goto :eof
)
%XDISK% 
cd "%NGINX_DIR%" 
winsw.exe stop
taskkill /F /IM nginx.exe > nul
ECHO.
ECHO.Stop Apache...... 
IF NOT EXIST "%APACHE_DIR%httpd.exe" (
ECHO "%APACHE_DIR%httpd.exe" not exist
goto :eof
)
%XDISK% 
cd "%APACHE_DIR%" 
httpd.exe -k stop
ECHO.
goto :eof

:registerX
ECHO.Register Nginx...... 
IF NOT EXIST "%NGINX_DIR%nginx.exe" (
ECHO "%NGINX_DIR%nginx.exe" not exist
goto :eof
)
%XDISK% 
cd "%NGINX_DIR%" 
winsw.exe install
ECHO.
ECHO.Register Apache...... 
IF NOT EXIST "%APACHE_DIR%httpd.exe" (
ECHO "%APACHE_DIR%httpd.exe" not exist
goto :eof
)
%XDISK% 
cd "%APACHE_DIR%"
httpd.exe -k install
ECHO.
goto :eof

:removeX
ECHO.Remove Nginx...... 
IF NOT EXIST "%NGINX_DIR%nginx.exe" (
ECHO "%NGINX_DIR%nginx.exe" not exist
goto :eof
)
%XDISK% 
cd "%NGINX_DIR%"
winsw.exe uninstall
ECHO.
ECHO.Remove Apache...... 
IF NOT EXIST "%APACHE_DIR%httpd.exe" (
ECHO "%APACHE_DIR%httpd.exe" not exist
goto :eof
)
%XDISK% 
cd "%APACHE_DIR%"
httpd.exe -k uninstall
ECHO.
goto :eof