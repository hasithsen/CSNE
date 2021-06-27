#!/usr/bin/env bash

# Saves a lot of time!

name="${1}"
mv "${name}" "${name}.bak"
nvcc -o "${name}" "${name}.cu"
./"${name}"
