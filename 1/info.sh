#!/bin/bash

if [ $# -eq 0 ]; then
    while IFS=' ' read -r fruit vitamin price quantity; do
        total=$((price * quantity))
        echo "$fruit $total"
    done < fruits.txt
elif [ $# -eq 1 ]; then
    if [[ $1 =~ ^[A-Z]$ ]]; then
        total_price=0
        while IFS=' ' read -r fruit vitamin price quantity; do
            if [ "$vitamin" == "$1" ]; then
                echo "$fruit"
                total_price=$((total_price + price * quantity))
            fi
        done < fruits.txt
        echo $total_price
    elif [[ $1 =~ ^[0-9]+$ ]]; then
        while IFS=' ' read -r fruit vitamin price quantity; do
            if [ $price -le $1 ]; then
                echo "$fruit"
            fi
        done < fruits.txt
    else
        while IFS=' ' read -r fruit vitamin price quantity; do
            if [ "${fruit,,}" == "${1,,}" ]; then
                echo "$vitamin $price"
                break
            fi
        done < fruits.txt
    fi
else
    echo "Error: Too many arguments"
fi
