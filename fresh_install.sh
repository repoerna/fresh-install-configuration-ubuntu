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
sudo apt install curl -y


# regolith -----------------------------------------------------------
# -- install
sudo apt install regolith-desktop regolith-compositor-picom-glx -y


# -- i3xrocks
sudo apt install i3xrocks-rofication i3xrocks-microphone i3xrocks-volume i3xrocks-temp i3xrocks-cpu-usage i3xrocks-battery i3xrocks-disk-capacity -y

# -- copy Xresource file to overide settings
mv ./Xresources ~/.config/regolith2/ 


# kitty ---------------------------------------------------------------
# -- install
sudo apt install kitty -y

# -- set kitty as default terminal
sudo update-alternatives --set x-terminal-emulator $(which kitty) 

# feh ----------------------------------------------------------------
# -- install
sudo apt-get install feh -y

# -- download image
curl -o ~/Pictures/wllppr.jpg "https://images.unsplash.com/photo-1523248948644-586f1ab2a83e?ixlib=rb-4.0.3&dl=tyler-lastovich-VuRQP-kOYbc-unsplash.jpg&w=2400&q=80&fm=jpg&crop=entropy&cs=tinysrgb"

# -- set wallpaper
feh --bg-fill ~/Pictures/wllppr.jpg
