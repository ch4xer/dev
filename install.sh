git submodule init
git submodule update

BASEDIR=~/.config
rm -r $BASEDIR/alacritty
yes | rm -r $BASEDIR/tmux
yes | rm -r $BASEDIR/zsh
yes | rm -r $BASEDIR/ranger
rm -r ~/.zshrc
cp -r ./tmux ~/.config/
cp -r ./alacritty ~/.config/
cp -r ./zsh ~/.config/
cp -r ./zshrc ~/.zshrc
cp -r ./ranger ~/.config/ranger

license=$BASEDIR/nvim/intelephense_license_key
if [ -e "$license" ]; then
  content=$(cat $license)
  rm -r $BASEDIR/nvim
  cp -r ./nvim ~/.config/
  echo $content > $BASEDIR/nvim/intelephense_license_key
else
  rm -r $BASEDIR/nvim
  cp -r ./nvim ~/.config/
fi

FONT_FILE1=/usr/share/fonts/TTF/FiraCodeNerdFont-Regular.ttf
FONT_FILE2=/usr/share/fonts/FiraCode/FiraCodeNerdFont-Regular.ttf
FONT='https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FiraCode.zip'
if [ -f "$FONT_FILE1" ]; then
  echo "FiraCodeNerdFont-Regular.ttf already exists."
elif [ -f "$FONT_FILE2" ]; then
  echo "FiraCodeNerdFont-Regular.ttf already exists."
else
  echo "Downloading FiraCodeNerdFont-Regular.ttf..."
  wget $FONT
  unzip FiraCode.zip
  mkdir -p /usr/share/fonts/FiraCode
  cp ./FiraCode/*.ttf /usr/share/fonts/FiraCode
  rm -r ./FiraCode
  rm ./FiraCode.zip
  fc-cache -fv
fi
