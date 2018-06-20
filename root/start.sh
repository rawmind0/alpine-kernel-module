#!/usr/bin/env bash

KEEP_ALIVE=${KEEP_ALIVE:-"0"}
LOAD_MODULES=${LOAD_MODULES:-""}

if [ -n "${LOAD_MODULES}" ] ; then
	modulesToLoad=$(echo ${LOAD_MODULES} | sed 's/ //g' | sed 's/,/ /g')
	for i in ${modulesToLoad}; do
		echo -n `date` $ME - "Loading kernel module $i ..."
		modprobe $i
		rc=$?
		if [ "$rc" -ne "0" ]; then
			echo " [FAIL]"
	    	echo `date` $ME - "[ERROR]: Failed to load kernel module $i ..."
			exit 1
		fi
		echo " [OK]"
	done
else
	echo `date` $ME - "[ERROR]: You need to define LOAD_MODULES env variable...."
	exit 1
fi

if [ "x$KEEP_ALIVE" == "x1" ]; then
	trap "exit 0" SIGINT SIGTERM
	while :
	do
		echo `date` $ME - "I'm alive"
		sleep 600
	done
fi

exit 0
