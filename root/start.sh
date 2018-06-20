#!/usr/bin/env bash

KEEP_ALIVE=${KEEP_ALIVE:-"0"}
KEEP_ALIVE_SLEEP=${KEEP_ALIVE_SLEEP:600}
LOAD_MODULES=${LOAD_MODULES:-""}

exit_val=0
if [ -n "${LOAD_MODULES}" ] ; then
	modulesToLoad=$(echo ${LOAD_MODULES} | sed 's/ //g' | sed 's/,/ /g')
	for i in ${modulesToLoad}; do
		echo -n `date` $ME - "Loading kernel module $i ... "
		CMD_RC=$(modprobe $i 2>&1)
		rc=$?
		if [ "$rc" -ne "0" ]; then
	    	echo "[ERROR] ${CMD_RC}"
			exit_val=1
		else
			echo "[OK]"
		fi
	done
else
	echo `date` $ME - "[ERROR]: You need to define LOAD_MODULES env variable"
	exit_val=1
fi

if [ "x$KEEP_ALIVE" == "x1" ]; then
	trap "exit 0" SIGINT SIGTERM
	while :
	do
		echo `date` $ME - "I'm alive"
		sleep ${KEEP_ALIVE_SLEEP}
	done
fi

exit ${exit_val}
