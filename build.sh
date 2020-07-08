#!/bin/sh

cd /app/assets
rm -rf node_modules
./yarn
./yarn run build

cd /app

rm -rf _build deps

export MIX_ENV=prod

mix deps.get
mix compile
mix release

