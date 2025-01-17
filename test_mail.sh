#!/bin/bash

# Usage: ./test_mail.sh <SMTP_SERVER> <USERNAME> <PASSWORD> <FROM_EMAIL> <SUBJECT> <BODY_FILE> <RECIPIENTS_FILE>
# Example: ./test_mail.sh smtp.example.com user@example.com password sender@example.com "Hello" body.txt recipients.txt

# Validate arguments
if [ "$#" -ne 7 ]; then
    echo "Usage: $0 <SMTP_SERVER> <USERNAME> <PASSWORD> <FROM_EMAIL> <SUBJECT> <BODY_FILE> <RECIPIENTS_FILE>"
    exit 1
fi

# Assign arguments to variables
SMTP_SERVER="$1"
USERNAME="$2"
PASSWORD="$3"
FROM_EMAIL="$4"
SUBJECT="$5"
BODY_FILE="$6"
RECIPIENTS_FILE="$7"

# Check if BODY_FILE exists
if [ ! -f "$BODY_FILE" ]; then
    echo "Error: Body file '$BODY_FILE' not found!"
    exit 1
fi

# Check if RECIPIENTS_FILE exists
if [ ! -f "$RECIPIENTS_FILE" ]; then
    echo "Error: Recipients file '$RECIPIENTS_FILE' not found!"
    exit 1
fi

# Read recipients from the file and send emails
while IFS= read -r RECIPIENT || [[ -n "$RECIPIENT" ]]; do
    RECIPIENT=$(echo "$RECIPIENT" | xargs) # Trim whitespace
    if [[ -n "$RECIPIENT" ]]; then
        echo "Sending email to $RECIPIENT..."

        # Send email using SWAKS
        swaks --to "$RECIPIENT" \
              --from "$FROM_EMAIL" \
              --server "$SMTP_SERVER" \
              --port 587 \
              --auth-user "$USERNAME" \
              --auth-password "$PASSWORD" \
              --header "Subject: $SUBJECT" \
              --body "$(cat "$BODY_FILE")" \
              --tls

        # Generate a random delay between 0 and 120 seconds
        DELAY=$((RANDOM % 121))
        echo "Waiting for $DELAY seconds before the next email..."
        sleep "$DELAY"
    fi
done < "$RECIPIENTS_FILE"

echo "All emails sent."
