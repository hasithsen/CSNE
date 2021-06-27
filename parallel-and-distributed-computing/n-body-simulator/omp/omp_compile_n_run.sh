#!/usr/bin/env bash

# Saves a lot of time!

name="${1}"
gcc -o "${name}" "${name}.c" -fopenmp -lm -Wall -g
./"${name}"