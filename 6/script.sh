#!/bin/bash
#2023ebcs748
FILE="paragraph.txt"

# Words beginning with a vowel
grep -oE '\b[aeiouAEIOU][a-zA-Z]*\b' "$FILE" > beginning.txt

# Words ending with a vowel
grep -oE '\b[a-zA-Z]*[aeiouAEIOU]\b' "$FILE" > ending.txt

# Words that begin and end with the same letter
grep -oE '\b([a-zA-Z])[a-zA-Z]*\1\b' "$FILE" | tr '[:upper:]' '[:lower:]'
