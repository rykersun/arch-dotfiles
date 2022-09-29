FILE=~/.config/gtk-3.0/settings.ini

if [ -f "$FILE" ]; then
    if grep -Fxq "gtk-application-prefer-dark-theme=1" $FILE; then
        echo "ERROR! DARK MODE ALREADY ENABLED.";
    else
        echo "gtk-application-prefer-dark-theme=1" >> ~/.config/gtk-3.0/settings.ini
        echo "DONE! DARK MODE IS NOW ENABLED."
    fi
else 
    mkdir ~/.config/gtk-3.0 && touch ~/.config/gtk-3.0/settings.ini && echo "[Settings]" >> ~/.config/gtk-3.0/settings.ini && echo "gtk-application-prefer-dark-theme=1" >> ~/.config/gtk-3.0/settings.ini
    echo "DONE! DARK MODE IS NOW ENABLED."
fi
