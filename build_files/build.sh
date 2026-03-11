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
dnf5 -y install                  \
    hyprland                     \
    hyprpaper                    \
    hyprpicker                   \
    hypridle                     \
    hyprlock                     \
    hyprsunset                   \
    hyprland                     \
    waybar                       \
    xdg-desktop-portal-hyprland

dnf5 -y copr disable solopasha/hyprland

# Installing sevaral java installations
dnf5 -y install adoptium-temurin-java-repository
fedora-third-party enable

dnf5 -y install                   \
    java-25-openjdk-devel.x86_64  \
    java-21-openjdk-devel.x86_64  \
    temurin-17-jdk.x86_64         \
    temurin-11-jdk.x86_64         \
    temurin-8-jdk.x86_64

# Installing more desktop utils
dnf5 -y install            \
    alacritty              \    
    blueman                \
    brightnessctl          \
    fontawesome-fonts      \
    network-manager-applet \
    pavucontrol            \
    wofi                   \

# Open port 4000 for NoMachine
# firewall-cmd --permanent --add-port=4000/tcp || true
# firewall-cmd --reload || true

systemctl enable podman.socket
