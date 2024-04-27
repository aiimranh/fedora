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
    epiphany*
    game-music-emu*  # Apps Store may be
)

# Loop through the list of packages and remove them
for package in "${rem_packages[@]}"; do
    sudo dnf remove "$package" -y
done

# updating system
sudo dnf update -y

# List of packages to install
packages=(
    git
    wget
    curl
    gnome-tweaks
)

# Loop through the list of packages and install them
for package in "${packages[@]}"; do
    sudo dnf install "$package" -y
done

