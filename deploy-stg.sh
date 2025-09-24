#!/usr/bin/env bash
#!/bin/sh
set -e

base_dir=`dirname $0`
# 进入脚本所在目录
cd $base_dir
need_install=true
need_build=true
# -I 不下载依赖(大写i)
# -B 不build
while getopts ":I|:B" optname;do
    case "$optname" in
      B) need_build=false;;
      I) need_install=false;;
    esac
done

if [ $need_install = true ]; then
    echo '======= Start Install ======='
    npm i
    cd ./server
    npm i
    cd ../
    echo '======= Install Finish ======='
else
    echo '======= Not Install ======='
fi

if [ $need_build = true ]; then
    echo '======= Start Build ======='
    npm run build
    echo '======= Build Finish ======='
else
    echo '======= Not Build ======='
fi




echo '======= Start Run Server ======='
cp -r dist server/
cd ./server
pm2 restart pm2.config.js
