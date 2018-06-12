#!/bin/bash

###Initializing variables###

cam=100
spaces=0
todolist=("")
i=0
GREEN='\033[1;32m'
CYAN='\033[1;36m'
NC='\033[0m'
deleteds=0
trueln=0

###Reading todolist into todolist###

while IFS='' read -r line || [[ -n "$line" ]]; do
    echo -e "Trying to add ${GREEN}'$line'${NC}"
    sleep $(($RANDOM % 4)) #Just to make it look like there's a lot going on
    todolist[$i]="$line"
    echo "added '${todolist[$i]}' to array"
    ((i++))
    
done < "todo.txt"

((i=1))

while true; do
    if [ "${todolist[$i-1]}" = "" ] #End of to do list
    then
        break
    fi
    echo
    echo
    read -p "Have you done this?    ${todolist[$i-1]}    Enter y or n: " yn
    case $yn in

        [Yy]* ) echo "Great, removing it from the to do list"
                trueln=$((i-deleteds))
                sed -i "${trueln}d" todo.txt
                ((deleteds++));;
        [Nn]* ) echo "Get it done. Boy.";;
        * ) echo "Y or N please";;
    esac
    ((i++))
done

echo
echo
echo -e "${CYAN}Updated To Do List:${NC}"

while IFS='' read -r line || [[ -n "$line" ]]; do
    echo -e "$line"
done < "todo.txt"