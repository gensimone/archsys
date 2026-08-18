#!/bin/sh

killall -SIGUSR1 foot

echo "initial-color-theme=dark" > ~/.config/foot/initial-colorscheme.init
