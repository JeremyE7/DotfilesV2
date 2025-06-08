#!/bin/bash

poweroff_function() {
    notify-send "Apagando el sistema..."
    sleep 3
    shutdown now
}

reboot_function() {
    notify-send "Reiniciando el sistema..."
    sleep 3
    reboot
}

options="    Apagar\n    Reiniciar\n    Cerrar Sesión"

selected_option=$(echo -e "$options" | rofi -dmenu -i -p "Selecciona una opción:" -width 20 -lines 3 -font "CaskaydiaCove Nerd Font 10" -padding 30 -separator-style none)

case "$selected_option" in
    "    Apagar") poweroff_function ;;
    "    Reiniciar") reboot_function ;;
    "    Cerrar Sesión") i3-msg exit ;;
esac 
