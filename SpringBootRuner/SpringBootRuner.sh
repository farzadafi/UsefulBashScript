#!/bin/bash

files=$(find . -type f -name "*.java" -exec grep -l "@SpringBootApplication" {} + | cut -d'/' -f1-2)

first="./config-sever"
second="./eureka-server"
third="./gateway-server"

echo $files

for file in $files;
do
    if [[ $file == $first ]]
    then
        name=$file
        files="${files//$name/}"
        gnome-terminal -- bash -c "cd $file; mvn spring-boot:run; exec bash"

    fi
done

sleep 5

for file in $files;
do
    if [[ $file == $second ]]
    then
        name=$file
        files="${files//$name/}"
        gnome-terminal -- bash -c "cd $file; mvn spring-boot:run; exec bash"

    fi
done

sleep 5

for file in $files;
do
    if [[ $file == $third ]]
    then
        name=$file
        files="${files//$name/}"
        gnome-terminal -- bash -c "cd $file; mvn spring-boot:run; exec bash"

    fi
done

sleep 5

for file in $files;
do
    gnome-terminal -- bash -c "cd $file; mvn spring-boot:run; exec bash"
done

echo $files