#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf5 install -y tmux 

# Using COPR to install hyprland and related packages for creating a desktop environment
dnf5 -y copr enable solopasha/hyprland
# dnf5 -y install                  \
#     hyprland                     \
#     hyprpaper                    \
#     hyprpicker                   \
#     hypridle                     \
#     hyprlock                     \
#     hyprsunset                   \
#     hyprland                     \
#     waybar                       \
#     hyprland-qt-support          \
#     hyprland-qtutils             \
#     xdg-desktop-portal-hyprland

dnf5 -y install hyprland
dnf5 -y install hyprpaper
dnf5 -y install hyprpicker
dnf5 -y install hypridle
dnf5 -y install hyprlock
dnf5 -y install hyprsunset
dnf5 -y install hyprland
dnf5 -y install waybar
dnf5 -y install hyprland-qtutils
dnf5 -y install xdg-desktop-portal-hyprland
    
dnf5 -y copr disable solopasha/hyprland

# Installing more desktop utils
dnf5 -y install    \
    alacritty      \
    wofi           \
    brightnessctl
    


systemctl enable podman.socket
systemctl --global enable hyprpanel.service
