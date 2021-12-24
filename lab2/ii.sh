#!/bin/bash

ps -Ao pid,args | awk '{if ($2 ~ "^/sbin/") print $1" : "$2}' > ii.txt
