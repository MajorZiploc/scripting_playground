#!/usr/bin/env bash

function main {
  remote_port="$1";
  local_port="$2";
  remote_server="$3";
  local_server="$4";
  # remote to local tunnel
  ssh -f -N "$remote_server" -R "$remote_port:$local_server:$local_port"
}

#main "25" "225" "admin@server1.example.com" "localhost"
main "25" "225" "localhost" "localhost"

