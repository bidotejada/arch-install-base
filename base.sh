#!/bin/bash

echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts

timedatectl set-ntp true
hwclock --systohc

# Refresh Mirrors
pacman -S --needed --noconfirm reflector
reflector --country US --age 3 --sort rate --protocol http --save /etc/pacman.d/mirrorlist --verbose
pacman -Syyy

# General Utilities
pacman -S --needed --noconfirm xorg xorg-server amd-ucode xdg-user-dirs xdg-utils networkmanager wireless_tools wpa_supplicant dialog os-prober mtools ntfs-3g dosfstools btrfs-progs nfs-utils alsa alsa-utils pulseaudio pulseaudio-alsa pulseaudio-bluetooth bluez bluez-utils ufw openssh git bash-completion rust go base-devel linux-headers bat lsd grub-btrfs grub-customizer mlocate tldr nmap ranger neovim gvfs gvfs-smb inetutils cups hplip reflector acpi acpid lm_sensors acpi_call tlp flatpak sof-firmware nss-mdns avahi sudo nano vlc papirus-icon-theme htop neofetch discord archlinux-wallpaper zsh

#--Plasma Desktop
#pacman -S --needed --noconfirm sddm plasma konsole kwrite dolphin materia-kde packagekit-qt5

#--Gnome Desktop
pacman -S --needed --noconfirm gdm gnome dconf-editor gnome-tweaks gnome-shell-extensions gnome-boxes gnome-connections chrome-gnome-shell gnome-nettool gnome-usage arc-gtk-thme arc-icon-theme

#--Budgie Desktop
#pacman -S --needed --noconfirm lightdm lightdm-gtk-greeter budgie-desktop gnome gnome-control-center materia-gtk-theme i3lock

#--Cinnamon Desktop
#pacman -S --needed --noconfirm lightdm lightdm-webkit2-greeter cinnamon system-config-printer gnome-keyring blueberry gnome-terminal gnome-screenshot lightdm-gtk-greeter lightdm-gtk-greeter-settings arc-gtk-theme

#--xfce Desktop
#pacman -S --needed --noconfirm lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings xfce4 xfce4-goodies arc-gtk-theme arc-icon-theme materia-gtk-theme

updatedb
tldr -u

# GPU Drivers
pacman -S --noconfirm --needed xf86-video-amdgpu mesa vulkan-radeon libva-mesa-driver mesa-vdpau
# pacman -S --noconfirm --needed nvidia nvidia-utils nvidia-settings nvidia-dkms
# pacman -S --noconfirm --needed xf86-video-vmware
# pacman -S --noconfirm --needed xf86-video-intel

# mkinitcpio -P
grub-mkconfig -o /boot/grub/grub.cfg

# Enabling Services
systemctl enable NetworkManager
systemctl enable cups.service
#systemctl enable sddm
systemctl enable gdm
systemctl enable tlp
systemctl enable wpa_supplicant
systemctl enable bluetooth
systemctl enable sshd
systemctl enable avahi-daemon
systemctl enable reflector.timer
systemctl enable ufw
systemctl enable acpid

# Create User
useradd -m willy
echo willy:password | chpasswd
# usermod -aG <group> willy
echo "willy ALL=(ALL) ALL" >> /etc/sudoers.d/willy

# Enable Firewall and Allow External SSH connections
ufw enable
ufw allow proto tcp from any to any port 22 comment "SSH"

reboot


