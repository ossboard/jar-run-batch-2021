@ECHO OFF
cd %~dp0
set TITLE=%cd%
start "%TITLE%" startup.bat start
