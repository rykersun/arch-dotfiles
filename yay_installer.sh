sudo pacman -Syy && sudo pacman -S base-devel git && git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin/ && makepkg -si && cd ../ && rm -rf yay-bin/
