#!/bin/bash

EMAIL_FILE="emails.txt"
VALID_EMAIL_FILE="valid_emails.txt"

add_email() {
    read -p "Enter email address: " email
    echo "$email" >> "$EMAIL_FILE"
    echo "Email added."
}

get_valid_emails() {
    grep -E '^[A-Za-z0-9]+@[A-Za-z]+\.com$' "$EMAIL_FILE" > "$VALID_EMAIL_FILE"
    echo "Valid emails have been saved to $VALID_EMAIL_FILE"
}

while true; do
    echo "1. Add email"
    echo "2. Get valid emails"
    echo "3. Exit"
    read -p "Enter your choice (1-3): " choice

    case $choice in
        1) add_email ;;
        2) get_valid_emails ;;
        3) exit 0 ;;
        *) echo "Invalid choice. Please try again." ;;
    esac
    echo
done
