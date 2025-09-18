#!/bin/bash
source .gitlab/scripts/utils.sh

function npm_install() {
    if [ ! -d node_modules ];then
      if [ -z "$NPM_REG" ];then
        NPM_REG="https://registry.npmmirror.com/"
      else
        NPM_REG="$NPM_REG"
      fi
      msg_info "更换仓库源: $NPM_REG"
      yarn config set registry $NPM_REG
      msg_info "yarn add dependency"
      yarn install --cache-folder .yarn
    fi
    msg_info "node_modules已存在"
    # yarn run build
}
