#!/bin/sh

PARU_PATH="$PWD/paru"

if command -V paru >/dev/null 2>&1; then
    echo >&2 "paru: Already installed."
else
    if ! sudo pacman -S --needed base-devel; then
        echo "paru: Aborted" >&2
    else
        if git clone https://aur.archlinux.org/paru.git "$PARU_PATH"; then
            cd paru
            makepkg -si
            rm -rfv $PARU_PATH
        else
            echo "paru: Aborted" >&2
        fi
    fi
fi
