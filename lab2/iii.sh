#!/bin/bash

ps aux --sort=start_time | tail -n 6 | awk '{print $2 ": " $11}' | head -n 1