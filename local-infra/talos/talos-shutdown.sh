#!/bin/bash

# Script to shut down Talos nodes
# Usage: ./talos-shutdown.sh [--timeout seconds]
# Default timeout is 5 minutes (300 seconds)

# Set default timeout (with unit)
TIMEOUT="5m"

# Parse timeout argument if provided
while [[ $# -gt 0 ]]; do
  case $1 in
    --timeout)
      # Make sure the timeout has a unit (s, m, h)
      if [[ "$2" =~ ^[0-9]+$ ]]; then
        # If it's just a number, assume seconds and add "s"
        TIMEOUT="${2}s"
      else
        TIMEOUT="$2"
      fi
      shift 2
      ;;
    --timeout=*)
      TIMEOUTVAL="${1#*=}"
      # Check if it's just a number
      if [[ "$TIMEOUTVAL" =~ ^[0-9]+$ ]]; then
        # If it's just a number, assume seconds and add "s"
        TIMEOUT="${TIMEOUTVAL}s"
      else
        TIMEOUT="$TIMEOUTVAL"
      fi
      shift
      ;;
    *)
      echo "Unknown argument: $1"
      echo "Usage: ./talos-shutdown.sh [--timeout seconds]"
      exit 1
      ;;
  esac
done

# Hardcoded list of nodes
NODES=(
  "192.168.0.11"
  "192.168.0.12"
  "192.168.0.10"
)

echo "The following nodes will be shut down:"
printf '%s\n' "${NODES[@]}"

# Prompt for confirmation
read -p "Are you sure you want to shut down these nodes? (y/n): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo "Operation cancelled."
  exit 0
fi

# Shut down each node
for NODE in "${NODES[@]}"; do
  echo "Shutting down node: $NODE"
  talosctl shutdown --timeout "$TIMEOUT" -n "$NODE"
  RESULT=$?
  if [ $RESULT -eq 0 ]; then
    echo "Shutdown command sent successfully to $NODE"
  else
    echo "Error shutting down $NODE (exit code: $RESULT)"
  fi
done

echo "Shutdown commands completed."