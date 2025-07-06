#!/bin/bash

if [ $# -eq 0 ]; then
	echo "No arguments provided. Running default test command..."
	LD_LIBRARY_PATH="$PWD/src/build/lib:$LD_LIBRARY_PATH" flutter test --exclude-tags no-tdd
	exit 0;
fi

if [ $1 -eq 'full' ]; then
	echo "No arguments provided. Running default test command..."
	LD_LIBRARY_PATH="$PWD/src/build/lib:$LD_LIBRARY_PATH" flutter test
	exit 0;
fi

# --- 1. Device Selection ---

echo "Searching for connected mobile devices..."

# Run flutter devices and capture output, starting from the second line
# Use grep to filter for lines containing "(mobile)"
# Use awk to extract the second field based on '•' delimiter
DEVICE_ID=$(flutter devices | tail -n +2 | grep "(mobile)" | awk -F'•' '{print $2}' | xargs)

# Trim any leading/trailing whitespace (xargs does this, but good to be explicit)
DEVICE_ID=$(echo "$DEVICE_ID" | xargs)

# Check if a device ID was found
if [ -z "$DEVICE_ID" ]; then
  echo "No mobile device (phone/emulator) found."
  echo "Please ensure a device is connected and run 'flutter devices' to verify."
  exit 1 # Stop the script
fi

echo "Found mobile device: $DEVICE_ID"

# Define default value
ITERATIONS=1

# Loop through arguments to find --iterations
for arg in "$@"; do
  case "$arg" in
    --iterations=*)
      ITERATIONS="${arg#*=}"
      ;;
    --iterations)
      # Handle --iterations VALUE (next argument)
      if [ -n "$2" ] && [[ "$2" =~ ^[0-9]+$ ]]; then
        ITERATIONS="$2"
        shift # Consume the value argument
      else
        echo "Error: --iterations requires a numeric value."
        exit 1
      fi
      ;;
  esac
  shift # Consume the current argument
done

# --- 2. Run Integration Testing ---

echo "Running integration tests on device $DEVICE_ID..."

# Assuming this script is run from the plugin's root directory (~/workspace/boringssl_ffi/)
EXAMPLE_DIR="example"
INTEGRATION_TEST_FILE="integration_test/example_integration_test.dart"

if [ ! -d "$EXAMPLE_DIR" ]; then
  echo "Error: '$EXAMPLE_DIR' directory not found. Please ensure you are running this script from the plugin's root."
  exit 1
fi

# Navigate to the example directory and run the tests
# Using pushd/popd for cleaner directory changes
pushd "$EXAMPLE_DIR" > /dev/null # Go to example dir, suppress output
  flutter test "$INTEGRATION_TEST_FILE" -d "$DEVICE_ID" --dart-define=iterations=${ITERATIONS}
popd > /dev/null # Go back to original dir, suppress output

echo "Integration tests finished."