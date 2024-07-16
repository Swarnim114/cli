#!/bin/bash

DATA_FILE="data.txt"

add_record() {
    echo "Enter student details:"
    read -p "Roll number (4 digits): " roll
    read -p "Name: " name
    read -p "Marks in History (0-100): " history
    read -p "Marks in Geography (0-100): " geography
    read -p "Marks in Civics (0-100): " civics

    echo "$roll $name $history $geography $civics" >> "$DATA_FILE"
    echo "Record added successfully."
}

print_passing_students() {
    awk '$3 >= 33 && $4 >= 33 && $5 >= 33 {print $0}' "$DATA_FILE"
}

print_divisions() {
    awk '{
        total = $3 + $4 + $5;
        avg = total / 3;
        if ($3 >= 33 && $4 >= 33 && $5 >= 33) {
            if (avg >= 75) div = "Ist";
            else if (avg >= 60) div = "IInd";
            else if (avg >= 33) div = "IIIrd";
            else div = "Fail";
        } else {
            div = "Fail";
        }
        printf "%s %s %s\n", $1, $2, div;
    }' "$DATA_FILE"
}

delete_record() {
    read -p "Enter roll number to delete: " roll
    sed -i "/^$roll /d" "$DATA_FILE"
    echo "Record deleted (if found)."
}

while true; do
    echo "1. Add a student record"
    echo "2. Print list of passing students"
    echo "3. Print list of students with divisions"
    echo "4. Delete a student record"
    echo "5. Exit"
    read -p "Enter your choice (1-5): " choice

    case $choice in
        1) add_record ;;
        2) print_passing_students ;;
        3) print_divisions ;;
        4) delete_record ;;
        5) exit 0 ;;
        *) echo "Invalid choice. Please try again." ;;
    esac
    echo
done
