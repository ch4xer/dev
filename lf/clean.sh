#!/usr/bin/env bash

if [ -n "$TMUX" ]; then
  return 1
fi

kitty +kitten icat --clear --stdin no --silent --transfer-mode file < /dev/null > /dev/tty 
