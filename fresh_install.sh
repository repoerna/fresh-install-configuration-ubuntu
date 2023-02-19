#!/bin/bash

# setup keys ---------------------------------------------------------
# -- regolith
wget -qO - https://regolith-desktop.org/regolith.key | \
gpg --dearmor | sudo tee /usr/share/keyrings/regolith-archive-keyring.gpg > /dev/null

echo deb "[arch=amd64 signed-by=/usr/share/keyrings/regolith-archive-keyring.gpg] \
https://regolith-desktop.org/release-ubuntu-jammy-amd64 jammy main" | \
sudo tee /etc/apt/sources.list.d/regolith.list


# update and upgrade -------------------------------------------------
sudo apt update -y && sudo apt upgrade -y
#sudo apt install curl -y
sudo apt-get install git python3-pip fonts-font-awesome fonts-firacode fonts-nerd-font-firacode curl vim pulseaudio pavucontrol -y

# regolith -----------------------------------------------------------
# -- install
sudo apt install regolith-desktop regolith-compositor-picom-glx -y

# -- looks
sudo apt install regolith-look-nord -y

# -- regolith user config
mkdir -p ~/.config/regolith2/i3/config.d
cp ./regolith/00_program-bindkey ~/.config/regolith2/i3/config.d/
cp ./regolith/01_program-bindkey-with-mod ~/.config/regolith2/i3/config.d/
cp ./regolith/02_shortcut-bindkey ~/.config/regolith2/i3/config.d/

# -- copy Xresource file to overide settings
cp ./regolith/Xresources ~/.config/regolith2/ 

# -- copy picom
mkdir -p ~/.config/regolith2/picom
cp ./picom/config ~/.config/regolith2/picom/


# kitty ---------------------------------------------------------------
# -- install
sudo apt install kitty -y

# -- set kitty as default terminal
sudo update-alternatives --set x-terminal-emulator $(which kitty) 

# -- set kitty theme
git clone --depth 1 https://github.com/dexpota/kitty-themes.git ~/.config/kitty/kitty-themes

ln -s ~/.config/kitty/kitty-themes/themes/Duotone_Dark.conf ~/.config/kitty/theme.conf

cp ./kitty/kitty.conf ~/.config/kitty/


# feh ----------------------------------------------------------------
# -- install
sudo apt-get install feh -y

# -- download image
curl -o ~/Pictures/wllppr.jpg "https://images.unsplash.com/photo-1523248948644-586f1ab2a83e?ixlib=rb-4.0.3&dl=tyler-lastovich-VuRQP-kOYbc-unsplash.jpg&w=2400&q=80&fm=jpg&crop=entropy&cs=tinysrgb"

# -- set wallpaper
feh --bg-fill ~/Pictures/wllppr.jpg


# bumblebee-status ------------------------------------------------------
# -- install
git clone https://github.com/tobi-wan-kenobi/bumblebee-status.git ~/.config/bumblebee

# -- pulsectl
pip install pulsectl

# -- netifacce
sudo apt-get install python3-netifaces -y


# tmux ------------------------------------------------------------------
# -- install
sudo apt install tmux -y


# ZSH --------------------------------------------------------------------
# -- install ZSH
sudo apt install zsh -y

# -- make ZSH default 
#chsh -s $(which zsh)

# -- install oh my zsh
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sed 's:env zsh::g' | sed 's:chsh -s .*$::g')"

# -- zsh highlight
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

sed -i "s/plugins=(/&zsh-syntax-highlighting\ /" ~/.zshrc

# -- zsh autosuggestion
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
sed -i "s/plugins=(/&zsh-autosuggestions\ /" ~/.zshrc

# -- fzf
sudo apt install fzf
sed -i "s/plugins=(/&fzf zsh-interactive-cd\ /" ~/.zshrc

# -- other plugins
pip install thefuck
echo "export PATH=~/.local/bin:\$PATH" >> .zshrc
sed -i "s/plugins=(/&tmux wd jsontools thefuck\ /" ~/.zshrc

# -- spaceship propmt
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
sed -i "s/ZSH_THEME=\"robbyrussell\"/ZSH_THEME=\"spaceship\"/g" ~/.zshrc


# greenclip - clipboard -----------------------------------------------------
# -- install greenclip
wget https://github.com/erebe/greenclip/releases/download/v4.2/greenclip
mv greenclip ~/.local/bin/
chmod +x ~/.local/bin/greenclip

# -- install rofi
sudo apt install rofi -y

# -- setup rofi themes
mkdir -p ~/.local/share/rofi/themes
git clone https://github.com/lr-tech/rofi-themes-collection.git ~/rofi-themes-cpllection
cp ~/rofi-themes-collection/themes/nord.rasi ~/.local/share/rofi/themes/


# flameshot -----------------------------------------------------
## -- install flameshot
sudo apt install flameshot -y

# cleanup
sudo apt autoremove -y
