#!/bin/bash

raw_app_name=$(find . -type f -name "*.java" -exec grep -l "@SpringBootApplication" {} + | cut -d'/' -f1-2)

IFS=' '
prefix_number=1
readarray -t app_array <<< "$raw_app_name"
for element in "${app_array[@]}"
do
  name_app_with_number+="$prefix_number-${element#./} "
  ((++prefix_number))
done

clear
counter=0
for i in $name_app_with_number
do
  echo -e -n "\033[32m$i\033[0m          "
  ((++counter))
  if [ "$counter" -eq 4 ];
  then
    ((counter=0))
    echo ""
  fi
done

read -p "what do you want to run(arrange is significant) :" sequence_run_app_variable
declare -a sequence_run_app_array=()

for (( i=0; i<${#sequence_run_app_variable}; i++));
do
  sequence_run_app_array[$((i+1))]=${sequence_run_app_variable:i:1}
done

for app in "${sequence_run_app_array[@]}";
do
  if ! echo "$name_app_with_number" | grep -q "$app";
  then
    echo "please enter number of app, that's be :))"
    exit
  fi
done

read -p "how many sleep(five second) do you want?" number_sleep
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