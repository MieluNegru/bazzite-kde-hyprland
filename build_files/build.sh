#!/bin/bash

set -ouex pipefail

echo "=== releasever debug ==="
rpm -E %fedora
cat /etc/os-release | grep VERSION_ID
cat /etc/dnf/vars/releasever 2>/dev/null || echo "no releasever var"
echo "========================"


### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf5 install -y tmux 

# Broken dependency tree for aquamarine for fedora-44. Killing Hyprland for now
# Using COPR to install hyprland and related packages for creating a desktop environment
# dnf5 -y copr enable solopasha/hyprland
# dnf5 -y install                  \
#     hyprland                     \
#     hyprpaper                    \
#     hyprpicker                   \
#     hypridle                     \
#     hyprlock                     \
#     hyprsunset                   \
#     hyprland                     \
#     waybar                       \
#     xdg-desktop-portal-hyprland
# 
# dnf5 -y copr disable solopasha/hyprland

# Installing keyd for key remapping
dnf5 -y copr enable alternateved/keyd
dnf5 -y install keyd
dnf5 -y copr disable alternateved/keyd

#Installing Zellij
dnf5 -y copr enable varlad/zellij 
dnf5 -y install zellij
dnf5 -y copr disable varlad/zellij 

# Installing sevaral java installations
dnf5 -y install adoptium-temurin-java-repository
fedora-third-party enable


dnf5 -y install \
    java-25-openjdk-devel \
    temurin-21-jdk \
    temurin-17-jdk \
    temurin-11-jdk \
    temurin-8-jdk

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
systemctl enable keyd
