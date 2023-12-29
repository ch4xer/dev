#!/bin/bash

if sudo -n true 2>/dev/null; then
    echo "User can run sudo commands, check passed."
else
    echo "User cannot run sudo commands."
    exit 1
fi

FiraCode_FILE1=/usr/share/fonts/TTF/FiraCodeNerdFont-Regular.ttf
FiraCode_FILE2=/usr/share/fonts/FiraCode/FiraCodeNerdFont-Regular.ttf
FiraCode='https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FiraCode.zip'
if [ -f "$FiraCode_FILE1" ]; then
  echo "FiraCode Nerd Font already exists, skip..."
elif [ -f "$FiraCode_FILE2" ]; then
  echo "FiraCode Nerd Font already exists, skip..."
else
  echo "Downloading FiraCode Nerd Font..."
  rm FiraCode.zip
  wget $FiraCode -O FiraCode.zip
  sudo mkdir -p /usr/share/fonts/FiraCode
  sudo unzip -q FiraCode.zip -d /usr/share/fonts/FiraCode
  rm FiraCode.zip
  sudo fc-cache -fv
fi

LXGW_FILE2=/usr/share/fonts/TTF/LXGWWenKai-Regular.ttf
LXGW_FILE1=/usr/share/fonts/LXGWWenKai/LXGWWenKai-Regular.ttf
LXGW='https://github.com/lxgw/LxgwWenKai/releases/download/v1.300/lxgw-wenkai-v1.300.zip'
if [ -f "$LXGW_FILE1" ]; then
  echo "LXGW Wen Kai already exists, skip..."
elif [ -f "$LXGW_FILE2" ]; then
  echo "LXGW Wen Kai already exists, skip..."
else
  echo "Downloading LXGW Wen Kai..."
  rm LXGW.zip
  wget $LXGW -O LXGW.zip
  sudo mkdir -p /usr/share/fonts/LXGWWenKai
  sudo unzip -q LXGW.zip -d /usr/share/fonts/LXGWWenKai
  rm LXGW.zip
  sudo fc-cache -fv
fi

VictorMono_FILE1=/usr/share/fonts/TTF/VictorMonoNerdFont-Regular.ttf
VictorMono_FILE2=/usr/share/fonts/VictorMono/VictorMonoNerdFont-Regular.ttf
VictorMono=https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/VictorMono.zip
if [ -f "$VictorMono_FILE1" ]; then
  echo "VictorMono Nerd Font already exists, skip..."
elif [ -f "$VictorMono_FILE2" ]; then
  echo "VictorMono Nerd Font already exists, skip..."
else
  echo "Downloading VictorMono Nerd Font..."
  rm VictorMono.zip
  wget $VictorMono -O VictorMono.zip
  sudo mkdir -p /usr/share/fonts/VictorMono
  sudo unzip -q VictorMono.zip -d /usr/share/fonts/VictorMono
  rm VictorMono.zip
  sudo fc-cache -fv
fi

