#!/usr/bin/env bash

# Saves a lot of time!

name="${1}"
gcc -o "${name}" "${name}.c" -lm -Wall -g
./"${name}"