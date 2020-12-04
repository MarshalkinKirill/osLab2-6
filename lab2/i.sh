#!/bin/bash

ps aux | awk '{if ($1 == "PC") print}' | wc -l
ps aux | awk '{if ($1 == "PC") print $2" : "$11}'
