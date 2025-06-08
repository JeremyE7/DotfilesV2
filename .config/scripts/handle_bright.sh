#!/usr/bin/env bash

# Verifica si se proporciona un valor de incremento y dirección
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Uso: $0 [incremento] [up|down]"
    exit 1
fi

increment=$1
direction=$2

# Obtener nombre de pantalla
screen_name=$(xrandr --listmonitors | awk 'NR==2 {print $4}')

# Obtener brillo actual
current_brightness=$(xrandr --verbose | grep -i brightness | head -n1 | awk '{print $2}')

# Límites
max_brightness=1.12
min_brightness=0.5

# Calcula nuevo brillo
if [ "$direction" == "up" ]; then
    new_brightness=$(echo "$current_brightness + $increment" | bc)
    if (( $(echo "$new_brightness > $max_brightness" | bc -l) )); then
        new_brightness=$max_brightness
    fi
elif [ "$direction" == "down" ]; then
    new_brightness=$(echo "$current_brightness - $increment" | bc)
    if (( $(echo "$new_brightness < $min_brightness" | bc -l) )); then
        new_brightness=$min_brightness
    fi
else
    echo "Dirección no válida. Usa 'up' o 'down'."
    exit 1
fi

# Aplicar nuevo brillo
xrandr --output "$screen_name" --brightness "$new_brightness"

# Cálculo porcentaje
percent=$(printf "%.0f" "$(echo "$new_brightness * 100" | bc -l)")

# Crear barrita (10 bloques)
bar=""
full_blocks=$((percent / 10))
for ((i=0; i<10; i++)); do
    if [ $i -lt $full_blocks ]; then
        bar+="█"
    else
        bar+="░"
    fi
done

# Emoji según nivel de brillo
if (( percent < 30 )); then
    emoji="🌑"
elif (( percent < 70 )); then
    emoji="🌓"
else
    emoji="🌕"
fi

# Notificación final con barra y emoji
notify-send -r 999 -u low -i display-brightness "$emoji Brillo: $percent%"
