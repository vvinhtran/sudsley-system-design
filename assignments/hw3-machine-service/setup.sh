#!/bin/bash

# This script performs the one-time setup required to get the project running.

# Exit the script immediately if a command exits with a non-zero status.
set -e

# 0. Check if npm is installed
if ! command -v npm &> /dev/null
then
    echo "Error: npm is not installed." >&2
    echo "Please install Node.js (which includes npm) from https://nodejs.org/" >&2
    echo "After installation, please run this script again." >&2
    exit 1
fi

# 1. Install all project dependencies from package.json
echo "Installing project dependencies..."
npm install

# 2. Run the test suite to verify the setup. Until ApiHandler is implemented the tests fail
# with "Not implemented"; that still shows the project compiles and Jest runs. If Jest did not
# start, or the code failed to compile, no test runs, so the summary lacks "Tests: ... N total"
# with N above zero.
echo "Running test suite..."
set +e
output=$(npm test 2>&1)
set -e
echo "$output"
if ! grep -Eq "^Tests:.* [1-9][0-9]* total" <<< "$output"; then
    echo "Error: the test suite did not run. Check the output above and your Node.js version." >&2
    exit 1
fi
if grep -q "failed" <<< "$(grep "^Tests:" <<< "$output")"; then
    echo "Tests failing with \"Not implemented\" is expected until you complete src/handler/api.ts."
fi

echo "Setup complete. You can now work with the project."