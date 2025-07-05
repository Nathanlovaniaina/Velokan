@echo off
set WAR_NAME=VelonKan.war
set SOURCE_DIR=C:\Users\Rojo\Documents\Velokan
set DEST_DIR=C:\Program Files\Apache Software Foundation\Tomcat 9.0\webapps

echo Copying %WAR_NAME% to %DEST_DIR% ...
copy "%WAR_NAME%" "%DEST_DIR%\%WAR_NAME%" /Y

if %ERRORLEVEL%==0 (
    echo Deploy successful.
) else (
    echo Deploy failed.
)
pause
