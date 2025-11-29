#!/bin/bash

# Script to start the VLM demo on a remote Linux device
# with access from a Windows laptop via SSH tunnel

echo "================================================"
echo "VLM Image Captioning Demo - Remote Start"
echo "================================================"
echo ""

# Get the hostname/IP of the Linux server
HOSTNAME=$(hostname -I | awk '{print $1}')

echo "Server Information:"
echo "  Hostname/IP: $HOSTNAME"
echo ""

# Check if virtual environment exists
if [ ! -d "vision-env" ]; then
    echo "✗ Virtual environment not found!"
    echo "  Please run install.sh first"
    exit 1
fi

# Activate virtual environment
echo "Activating virtual environment..."
source vision-env/bin/activate
echo "✓ Virtual environment activated"
echo ""

# Check if main.py exists
if [ ! -f "backend/main.py" ]; then
    echo "✗ main.py not found!"
    exit 1
fi

echo "================================================"
echo "Starting VLM Demo Server..."
echo "================================================"
echo ""
echo "Server will be accessible at:"
echo "  Local:  http://localhost:8000"
echo "  Remote: http://${HOSTNAME}:8000"
echo ""
echo "For Windows laptop access via SSH tunnel:"
echo "  1. Open PowerShell or Command Prompt on your Windows laptop"
echo "  2. Run: ssh -L 8000:localhost:8000 your_username@${HOSTNAME}"
echo "  3. Then open browser to: http://localhost:8000"
echo ""
echo "Press Ctrl+C to stop the server"
echo "================================================"
echo ""

# Start the FastAPI server
python3 backend/main.py

# Note: Uvicorn will bind to 0.0.0.0:8000 which allows remote connections