#!/bin/bash

# if $1 contains ':', split it into $file
if [[ $1 == *:* ]]; then
  obj=$(echo $1 | cut -d':' -f1)
else
  obj=$1
fi

if [ -d "$obj" ]; then
  tree -ahpCL 3 -I .git -I __pycache__ $obj
else
  case "$obj" in
  *.zip) zipinfo "$obj" ;;
  *.7z) 7z l "$obj" ;;
  *) bat --color=always --italic-text=always --style=numbers,changes,header --line-range :500 "$obj" ;;
  esac
fi
