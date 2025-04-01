#!/bin/sh

if [ "$LOG_LEVEL" = "debug" ]; then
  echo "DEBUG MODE: Skipping setting GitHub output."
  # Simply run vnext to print debug output to STDOUT
  vnext
else
  version=$(vnext)
  echo "version=$version" >> "$GITHUB_OUTPUT"
fi