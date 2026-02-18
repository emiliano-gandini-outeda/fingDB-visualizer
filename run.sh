#!/bin/bash

# Start the FingDB API server
cd /home/eclipse/Documents/GitHub/fingDB
source .venv/bin/activate
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000 &
API_PID=$!

echo "API started with PID $API_PID"

# Wait for API to be ready
sleep 2

# Start a simple HTTP server for the visualizer on port 3000
cd /home/eclipse/Documents/GitHub/DB-visualizer
python3 -m http.server 3000 &
SERVER_PID=$!

echo "Visualizer server started on port 3000"

# Open the visualization in browser
xdg-open http://localhost:3000/

echo "Open http://localhost:3000/ in your browser"
echo "Press Ctrl+C to stop"

# Keep script running and cleanup on exit
trap "kill $API_PID $SERVER_PID 2>/dev/null" EXIT
wait
