#!/bin/bash
#version 1.1

if ! command -v  gnome-terminal &> /dev/null;
then
     echo -e "\e[31mYou dont have gnome-terminal app on your system\e[0m"
     echo -e "\e[36mYou can install with  -> sudo apt install gnome-terminal\e[0m"
     exit
fi

raw_app_name=$(find . -type f -name "*.java" -exec grep -l "@SpringBootApplication" {} + | cut -d'/' -f1-2)

if [ -z "$raw_app_name" ];
then
  echo -e "\e[31m I can't find any Spring boot app, Please put me in the root folder(parent) application \e[0m"
  exit
fi

function Add_number_prefix_application() {
  IFS=' '
  prefix_number=1
  readarray -t app_array <<< "$raw_app_name"
  for element in "${app_array[@]}"
  do
    result+="$prefix_number-${element#./} "
    ((++prefix_number))
  done
  echo $result
}

function Print_name_application() {
  clear
  echo -e "\e[35mI found this/these Spring App/Apps:\e[0m"
  counter=0
  for i in $1
  do
    echo -e -n "\033[32m$i\033[0m          "
    ((++counter))
    if [ "$counter" -eq 4 ];
    then
      ((counter=0))
      echo ""
    fi
  done
  echo ""
}

function Check_number_app() {
  for app in "${sequence_run_app_array[@]}";
  do
    if ! echo "$name_app_with_number" | grep -q "$app";
    then
      echo -e "\e[31m I don't have an app with this number you enter \e[0m"
      exit
    fi
  done
}

name_app_with_number=$(Add_number_prefix_application)

if [ -z "$1" ];
then
  Print_name_application "$name_app_with_number"
  echo -e -n "\e[35mwhat do you want to run\e[31m(arrange is significant):\e[0m"
  read -r sequence_run_app_variable
else
  sequence_run_app_variable=$1
fi

declare -a sequence_run_app_array=()
for (( i=0; i<${#sequence_run_app_variable}; i++));
do
  sequence_run_app_array[$((i+1))]=${sequence_run_app_variable:i:1}
done

Check_number_app

if [ -z "$2" ];
then
  echo -e -n "\e[35mhow many sleep\e[31m(seven second)\e[35m do you want?"
  read -r number_sleep
else
  number_sleep=$2
fi

sleep_counter=0
for app in "${sequence_run_app_array[@]}";
do
  name_app_to_run_digit=$(echo "$name_app_with_number" | cut -d' ' -f$app)
  name_app_to_run_slash=$(echo "$name_app_to_run_digit" | sed 's/^[^-]*-/\.\//')
  gnome-terminal --geometry=40x15 --title="$name_app_to_run_digit" -- bash -c "cd $name_app_to_run_slash; mvn spring-boot:run; exec bash"

  if [[ -n "$number_sleep" && "$sleep_counter" -lt "$number_sleep" ]] ;
  then
    sleep 7
    ((++sleep_counter))
  fi
done

echo ""
echo -e "\e[35mpraise and greeting to god mohammad and his descendants\e[0m"
echo ""