#!/bin/bash

echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts

timedatectl set-ntp true
hwclock --systohc

pacman -Syy
pacman -S --needed --noconfirm reflector
reflector -c us -a 3 --sort rate -p http --save /etc/pacman.d/mirrorlist --verbose
pacman -Syy

pacman -S --needed --noconfirm xorg xorg-server amd-ucode plasma plasma-desktop sddm konsole kwrite dolphin xf86-video-amdgpu mesa vulkan-radeon libva-mesa-driver mesa-vdpau xdg-user-dirs xdg-utils wpa_supplicant alsa alsa-utils pulseaudio pulseaudio-alsa pulseaudio-bluetooth bluez bluez-utils ufw openssh git bash-completion rust go base-devel linux-headers bat lsd grub-btrfs grub-customizer mlocate tldr nmap ranger neovim dosfstools nfs-utils gvfs gvfs-smb inetutils cups hplip reflector acpi acpid lm_sensors acpi_call tlp flatpak sof-firmware nss-mdns os-prober ntfs-3g avahi sudo nano vlc btrfs-progs

pacman -S --needed --noconfirm papirus-icon-theme materia-kde htop neofetch

updatedb
tldr -u

# pacman -S --noconfirm xf86-video-amdgpu
# pacman -S --noconfirm nvidia nvidia-utils nvidia-settings

# mkinitcpio -P
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable cups.service
systemctl enable sddm
systemctl enable tlp
systemctl enable wpa_supplicant
systemctl enable bluetooth
systemctl enable sshd
systemctl enable avahi-daemon
systemctl enable reflector.timer
systemctl enable ufw
systemctl enable acpid

useradd -m willy
echo willy:password | chpasswd
# usermod -aG <group> willy

echo "willy ALL=(ALL) ALL" >> /etc/sudoers.d/willy

ufw enable
ufw allow proto tcp from any to any port 22 comment "SSH"

reboot


