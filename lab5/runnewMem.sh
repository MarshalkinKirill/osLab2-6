#!/bin/bash
for (( i=0; i < $2; i++ )) #$1 - N, $2 - K
do
./newmem.bash $1 &
sleep 1s
done
