#!/bin/bash
./handler2.sh&pid=$!
./generator2.sh $pid
