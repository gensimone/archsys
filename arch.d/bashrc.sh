#!/bin/sh

cat <<EOF | sudo tee /root/.bashrc
[[ \$- != *i* ]] && return

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

set -o vi

PS1='\[\e[31m\][root]\[\e[0m\][\[\033[01;34m\]\w\[\033[00m\]]$ '
EOF
