#!/bin/bash

FILE="paragraph.txt"

count_words() {
    wc -w < "$FILE"
}

count_lines() {
    wc -l < "$FILE"
}

lookup_text() {
    grep -o -i "$1" "$FILE" | wc -l
}

replace_text() {
    sed -i "s/$1/$2/g" "$FILE"
    echo "Replacement complete."
}

case "$1" in
    "words")
        count_words
        ;;
    "lines")
        count_lines
        ;;
    "lookup")
        if [ $# -eq 2 ]; then
            lookup_text "$2"
        else
            echo "Usage: ./strings.sh lookup <text>"
        fi
        ;;
    "replace")
        if [ $# -eq 3 ]; then
            replace_text "$2" "$3"
        else
            echo "Usage: ./strings.sh replace <text1> <text2>"
        fi
        ;;
    *)
        echo "Invalid command."
        ;;
esac
