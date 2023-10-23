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

function Check-figlet-install() {
  if ! command -v figlet &>/dev/null; then
    echo -e "\e[31mYou dont have figlet app on your system\e[0m"
    echo -e "\e[36mYou can install with  -> sudo apt install figlet\e[0m"
    exit
  fi
}

function Check-wmctrl-install() {
  if ! command -v wmctrl &>/dev/null; then
    echo -e "\e[31mYou dont have wmctrl app on your system\e[0m"
    echo -e "\e[36mYou can install with  -> sudo apt install wmctrl\e[0m"
    exit
  fi
}

function Work-time() {
  echo >/tmp/input.txt
  gnome-terminal --window -- bash -c "
    wmctrl -r :ACTIVE: -b toggle,above
    cowsay 'Work' | sed 's/^/\x1b\[31m/;s/$/\x1b\[0m/'
    read -p 'How many Time For Work: ' input
    echo \$input > /tmp/input.txt"
}

function Rest-time() {
  echo >/tmp/input.txt
  gnome-terminal --window -- bash -c "
    wmctrl -r :ACTIVE: -b toggle,above
    cowsay 'Rest' | sed 's/^/\x1b\[35m/;s/$/\x1b\[0m/'
    read -p 'How many Time For Rest: ' input
    echo \$input > /tmp/input.txt"
}

function Read-input() {
  result=$(cat /tmp/input.txt)
  while true; do
    if [[ $result =~ ^[0-9]+$ ]]; then
      break
    else
      result=$(cat /tmp/input.txt)
      sleep 1
    fi
  done
  echo $result
}

function Start_pomodoro() {
  local duration=$1
  local remaining=$((duration * 60))
  while [[ $remaining -gt 0 ]]; do
    clear
    echo -e "\e[34m"
    echo "╔══════════════════════════════════════════════╗"
    echo "║                   Pomodoro                   ║"
    echo "║                     Work                     ║"
    echo "╚══════════════════════════════════════════════╝"
    echo
    echo
    echo "Time remaining seconds:"
    figlet $remaining
    echo -e "\e[0m"
    sleep 1
    remaining=$((remaining - 1))
  done
}

function Rest-pomodoro() {
  local duration=$1
  local remaining=$((duration * 60))
  while [[ $remaining -gt 0 ]]; do
    clear
    echo -e "\e[32m"
    echo "╔══════════════════════════════════════════════╗"
    echo "║                   Pomodoro                   ║"
    echo "║                     Rest                     ║"
    echo "╚══════════════════════════════════════════════╝"
    echo
    echo
    echo "Time remaining seconds:"
    figlet $remaining
    echo -e "\e[0m"
    sleep 1
    remaining=$((remaining - 1))
  done
}

Check-gnome-terminal-install
Check-cowsay-install
Check-figlet-install
Check-wmctrl-install

while true; do
  Work-time
  input=$(Read-input)
  Start_pomodoro $input
  Rest-time
  input=$(Read-input)
  Rest-pomodoro $input
done
