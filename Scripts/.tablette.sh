#!/bin/bash

# Fonction pour activer le clavier virtuel
activate_keyboard() {
    gsettings set org.gnome.desktop.a11y.applications screen-keyboard-enabled true
}

# Fonction pour désactiver le clavier virtuel
deactivate_keyboard() {
    gsettings set org.gnome.desktop.a11y.applications screen-keyboard-enabled false
}

# Fonction pour activer l'extension "screen rotate"
activate_extension() {
    gnome-extensions enable screen-rotate@shyzus.github.io
}

# Fonction pour désactiver l'extension "screen rotate"
deactivate_extension() {
    gnome-extensions disable screen-rotate@shyzus.github.io
}

# Fonction pour afficher une notification
show_notification() {
    notify-send "Mode tablette" "$1"
}

# Vérifier l'état actuel du clavier virtuel
keyboard_enabled=$(gsettings get org.gnome.desktop.a11y.applications screen-keyboard-enabled)
keyboard_enabled=${keyboard_enabled/true/true}  # normalize output for comparison

# Vérifier l'état actuel de l'extension "screen rotate"
extension_enabled=$(gnome-extensions list --enabled | grep "screen-rotate@shyzus.github.io")

# Vérifier les conditions et agir en conséquence
if [[ "$keyboard_enabled" == "true" ]] && [[ -n "$extension_enabled" ]]; then
    # Désactiver le clavier virtuel et l'extension
    deactivate_keyboard
    deactivate_extension
    show_notification "Mode tablette désactivé"
    echo "Clavier virtuel et extension désactivés."
else
    # Activer le clavier virtuel et l'extension si ils sont désactivés
    activate_keyboard
    activate_extension
    show_notification "Mode tablette activé"
    echo "Clavier virtuel et extension activés."
fi

