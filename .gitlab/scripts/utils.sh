#!/bin/bash

function msg_info() {
    #printf "${underline}${bold}${green}: %s${reset}\n" "$@"
    echo -e "\033[1;4;32m: $@\033[0m"
}

function msg_warn() {
    #printf "${underline}${bold}${tan}: %s${reset}\n" "$@"
    echo -e "\033[1;4;35m: $@\033[0m"
}

function add_ssh_key() {
    echo
    msg_info "add ssh private key"
    which ssh-agent || ( apt-get update -y && apt-get install openssh-client -y )
    eval $(ssh-agent -s)
    echo -e "$SSH_PRIVATE_KEY" | ssh-add -
    mkdir -p ~/.ssh && chmod 700 ~/.ssh
    [ -f /.dockerenv ]; echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config
}
