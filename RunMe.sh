#!/bin/bash
#

declare -r TUNET_MAIN_FOLDER="/home/user/your/tunet/main/folder"
declare -r PYTHON_EXEC="/home/user/your/python3"
declare -r TUNET_PY="${TUNET_MAIN_FOLDER}/TunetWebClient.py"
declare -r TUNET_IPV4_CONF="${TUNET_MAIN_FOLDER}/tunet_ipv4.conf.josn"
declare -r TUNET_IPV6_CONF="${TUNET_MAIN_FOLDER}/tunet_ipv6.conf.josn"

if [ ! -s ${PYTHON_EXEC} ]; then
  echo "[error] Python exec. not found!!!"
  echo "[error] Please check the PYTHON_EXEC in RunMe.sh"
  exit 1
fi
if [ ! -s ${TUNET_PY} ]; then
  echo "[error] TunetClient.py not found!!!"
  echo "[error] Please check the TUNET_PY in RunMe.sh"
  exit 1
fi

if [ "$1" == "4" ]; then
  echo '==================== Disconnect ipv4 Link ===================='
  ${PYTHON_EXEC} ${TUNET_PY} -s X -f ${TUNET_IPV4_CONF} -i 4
  echo '==================== Request ipv4 Link... ===================='
  ${PYTHON_EXEC} ${TUNET_PY} -s O -f ${TUNET_IPV4_CONF} -i 4
  echo '=========================== DONE. ============================'
elif [ "$1" == "6" ]; then
  echo '==================== Disconnect ipv6 Link ===================='
  ${PYTHON_EXEC} ${TUNET_PY} -s X -f ${TUNET_IPV6_CONF} -i 6
  echo '==================== Request ipv6 Link... ===================='
  ${PYTHON_EXEC} ${TUNET_PY} -s O -f ${TUNET_IPV6_CONF} -i 6
  echo '=========================== DONE. ============================'
else
  echo '==================== Disconnect ipv4 Link ===================='
  ${PYTHON_EXEC} ${TUNET_PY} -s X -f ${TUNET_IPV4_CONF} -i 4
  echo '==================== Request ipv4 Link... ===================='
  ${PYTHON_EXEC} ${TUNET_PY} -s O -f ${TUNET_IPV4_CONF} -i 4
  echo '==================== Disconnect ipv6 Link ===================='
  ${PYTHON_EXEC} ${TUNET_PY} -s X -f ${TUNET_IPV6_CONF} -i 6
  echo '==================== Request ipv6 Link... ===================='
  ${PYTHON_EXEC} ${TUNET_PY} -s O -f ${TUNET_IPV6_CONF} -i 6
  echo '=========================== DONE ============================='
fi