#!/bin/bash

mkfifo pipe
./5handler.sh&./5generator.sh
rm pipe
