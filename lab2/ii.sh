#!/bin/bash

ps ax | awk '{print $11, $2}' | grep '^/sbin' | awk '{print $2}'