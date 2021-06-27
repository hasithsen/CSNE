#!/usr/bin/env bash

# Compile and run simple mpi scripts (provided dependencies are available).
# Name starts with 'mpi' for easier tab completion.
# Saves a lot of time!

name="${1}"
mpiicpc -o "${name}" "${name}.c"
# rm "${name}".pbs.* # Clean old output and error files (if any) in pwd
qsub "${name}.pbs"