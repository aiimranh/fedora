#!/bin/bash

## Part 1: Remove Packages
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
)

# Remove packages
for package in "${rem_packages[@]}"; do
    sudo dnf remove "$package" -y
done

## Part 2: Configure DNF
lines_to_add="# added for speed:
fastestmirror=True
max_parallel_downloads=3
defaultyes=True"

# File path
file="/etc/dnf/dnf.conf"

# Prompt for DNF configuration change
read -p "Do you want to change DNF Configuration? (y/N): " choice

# Convert choice to lowercase and trim leading/trailing whitespace
choice=$(echo "$choice" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')

# Update DNF configuration if requested
if [[ ("$choice" = "y" || "$choice" = "yes") && -f "$file" ]]; then
    echo "$lines_to_add" | sudo tee -a "$file" > /dev/null
else
    echo "DNF Configuration Skipped."
fi

## Part 3: Update System
# Prompt for system update
read -p "Do you want to Update full system? (y/N): " choice

# Convert choice to lowercase and trim leading/trailing whitespace
choice=$(echo "$choice" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')

# Update system if requested
if [[ "$choice" = "y" || "$choice" = "yes" ]]; then
    sudo dnf update -y
else
    echo "Update Installation Skipped."
fi

## Part 4: Install NVIDIA Drivers and CUDA Support
# Prompt for NVIDIA installation
read -p "Do you want to install NVIDIA drivers and CUDA support? (y/N): " choice

# Convert choice to lowercase and trim leading/trailing whitespace
choice=$(echo "$choice" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')

# Install NVIDIA drivers and CUDA support if requested
if [[ "$choice" = "y" || "$choice" = "yes" ]]; then
    sudo dnf install akmod-nvidia
    sudo dnf install xorg-x11-drv-nvidia-cuda
else
    echo "NVIDIA Installation Skipped."
fi

## Part 5: Install RPM Fusion
# Prompt for RPM Fusion installation
read -p "Do you want to install RPM Fusion (Free - F) (Non-free - G) (Both - b)? (b/f/g/N): " choice

# Convert choice to lowercase and trim leading/trailing whitespace
choice=$(echo "$choice" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')

# Install RPM Fusion based on user choice
case "$choice" in
    "b")
        sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
        sudo dnf install https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
        ;;
    "f")
        sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
        ;;
    "g")
        sudo dnf install https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
        ;;
    *)
        echo "RPM Installation Skipped."
        ;;
esac

