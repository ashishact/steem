#!/bin/bash

# if all of the reader nodes die, kill runsv causing the container to exit
if [[ "$USE_MULTICORE_READONLY" ]]; then
  pgrep -f read-only
  if [[ ! $? -eq 0 ]]; then
  	echo ALERT! steemd reader nodes have quit unexpectedly, starting a new instance..
    RUN_SV_PID=`pgrep -f /etc/service/steemd`
    kill -9 $RUN_SV_PID
  fi
fi

# if the writer node dies, kill runsv causing the container to exit
pgrep -f p2p-endpoint
if [[ ! $? -eq 0 ]]; then
  echo ALERT! steemd has quit unexpectedly, starting a new instance..
  RUN_SV_PID=`pgrep -f /etc/service/steemd`
  kill -9 $RUN_SV_PID
fi

# check on this every 1 second
sleep 1