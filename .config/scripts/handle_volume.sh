#!/usr/bin/env bash

MAX_VOLUME=140
NOTIFY_ID=9999

# Función para obtener el volumen actual
get_current_volume() {
  pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+(?=%)' | head -1
}

# Función para saber si está muteado
is_muted() {
  pactl get-sink-mute @DEFAULT_SINK@ | grep -q 'yes'
}

# Función para mostrar la notificación
send_notification() {
  local vol=$1
  local icon

  if is_muted; then
    icon="🔇"
    notify-send -r $NOTIFY_ID "$icon MUTE"
  else
    if [ "$vol" -eq 0 ]; then
      icon="🔈"
    elif [ "$vol" -lt 50 ]; then
      icon="🔉"
    else
      icon="🔊"
    fi
    notify-send -r $NOTIFY_ID "$icon ${vol}%"
  fi
}

increase_volume() {
  local vol=$(get_current_volume)
  if [ "$vol" -ge $MAX_VOLUME ]; then
    send_notification "$vol"
    exit 0
  fi
  pactl set-sink-volume @DEFAULT_SINK@ +5%
  send_notification "$(get_current_volume)"
}

decrease_volume() {
  pactl set-sink-volume @DEFAULT_SINK@ -5%
  send_notification "$(get_current_volume)"
}

toggle_mute() {
  pactl set-sink-mute @DEFAULT_SINK@ toggle
  send_notification "$(get_current_volume)"
}

toggle_mic_mute() {
  pactl set-source-mute @DEFAULT_SOURCE@ toggle
  muted=$(pactl get-source-mute @DEFAULT_SOURCE@ | grep -q 'yes' && echo "🎙️ OFF" || echo "🎙️ ON")
  notify-send -r $NOTIFY_ID "$muted
