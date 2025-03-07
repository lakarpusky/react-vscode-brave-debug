#!/bin/bash

# Helper function to close any existing localhost tab in a Brave debug session
# It can be updated to use (jq) lib -but need to be installed via brew first
close_existing_localhost_tab() {
  # Fetch the list of open tabs from Brave's remote debugging API
  TABS_JSON=$(curl -s http://localhost:9222/json)

  # Loop each line of the JSON response
  echo "$TABS_JSON" | while IFS= read -r line; do
    # Check if the current line contains a localhost URL
    if [[ $line == *'"url":"http://localhost:8000'* ]]; then
      # Extract the previous line which contains the tab ID
      ID=$(echo "$P_LINE" | grep -o '"id":"[^"]*"' | cut -d '"' -f4)
      # If a valid ID is found, close that tab using Brave's API
      if [[ -n $ID ]]; then
        curl -s "http://localhost:9222/json/close/$ID" >/dev/null
      fi
    fi
    P_LINE=$line
  done
}

# Check if port 9222 is in use (Brave with debugging already running)
if lsof -i :9222 >/dev/null; then
  # Close any existing localhost tab before opening a new one
  close_existing_localhost_tab
  # Open a new tab in the existing instance
  open -a "Brave.app" http://localhost:8000
else
  # Check if Brave is running at all
  if pgrep -x "Brave Browser" >/dev/null; then
    # If no, kill any existing Brave instances silently
    killall "Brave Browser" 2>/dev/null
    sleep 1
  fi

  # Launch Brave with remote debugging enabled and open localhost
  open -a "Brave.app" --args --remote-debugging-port=9222 http://localhost:8000 &
  sleep 2 # Wait 2 seconds to ensure Brave has time to initialize before continuing
fi
