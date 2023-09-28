#!/bin/bash

function Check-gnome-terminal-install() {
  if ! command -v gnome-terminal &>/dev/null; then
    echo -e "\e[31mYou dont have gnome-terminal app on your system\e[0m"
    echo -e "\e[36mYou can install with  -> sudo apt install gnome-terminal\e[0m"
    exit
  fi
}

