#!/bin/bash

# Verifica si se proporciona un valor de incremento y dirección
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Uso: $0 [incrementcao] [direccion: up o down]"
    exit 1
fi

# Define el incremento y la dirección
increment=$1
direction=$2

# Obtén el nombre de la pantalla
screen_name=$(xrandr --listmonitors | awk 'NR==2 {print $4}')

# Límite mínimo y máximo de brillo
min_brightness=0.1
max_brightness=1.0

# Función para notificar el brillo actual con barra
notify_brightness() {
    echo "xd"
  brightness=$(xrandr --verbose | grep -i brightness | awk '{print $2}')
  brightness_percent=$(echo "$brightness * 100" | bc)
  bar=$(seq -s '─' $((brightness_percent / 5)) | sed 's/[0-9]//g') # Cada "─" es 5%

  notify-send -r 9999 -h int:value:"$brightness_percent" -i display-brightness-high "Brillo" "${bar} ${brightness_percent}%"
  echo "xd"
}

# Ajusta el brillo con xrandr
if [ "$direction" == "up" ]; then
    brightness_aux=$(xrandr --verbose | grep -i brightness | awk '{print int($2 * 100)}')
    if [ $brightness_aux -ge 100 ]; then
        exit 0
    fi
    new_brightness=$(awk "BEGIN {print $(xrandr --verbose | grep -m 1 -i brightness | awk '{print $2}') + $increment}")
    if (( $(echo "$new_brightness > $max_brightness" | bc -l) )); then
        new_brightness=$max_brightness
    fi
    xrandr --output "$screen_name" --brightness "$new_brightness"
else
    brightness_aux=$(xrandr --verbose | grep -i brightness | awk '{print int($2 * 100)}')
    if [ $brightness_aux -le 10 ]; then
        exit 0
    fi
    new_brightness=$(awk "BEGIN {print $(xrandr --verbose | grep -m 1 -i brightness | awk '{print $2}') - $increment}")
    if (( $(echo "$new_brightness < $min_brightness" | bc -l) )); then
        new_brightness=$min_brightness
    fi
    xrandr --output "$screen_name" --brightness "$new_brightness"
fi

# Muestra la notificación del nuevo brillo
notify_brightness
echo "xd"
exit 0
