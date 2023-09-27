#!/bin/bash

# Function to display a desktop notification
notify() {
  if [[ "$(uname)" == "Darwin" ]]; then
    osascript -e "display notification \"$1\" with title \"$2\""
  elif [[ "$(uname)" == "Linux" ]]; then
    notify-send -u cirical "$2" "$1"
  fi
}