sudo timedatectl set-ntp true
sudo timedatectl set-timezone Asia/Taipei
sudo timedatectl set-local-rtc 1

sudo os-prober
sudo grub-mkconfig -o /boot/grub/grub.cfg

sudo ./chaotic-aur_installer.sh && sudo pacman -S alacritty-git qutebrowser-git helix-git rofi xclip
