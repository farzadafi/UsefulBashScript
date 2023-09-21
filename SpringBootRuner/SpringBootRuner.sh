#!/bin/bash

raw_app_name=$(find . -type f -name "*.java" -exec grep -l "@SpringBootApplication" {} + | cut -d'/' -f1-2)

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
}

function Check_number_app() {
  for app in "${sequence_run_app_array[@]}";
  do
    if ! echo "$name_app_with_number" | grep -q "$app";
    then
      echo "please enter number of app, that's be :))"
      exit
    fi
  done
}

name_app_with_number=$(Add_number_prefix_application)

if [ -z "$1" ];
then
  Print_name_application "$name_app_with_number"
  read -p "what do you want to run(arrange is significant) :" sequence_run_app_variable
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
  read -p "how many sleep(five second) do you want?" number_sleep
else
  number_sleep=$2
fi

echo $number_sleep

sleep_counter=1
for app in "${sequence_run_app_array[@]}";
do
  name_app_to_run_digit=$(echo "$name_app_with_number" | cut -d' ' -f$app)
  name_app_to_run_slash=$(echo "$name_app_to_run_digit" | sed 's/^[^-]*-/\.\//')
  gnome-terminal -- bash -c "cd $name_app_to_run_slash; mvn spring-boot:run; exec bash"
  if [ "$sleep_counter" -le "$number_sleep" ] ;
  then
    sleep 5
    ((++sleep_counter))
  fi
done
