#!/bin/sh

# Collect any extra flags passed as input
EXTRA_ARGS="$INPUT_ARGS"

if [ "$LOG_LEVEL" = "debug" ]; then
  echo "DEBUG MODE: Skipping setting GitHub output."
  # Simply run vnext to print debug output to STDOUT
  echo "Running: vnext $EXTRA_ARGS"
  vnext $EXTRA_ARGS
else
  result=$(vnext $EXTRA_ARGS)
  
  # Check if the --changelog flag is present in the arguments
  if echo "$EXTRA_ARGS" | grep -q -- "--changelog"; then
    echo "changelog=$result" >> "$GITHUB_OUTPUT"
  else
    echo "version=$result" >> "$GITHUB_OUTPUT"
  fi
fi