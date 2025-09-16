#!/bin/bash

#这里默认都是bash的方法

function handle_server() {
  local item=($(echo $1 | tr ':' ' '))
  local port=22
  local user=root
  local ip=""
  local len=${#item[*]}
  local first=${item[0]}
  if [ $len == 3 ]; then
      user=${item[0]}
      ip=${item[1]}
      port=${item[2]}
  elif [ $len == 2 ];then
    if [[ $first =~ ^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?\.){3} ]];then
      ip=${item[0]}
      port=${item[1]}
    else
      user=${item[0]}
      ip=${item[1]}
    fi
  else
      ip=${item[0]}
  fi
  echo "$user $ip $port"
}
