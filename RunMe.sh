#!/bin/bash
#

declare -r TUNET_PATH="/home/alex/Program/Tunet"
declare -r TUNET_PYTHON_PATH="/home/alex/Program/Anaconda3.5/bin/python"
declare -r TUNET_EXEC="${TUNET_PATH}/TunetWebClient.py"
declare -r TUNET_IPV4_CONF="${TUNET_PATH}/tunet_ipv4.conf.josn"
declare -r TUNET_IPV6_CONF="${TUNET_PATH}/tunet_ipv6.conf.josn"

if [ ! -s ${TUNET_PYTHON_PATH} ]; then
  echo "[error] Python exec was not found!!!"
  echo "[error] Please check the TUNET_PYTHON_PATH in RunMe.sh"
  exit 1
fi
if [ ! -s ${TUNET_EXEC} ]; then
  echo "[error] TunetClient.py was not found!!!"
  echo "[error] Please check the TUNET_EXEC in RunMe.sh"
  exit 1
fi

#f [ "$1" == "O" ]; then
#  echo '==================== Request ipv4 Link... ===================='
#  ${TUNET_PYTHON_PATH} ${TUNET_EXEC} -s O -f ${TUNET_IPV4_CONF} -i 4
#  echo '==================== Request ipv6 Link... ===================='
#  ${TUNET_PYTHON_PATH} ${TUNET_EXEC} -s O -f ${TUNET_IPV6_CONF} -i 6
#  echo '=========================== DONE. ============================'
#elif [ "$1" == "rO" ]; then
#  echo '==================== Disconnect ipv4 Link ===================='
#  ${TUNET_PYTHON_PATH} ${TUNET_EXEC} -s X -f ${TUNET_IPV4_CONF} -i 4
#  echo '==================== Disconnect ipv6 Link ===================='
#  ${TUNET_PYTHON_PATH} ${TUNET_EXEC} -s X -f ${TUNET_IPV6_CONF} -i 6
#  echo '==================== Request ipv4 Link... ===================='
#  ${TUNET_PYTHON_PATH} ${TUNET_EXEC} -s O -f ${TUNET_IPV4_CONF} -i 4
#  echo '==================== Request ipv6 Link... ===================='
#  ${TUNET_PYTHON_PATH} ${TUNET_EXEC} -s O -f ${TUNET_IPV6_CONF} -i 6
#  echo '=========================== DONE. ============================'
#elif [ "$1" == "X" ]; then
#  echo '==================== Disconnect ipv4 Link ===================='
#  ${TUNET_PYTHON_PATH} ${TUNET_EXEC} -s X -f ${TUNET_IPV4_CONF} -i 4
#  echo '==================== Disconnect ipv6 Link ===================='
#  ${TUNET_PYTHON_PATH} ${TUNET_EXEC} -s X -f ${TUNET_IPV6_CONF} -i 6
#  echo '=========================== DONE. ============================'
#else 
#  echo "$0 O/rO/X, for Connect, Re-connect or Dis-connect."
#fi

echo '==================== Disconnect ipv4 Link ===================='
${TUNET_PYTHON_PATH} ${TUNET_EXEC} -s X -f ${TUNET_IPV4_CONF} -i 4
echo '==================== Disconnect ipv6 Link ===================='
${TUNET_PYTHON_PATH} ${TUNET_EXEC} -s X -f ${TUNET_IPV6_CONF} -i 6
echo '==================== Request ipv4 Link... ===================='
${TUNET_PYTHON_PATH} ${TUNET_EXEC} -s O -f ${TUNET_IPV4_CONF} -i 4
echo '==================== Request ipv6 Link... ===================='
${TUNET_PYTHON_PATH} ${TUNET_EXEC} -s O -f ${TUNET_IPV6_CONF} -i 6
echo '=========================== DONE. ============================'