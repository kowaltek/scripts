#!/usr/bin/env bash

screen_size=$(xrandr | grep ' connected' | awk '{print $3}' | cut -f1 -d"+")

IFS=$'\n'
readarray -t <<<"$screen_size"
feh --bg-fill ~/Pictures/wallpapers/wallpaper--"${MAPFILE[0]}".jpg ~/Pictures/wallpapers/wallpaper--"${MAPFILE[1]}".jpg
