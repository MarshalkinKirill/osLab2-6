#!/bin/bash
fileName=$(date +%F_%T)
mkdir -p ~/test && {
    echo "catalog test was created successfully" >> ~/report
    touch ~/test/"$fileName".tmp
}
ping -c 1 net_nikogo.ru || echo "$fileName : Error pinging net_nikogo.ru" >> ~/report
