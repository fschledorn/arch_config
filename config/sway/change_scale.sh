#!/bin/bash

monitor_name=$1

current_scale=$(swaymsg -t get_outputs | jq -r --arg name "$monitor_name" '.[] | select(.name == $name) | .scale')

echo "The current scale is: $current_scale"

if [[ "$current_scale" == "1.0" ]]; then
  echo "Scaling to 1.3"
  swaymsg output "$monitor_name" scale 1.3
else
  echo "Scaling to 1"
  swaymsg output "$monitor_name" scale 1
fi
