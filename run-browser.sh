#!/bin/bash

BROWSER_NAME="Brave Browser"
DEBUG_PORT=9222
DEBUG_FLAG="--remote-debugging-port=$DEBUG_PORT"
SESSION_FLAG="--restore-last-session"
SERVER_URL="http://localhost:8000"

# Helper function to check if Brave is running at all
is_brave_running() {
  pgrep -x "$BROWSER_NAME" >/dev/null
}

# Helper function to check if Brave is running in debug mode
is_brave_debug_running() {
  lsof -i :$DEBUG_PORT >/dev/null
}

# Helper function to close any existing localhost tab in a Brave debug session
# It can be updated to use (jq) lib -but need to be installed via brew first
close_existing_localhost_tab() {
  # Fetch the list of open tabs from Brave's remote debugging API
  TABS_JSON=$(curl -s http://localhost:$DEBUG_PORT/json)

  # Loop each line of the JSON response
  echo "$TABS_JSON" | while IFS= read -r line; do
    # Check if the current line contains a localhost URL
    if [[ $line == *"\"url\":\"$SERVER_URL"* ]]; then
      # Extract the previous line which contains the tab ID
      ID=$(echo "$P_LINE" | grep -o '"id":"[^"]*"' | cut -d '"' -f4)
      # If a valid ID is found, close that tab using Brave's API
      if [[ -n $ID ]]; then
        curl -s "http://localhost:$DEBUG_PORT/json/close/$ID" >/dev/null
      fi
    fi
    P_LINE=$line
  done
}

# Check if port 9222 is in use (Brave with debugging already running)
if is_brave_debug_running; then
  # Close any existing localhost tab before opening a new one
  close_existing_localhost_tab
  # Open a new tab in the existing instance
  open -a "$BROWSER_NAME.app" "$SERVER_URL"
elif is_brave_running; then
  # Brave not running in debug mode, restart it with session restore
  osascript -e "tell application \"$BROWSER_NAME\" to quit saving yes"
  sleep 2 # Wait 2 seconds for Brave to fully close
  # Restart Brave with debug mode enabled, restore last session (tabs), and open localhost
  open -a "$BROWSER_NAME.app" --args $DEBUG_FLAG $SESSION_FLAG "$SERVER_URL" &
  sleep 2 # Wait 2 seconds to ensure Brave has time to initialize
else
  # Launch Brave with remote debugging enabled and open localhost
  open -a "$BROWSER_NAME.app" --args $DEBUG_FLAG "$SERVER_URL" &
  sleep 2 # Wait 2 seconds to ensure Brave has time to initialize before continuing
fi
