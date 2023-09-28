#!/bin/bash

function Check-gnome-terminal-install() {
  if ! command -v gnome-terminal &>/dev/null; then
    echo -e "\e[31mYou dont have gnome-terminal app on your system\e[0m"
    echo -e "\e[36mYou can install with  -> sudo apt install gnome-terminal\e[0m"
    exit
  fi
}

function Check-cowsay-install() {
  if ! command -v cowsay &>/dev/null; then
    echo -e "\e[31mYou dont have cowsay app on your system\e[0m"
    echo -e "\e[36mYou can install with  -> sudo apt install cowsay\e[0m"
    exit
  fi
}

function Work-time() {
  echo >/tmp/input.txt
  gnome-terminal --tab -- bash -c "
    cowsay 'Work' | sed 's/^/\x1b\[31m/;s/$/\x1b\[0m/'
    read -p 'How many Time For Work: ' input
    echo \$input > /tmp/input.txt
    read -n 1 "
}
