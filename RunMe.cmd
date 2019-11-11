@echo off

SET TUNET_PATH=D:\SmartTools\TunetClient-python
SET TUNET_PYTHON_PATH=D:\Work\Anaconda3\python.exe
SET TUNET_EXEC=%TUNET_PATH%\TunetWebClient.py
SET TUNET_IPV4_CONF=%TUNET_PATH%\tunet_ipv4.conf.josn
SET TUNET_IPV6_CONF=%TUNET_PATH%\tunet_ipv6.conf.josn

IF NOT EXIST %TUNET_PYTHON_PATH% (
  echo "[error] Python exec was not found!!!"
  echo "[error] Please check the TUNET_PYTHON_PATH in RunMe.sh"
  EXIT /B 1
)
IF NOT EXIST %TUNET_EXEC% (
  ECHO [error] TunetClient.py was not found!!!
  ECHO [error] Please check the TUNET_EXEC in RunMe.sh
  EXIT /B 1
)

REM echo '==================== Disconnect ipv4 Link ===================='
REM %TUNET_PYTHON_PATH% %TUNET_EXEC% -s X -f %TUNET_IPV4_CONF% -i 4
REM echo '==================== Disconnect ipv6 Link ===================='
REM %TUNET_PYTHON_PATH% %TUNET_EXEC% -s X -f %TUNET_IPV6_CONF% -i 6
ECHO '==================== Request ipv4 Link... ===================='
%TUNET_PYTHON_PATH% %TUNET_EXEC% -s O -f %TUNET_IPV4_CONF% -i 4
ECHO '==================== Request ipv6 Link... ===================='
%TUNET_PYTHON_PATH% %TUNET_EXEC% -s O -f %TUNET_IPV6_CONF% -i 6
ECHO '=========================== DONE. ============================'

