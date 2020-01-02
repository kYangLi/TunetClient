#!/bin/bash
#

declare -r DEFAULT_PYTHON_EXEC="/bin/python"
declare -r TUNET_MAIN_FOLDER=$(cd $(dirname $0); pwd)
declare -r PYTHON_SLN="${TUNET_MAIN_FOLDER}/python"
declare -r TUNET_PY="${TUNET_MAIN_FOLDER}/TunetWebClient.py"
declare -r TUNET_IPV4_CONF="${TUNET_MAIN_FOLDER}/tunet_ipv4.conf.josn"
declare -r TUNET_IPV6_CONF="${TUNET_MAIN_FOLDER}/tunet_ipv6.conf.josn"

if [ ! -L ${PYTHON_SLN} ]; then
  echo "[info] Symbol link: ${PYTHON_SLN} do not found..."
  echo "[input] Please input the python path."
  echo "[input] Default: ${DEFAULT_PYTHON_EXEC}"
  read -p '> ' python_exec
  if [ -z "${python_exec}" ]; then
    python_exec=${DEFAULT_PYTHON_EXEC}
  fi
  ln -s ${python_exec} ${PYTHON_SLN}
fi

python_link_valid=false
while ! ${python_link_valid}; do 
  python_path=$(readlink -f ${PYTHON_SLN})
  if [ ! -s python_path ]; then
    echo "[info] Python exec. do not found..."
    echo "[info] Please try to relink it..."
    echo "[input] Please input the python path."
    echo "[input] Default: ${DEFAULT_PYTHON_EXEC}"
    read -p '> ' python_exec
    if [ -z "${python_exec}" ]; then
      python_exec=${DEFAULT_PYTHON_EXEC}
    fi 
    rm ${PYTHON_SLN}
    ln -s ${python_exec} ${PYTHON_SLN}
  else
    python_link_valid=true
  fi
done

if [ ! -s ${TUNET_PY} ]; then
  echo "[error] TunetClient.py not found!!!"
  echo "[error] Please check the TUNET_PY in ${TUNET_MAIN_FOLDER}/RunMe.sh"
  exit 1
fi

if [ "$1" == "4" ]; then
  echo '==================== Disconnect ipv4 Link ===================='
  ${PYTHON_SLN} ${TUNET_PY} -s X -f ${TUNET_IPV4_CONF} -i 4
  echo '==================== Request ipv4 Link... ===================='
  ${PYTHON_SLN} ${TUNET_PY} -s O -f ${TUNET_IPV4_CONF} -i 4
  echo '=========================== DONE. ============================'
elif [ "$1" == "6" ]; then
  echo '==================== Disconnect ipv6 Link ===================='
  ${PYTHON_SLN} ${TUNET_PY} -s X -f ${TUNET_IPV6_CONF} -i 6
  echo '==================== Request ipv6 Link... ===================='
  ${PYTHON_SLN} ${TUNET_PY} -s O -f ${TUNET_IPV6_CONF} -i 6
  echo '=========================== DONE. ============================'
else
  echo '==================== Disconnect ipv4 Link ===================='
  ${PYTHON_SLN} ${TUNET_PY} -s X -f ${TUNET_IPV4_CONF} -i 4
  echo '==================== Request ipv4 Link... ===================='
  ${PYTHON_SLN} ${TUNET_PY} -s O -f ${TUNET_IPV4_CONF} -i 4
  echo '==================== Disconnect ipv6 Link ===================='
  ${PYTHON_SLN} ${TUNET_PY} -s X -f ${TUNET_IPV6_CONF} -i 6
  echo '==================== Request ipv6 Link... ===================='
  ${PYTHON_SLN} ${TUNET_PY} -s O -f ${TUNET_IPV6_CONF} -i 6
  echo '=========================== DONE ============================='
fi