@echo off

SET TUNET_MAIN_FOLDER=%~dp0
SET PYTHON_SLN=%TUNET_MAIN_FOLDER%python.txt
SET TUNET_PY=%TUNET_MAIN_FOLDER%TunetWebClient.py
SET TUNET_IPV4_CONF=%TUNET_MAIN_FOLDER%tunet_ipv4.conf.josn
SET TUNET_IPV6_CONF=%TUNET_MAIN_FOLDER%tunet_ipv6.conf.josn

IF NOT EXIST %PYTHON_SLN% (
  ECHO [info] Symbol link: %PYTHON_SLN% do not found...
  ECHO [input] Please input the python path.
  SET /P python_exec_tmp="> " 
)
IF NOT EXIST %PYTHON_SLN% ( 
  ECHO %python_exec_tmp% > %PYTHON_SLN%
)
FOR /F "tokens=* USEBACKQ" %%F IN ( `type %PYTHON_SLN%` ) DO ( 
  SET PYTHON_EXEC=%%F 
)

IF NOT EXIST %TUNET_PY% (
  ECHO [error] TunetClient.py was found!!!
  ECHO [error] Please check the TUNET_PY in %TUNET_MAIN_FOLDER%RunMe.cmd
  PAUSE
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

PAUSE
EXIT /B 1