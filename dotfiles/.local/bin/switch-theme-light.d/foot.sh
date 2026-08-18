#!/bin/sh

killall -SIGUSR2 foot

echo "initial-color-theme=light" > ~/.config/foot/initial-colorscheme.init
