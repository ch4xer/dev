cd
# kitty install
# curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin launch=n
# ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten ~/.local/bin/
# cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
# sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty.desktop
# sed -i "s|Exec=kitty|Exec=/home/$USER/.local/kitty.app/bin/kitty --class=terminal|g" ~/.local/share/applications/kitty.desktop
# sed -e '/Try/d' ~/.local/share/applications/kitty.desktop > ~/.local/share/applications/kitty.desktop.tmp
# mv ~/.local/share/applications/kitty.desktop.tmp ~/.local/share/applications/kitty.desktop

# neovim install
wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/bin/nvim
