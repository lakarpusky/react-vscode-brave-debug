#!/bin/bash

# Check if port 9222 is in use (Brave with debugging already running)
if lsof -i :9222 >/dev/null; then
  # If yes, open a new tab in the existing instance
  open -a "Brave.app" http://localhost:8000
else
  # If no, kill any existing Brave instances silently
  killall "Brave" 2>/dev/null || true
  # Launch Brave with remote debugging
  open -a "Brave.app" --args --remote-debugging-port=9222 http://localhost:8000 &
  # Wait 2 seconds to ensure it’s ready
  sleep 2
fi
