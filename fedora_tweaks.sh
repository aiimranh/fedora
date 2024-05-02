#!/bin/bash

# List of packages to remove
rem_packages=(
    libreport.x86_64
    libreport.i686
    reportd.x86_64
    gnome-contacts*
    gnome-calculator*
    gnome-connections*
    baobab*
    gnome-disk-utility*
    simple-scan*
    gnome-logs*
    gnome-maps*
    mediawriter*
    libreoffice*
    gnome-boxes*
    totem-video-thumbnailer*
    rhythmbox*
    gnome-weather*
    # epiphany*        #App Store
    # game-music-emu*
)

# Loop through the list of packages and remove them
for package in "${rem_packages[@]}"; do
    sudo dnf remove "$package" -y
done

# List of packages to install
packages=(
    gnome-tweaks
    zsh
)

# Loop through the list of packages and install them
for package in "${packages[@]}"; do
    sudo dnf install "$package" -y
done

# updating system
sudo dnf update -y

