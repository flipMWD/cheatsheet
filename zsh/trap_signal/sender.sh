#!/usr/bin/env zsh

read '?Terminate? [y/N] ' order

if [[ ${(L)order} == 'y' ]]; then
    # kill built-in only takes NAL in sigNAL, pgrep -f[ullname]
    kill -INT -- $(pgrep -f receiver)
fi

