#!/bin/bash

ps aux | awk '{if ($1 == "User") print}' | wc -l
ps aux | awk '$1 == "User"' | awk '{print $2, $11}' 