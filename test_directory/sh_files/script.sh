#!/bin/bash
# 2023ebcs748
read -p "Enter directory path: " dir_path
if [ ! -d "$dir_path" ]; then
    echo "Error: Directory does not exist."
    exit 1
fi

cd "$dir_path" || exit

move_file() {
    file="$1"
    ext="${file##*.}"
    subdir="${ext}_files"
    mkdir -p "$subdir"
    bash -c "exec mv \"$file\" \"$subdir/\""
}

for file in *; do
    if [ -f "$file" ]; then
        move_file "$file" &
    fi
done

wait
echo "File organization complete."

