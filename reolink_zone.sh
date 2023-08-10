#!/bin/bash

# check parameters
if [ $# -lt 3 ]
then
	echo $0 camera "[get|set]" parameter
	exit 1
fi

# functions
sendRequest() {

	REQ="$( jq -n --arg CMD "$CMD" --argjson PARAM "$PARAM" '{
		cmd: $CMD,
		action: 0,
		param: $PARAM, }' )"

	URL="https://$HOST/cgi-bin/api.cgi?cmd=$CMD&user=${USER}&password=${PASS}"

	RES="$( curl -kfsSLH 'Content-Type: application/json' -d "[$REQ]" -XPOST "$URL" | jq '.[0]' )"

	if [ "$(jq -r '.code' <<<"$RES")" -eq "0" ]
	then
		jq '.value' <<<"$RES"
	else
		echo -n "$CMD ERROR: " 1>&2
		jq -r '"\(.error.detail) (\(.error.rspCode))"' <<< "$RES" 1>&2

		exit 1
	fi

}

doGet() {

	CMD="GetAiAlarm"
	PARAM='{"channel":0,"ai_type":"people"}'

	sendRequest | jq '{channel:.[].channel,md:.[].scope,people:.[].scope,vehicle:.[].scope,dog_cat:.[].scope}' -c > "${CAMERA_NAME}_${PARAMETER}.json"

}

doSet() {

	CMD="SetAlarmArea"
	PARAM=$(cat "${CAMERA_NAME}_${PARAMETER}.json")

	sendRequest
}


#include personal and secret data
. .reolink_personal

# example of .reolink_personal:

#USER="USER" 
#PASS="PASS" 
#declare -A CAMERA
#CAMERA["room"]="192.168.1.250" 

# MAIN
CAMERA_NAME=$1
COMMAND=$2
PARAMETER=$3

HOST=${CAMERA[$CAMERA_NAME]}

if [ -z $HOST ]; then echo "invalid camera name: $CAMERA_NAME"; exit 1; fi

case $COMMAND in
	"get")
		doGet
		;;
	"set")
		doSet
		;;
	*)
		echo "invalid command: $COMMAND" 1>&2
		;;
esac

echo $(date) "- done - $*" >> /tmp/reolink_zone.txt


