#!/bin/sh
# Call the vnext binary and capture its output
version=$(vnext)

# Write the computed version to GITHUB_OUTPUT in the expected format
echo "version=$version" >> $GITHUB_OUTPUT
