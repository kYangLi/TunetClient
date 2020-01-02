@echo off

SET PYTHON_EXEC=python      :: You can change this with a abs. path
SET TUNET_MAIN_FOLDER=%~dp0
SET TUNET_PY=%TUNET_MAIN_FOLDER%TunetWebClient.py
SET TUNET_IPV4_CONF=%TUNET_MAIN_FOLDER%tunet_ipv4.conf.josn
SET TUNET_IPV6_CONF=%TUNET_MAIN_FOLDER%tunet_ipv6.conf.josn

IF NOT EXIST %PYTHON_EXEC% (
  ECHO [error] Python exec not found!!!
  ECHO [error] Please check the PYTHON_EXEC in %TUNET_MAIN_FOLDER%RunMe.cmd
  pause
  EXIT /B 1
)
IF NOT EXIST %TUNET_PY% (
  ECHO [error] TunetClient.py was found!!!
  ECHO [error] Please check the TUNET_PY in %TUNET_MAIN_FOLDER%RunMe.cmd
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