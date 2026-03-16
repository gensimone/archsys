#!/bin/sh

sudo mkdir -pv /etc/sddm.conf.d

cat <<EOF | sudo tee /etc/sddm.conf.d/autologin.conf 1>/dev/null
[Autologin]
User=simone
Session=sway
EOF
