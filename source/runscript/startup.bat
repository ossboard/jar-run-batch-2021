@ECHO OFF
:: UTF8(x),EUCKR(o)
cd %~dp0
SET JAVA=java
SET PORT=8080
SET CONTEXTPATH=/server
SET T_NAME=program.war --server.port=%PORT% --server.servlet.contextPath=%CONTEXTPATH% -Xms32m -Xmx32m
:: tibero(add) = --log4jdbc.drivers=com.tmax.tibero.jdbc.TbDriver
SET T_USAGE="Usage: %0 {start | stop | restart | status | log}"

IF "%1"=="start" (
  CALL :fn_start
) ELSE IF "%1"=="stop" (
  CALL :fn_stop
) ELSE IF "%1"=="restart" (
  CALL :fn_restart
) ELSE IF "%1"=="status" (
  CALL :fn_status
) ELSE IF "%1"=="log" (
  CALL :fn_log
) ELSE (
  echo %T_USAGE%
)
EXIT /B %ERRORLEVEL%

:fn_status
  SET PID=-1
  FOR /F "tokens=1" %%i IN ('jps -ml ^| find /i "%T_NAME%"') do (
    SET PID=%%i
  )
  IF %PID% GEQ 0 (
    echo %T_NAME% is running with pid: %PID%
  ) ELSE (
    echo %T_NAME% is not running
  )
  EXIT /B 0

:fn_restart
  CALL :fn_stop
  TIMEOUT 1
  CALL :fn_start
  EXIT /B 0

:fn_stop
  FOR /F "tokens=1" %%i IN ('jps -ml ^| find /i "%T_NAME%"') do (
    CALL taskkill /F /PID %%i
  )
  EXIT /B 0

:fn_start
  SET PID=-1
  FOR /F "tokens=1" %%i IN ('jps -ml ^| find /i "%T_NAME%"') do (
    SET PID=%%i
  )
  IF %PID% GEQ 0 (
    echo %T_NAME% is running with pid: %PID%
	EXIT /B 0
  )
  %JAVA% -jar %T_NAME%
  EXIT /B 0

:fn_log
  tail -f logs\log.log
  EXIT /B 


