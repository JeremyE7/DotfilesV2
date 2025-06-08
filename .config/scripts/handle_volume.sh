#!/usr/bin/env bash

# Función para enviar notificación con barra + porcentaje
notify_volume() {
  volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+%' | head -1 | tr -d '%')
  bar=$(seq -s '─' $((volume / 5)) | sed 's/[0-9]//g') # cada "─" es 5%

  notify-send -r 9999 -h int:value:"$volume" -i audio-volume-high "Volumen"
}

# Refresca i3status si existe
refresh_i3status() {
  pkill -SIGUSR1 i3status 2>/dev/null
}

# Obtener volumen actual
get_current_volume() {
  pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+%' | head -1 | tr -d '%'
}

# Subir volumen
increase_volume() {
  current=$(get_current_volume)
  if [ "$current" -lt 100 ]; then
    pactl set-sink-volume @DEFAULT_SINK@ +5%
  fi
  notify_volume
  refresh_i3status
}

# Bajar volumen
decrease_volume() {
  pactl set-sink-volume @DEFAULT_SINK@ -5%
  notify_volume
  refresh_i3status
}

# Mute / desmuteo
toggle_mute() {
  pactl set-sink-mute @DEFAULT_SINK@ toggle
  mute_state=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
  if [ "$mute_state" = "yes" ]; then
    notify-send -r 9999 -i audio-volume-muted "🔇 Silenciado" ""
  else
    notify_volume
  fi
  refresh_i3status
}

# Mute del micrófono
toggle_mic_mute() {
  pactl set-source-mute @DEFAULT_SOURCE@ toggle
  refresh_i3status
}

# Entrada principal
case "$1" in
  increase) increase_volume ;;
  decrease) decrease_volume ;;
  toggle_mute) toggle_mute ;;
  toggle_mic_mute) toggle_mic_mute ;;
  *) echo "Uso: $0 {increase|decrease|toggle_mute|toggle_mic_mute}" ;;
esac

exit 0
