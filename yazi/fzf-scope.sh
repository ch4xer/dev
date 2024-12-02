#!/bin/bash

# if $1 contains ':', split it into $file
if [[ $1 == *:* ]]; then
  file=$(echo $1 | cut -d':' -f1)
else
  file=$1
fi

case "$file" in
	*.md) glow -s dark "$file" ;;
	*.zip) zipinfo "$file" ;;
	*.7z) 7z l "$file" ;;
  *.md) mdcat "$file";;
	*) bat --color=always --italic-text=always --style=numbers,changes,header --line-range :500 "$file" ;;
esac
