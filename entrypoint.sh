#!/bin/sh

# Collect any extra flags passed as input
EXTRA_ARGS="$INPUT_ARGS"

if [ "$LOG_LEVEL" = "debug" ]; then
  echo "DEBUG MODE: Skipping setting GitHub output."
  # Simply run vnext to print debug output to STDOUT
  echo "Running: vnext $EXTRA_ARGS"
  vnext $EXTRA_ARGS
else
  version=$(vnext $EXTRA_ARGS)
  echo "version=$version" >> "$GITHUB_OUTPUT"
fi