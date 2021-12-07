#!/bin/bash

ps -eo pid,command | grep -E "/sbin/" > ii.txt
