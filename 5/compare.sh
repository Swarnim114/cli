#!/bin/bash

SOURCE_DIR="source"
DEST_DIR="destination"

compare_files() {
    diff -rq "$SOURCE_DIR" "$DEST_DIR" | grep "identical" | awk -F " " '{print $4}'
}

copy_files() {
    if [ $# -eq 0 ]; then
        rsync -av --ignore-existing "$SOURCE_DIR/" "$DEST_DIR/"
    else
        find "$SOURCE_DIR" -name "*.$1" -exec cp {} "$DEST_DIR/" \;
    fi
    echo "Files copied."
}

move_files() {
    mv "$SOURCE_DIR"/* "$DEST_DIR/"
    echo "Files moved."
}

backup_files() {
    rsync -av --update "$SOURCE_DIR/" "$DEST_DIR/"
    rsync -av --update "$DEST_DIR/" "$SOURCE_DIR/"
    echo "Backup completed."
}

case "$1" in
    "")
        compare_files
        ;;
    "copy")
        if [ $# -eq 1 ]; then
            copy_files
        else
            copy_files "$2"
        fi
        ;;
    "move")
        move_files
        ;;
    "backup")
        backup_files
        ;;
    *)
        echo "Invalid command."
        ;;
esac
