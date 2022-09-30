sudo rm -rf /etc/pacman.d/gnupg
sudo pacman-key --init
sudo pacman-key --populate

sudo ./chaotic-aur_installer.sh && sudo pacman -S alacritty-git qutebrowser-git helix-git rofi xclip
