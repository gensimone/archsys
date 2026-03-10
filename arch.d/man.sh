#!/bin/sh

if ! command -V mandb >/dev/null 2>&1; then
    echo >&2 "man-db not installed."
else
    sudo mandb
fi
