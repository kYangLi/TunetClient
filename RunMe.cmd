@echo off

SET TUNET_MAIN_FOLDER=D:\SmartTools\TunetClient-python
SET PYTHON_EXEC=D:\Work\Anaconda3\python.exe
SET TUNET_PY=%TUNET_MAIN_FOLDER%\TunetWebClient.py
SET TUNET_IPV4_CONF=%TUNET_MAIN_FOLDER%\tunet_ipv4.conf.josn
SET TUNET_IPV6_CONF=%TUNET_MAIN_FOLDER%\tunet_ipv6.conf.josn

IF NOT EXIST %PYTHON_EXEC% (
  ECHO [error] Python exec not found!!!
  ECHO [error] Please check the PYTHON_EXEC in RunMe.cmd
  pause
  EXIT /B 1
)
IF NOT EXIST %TUNET_PY% (
  ECHO [error] TunetClient.py was found!!!
  ECHO [error] Please check the TUNET_PY in RunMe.cmd
  pause
  EXIT /B 1
)

ECHO ==================== Disconnect ipv4 Link ====================
%PYTHON_EXEC% %TUNET_PY% -s X -f %TUNET_IPV4_CONF% -i 4
ECHO ==================== Request ipv4 Link... ====================
%PYTHON_EXEC% %TUNET_PY% -s O -f %TUNET_IPV4_CONF% -i 4
ECHO ==================== Disconnect ipv6 Link ====================
%PYTHON_EXEC% %TUNET_PY% -s X -f %TUNET_IPV6_CONF% -i 6
ECHO ==================== Request ipv6 Link... ====================
%PYTHON_EXEC% %TUNET_PY% -s O -f %TUNET_IPV6_CONF% -i 6
ECHO =========================== DONE =============================

pause
EXIT /B 1