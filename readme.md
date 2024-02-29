`chmod +x g.sh`

`./g.sh <port>`

user 2 join:
```
nc <user1_ip> <port> | openssl enc -aes-256-cbc -pass pass:<user1_passphrase> -d | while read -r line ; do
    echo "User1: $line"
done
```
