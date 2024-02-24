#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <port>"
    exit 1
fi

PORT=$1

PASSPHRASE=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32)

echo "Starting chat server on port $PORT..."
nc -l -p $PORT | openssl enc -aes-256-cbc -pass pass:$PASSPHRASE -d | while read -r line ; do
    echo "User2: $line"
done &

sleep 1

echo "Connecting to chat server..."
echo "Enter passphrase to establish a secure connection:"
read -s USER_PASSPHRASE

{
    while true; do
        read -r line
        echo "$line" | openssl enc -aes-256-cbc -pass pass:$USER_PASSPHRASE | nc localhost $PORT
    done
} &

trap "kill 0" EXIT

wait
