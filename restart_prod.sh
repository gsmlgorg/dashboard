#!/bin/bash

start() {
  echo "Starting service..."
  MIX_ENV=prod PORT=80 elixir --detached -e "File.write! 'priv/pid', :os.getpid" -S mix phx.server
  sleep 5
  pid=pid
  [ -f priv/pid ] && pid=`cat priv/pid`
  if [[ `ps aux | awk -v pid="$pid" '{if($2 == (pid)){print $2}}'` -eq $pid ]]
  then
    echo "Server started! <pid $pid>"
  else
    [ -f priv/pid ] && rm -f priv/pid
    echo "Server start failure!"
  fi
}

stop() {
  echo "Stoping service..."
  pid=`cat priv/pid`
  t=0
  while [[ `ps aux | awk -v pid="$pid" '{if($2 == (pid)){ print $2 }}'` -eq $pid ]]
  do
    t=`expr $t + 1`
    if [[ $t -gt 10 ]]
    then
      kill -9 $pid
    else
      kill $pid
    fi
    sleep 1
  done
  rm -f priv/pid
  echo "Server Stoped!"
}

if [ -f priv/pid ]
then
  stop
  start
else
  start
fi
