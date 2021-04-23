@ECHO OFF
cd %~dp0
chcp 65001
set TITLE=%cd%
start "%TITLE%" startup.bat log