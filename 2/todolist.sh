#!/bin/bash

TODO_FILE="todo.txt"

display_tasks() {
    cat "$TODO_FILE"
}

add_task() {
    serial=$(wc -l < "$TODO_FILE")
    serial=$((serial + 1))
    echo "$serial $* 0" >> "$TODO_FILE"
    echo "Task added."
}

filter_tasks() {
    status=$1
    awk -v s="$status" '$NF == s' "$TODO_FILE"
}

mark_complete() {
    for num in "$@"; do
        if [[ $num =~ ^[1-8]$ ]]; then
            sed -i "${num}s/[0-2]$/2/" "$TODO_FILE"
        fi
    done
    echo "Tasks marked as complete."
}

delete_tasks() {
    for num in "$@"; do
        if [[ $num =~ ^[1-8]$ ]]; then
            sed -i "${num}d" "$TODO_FILE"
        fi
    done
    echo "Tasks deleted."
}

case "$1" in
    "")
        awk '$NF != 2' "$TODO_FILE"
        ;;
    "display")
        display_tasks
        ;;
    "add")
        shift
        add_task "$*"
        ;;
    "todo")
        filter_tasks 0
        ;;
    "doing")
        filter_tasks 1
        ;;
    "complete")
        filter_tasks 2
        ;;
    "mark_complete")
        shift
        if [ $# -le 8 ]; then
            mark_complete "$@"
        else
            echo "Error: Too many arguments. Maximum 8 allowed."
        fi
        ;;
    "delete")
        shift
        if [ $# -le 8 ]; then
            delete_tasks "$@"
        else
            echo "Error: Too many arguments. Maximum 8 allowed."
        fi
        ;;
    *)
        echo "Error: Invalid command."
        ;;
esac
