rm -rf ~/.config/alacritty/ && mv alacritty/ ~/.config/ && rm -rf ~/.fonts/ && mv fonts/ ~/.fonts && rm -rf ~/.config/helix/ && mv helix/ ~/.config/ && rm -rf ~/.config/i3/ && mv i3/ ~/.config/ && rm -rf ~/.config/lazygit/ && mv lazygit/ ~/.config/ && rm -rf ~/.config/picom/ && mv picom/ ~/.config/ && rm -rf ~/.config/polybar/ && mv polybar/ ~/.config/ && rm -rf ~/.config/rofi/ && mv rofi/ ~/.config/ && rm -rf ~/Screenshot && mkdir ~/Screenshot && rm -rf ~/.xinitrc && mv xinitrc ~/.xinitrc && rm -rf ~/.Xresources && mv Xresources ~/.Xresources && sudo rm -rf /etc/environment && sudo mv environment /etc/ && sudo rm -rf /usr/local/bin/rofi-power-menu && sudo mv bin/rofi-power-menu /usr/local/bin/ && rm -rf ~/.config/qutebrowser && mv qutebrowser/ ~/.config/ && fc-cache -fv && cd sekiro_grub_theme/ && sudo ./install.sh && echo "Hey! don't forget to run the at_least.sh."
