#!/bin/bash
./6handler.sh&pid=$!
./6generator.sh $pid
