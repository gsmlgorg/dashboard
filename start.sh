#!/bin/sh

echo "Starting service..."
MIX_ENV=prod PORT=80 elixir --detached -e "File.write! 'priv/pid', :os.getpid" -S mix phx.server
echo "Server started ! <pid `cat priv/pid`>"


