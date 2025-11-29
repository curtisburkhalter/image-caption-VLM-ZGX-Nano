#!/bin/bash

# Installation script for VLM Image Captioning Demo
# This script sets up the Python environment and installs all dependencies

echo "================================================"
echo "VLM Image Captioning Demo - Installation"
echo "================================================"
echo ""

# Check if Python 3 is installed
if ! command -v python3 &> /dev/null; then
    echo "✗ Python 3 is not installed. Please install Python 3.8 or higher."
    exit 1
fi

echo "✓ Python 3 found: $(python3 --version)"
echo ""

# Check if pip is installed
if ! command -v pip3 &> /dev/null; then
    echo "✗ pip3 is not installed. Please install pip."
    exit 1
fi

echo "✓ pip3 found"
echo ""

# Create a virtual environment (optional but recommended)
echo "Creating Python virtual environment..."
if [ ! -d "vision-env" ]; then
    python3 -m venv vision-env
    echo "✓ Virtual environment created"
else
    echo "✓ Virtual environment already exists"
fi
echo ""

# Activate virtual environment
echo "Activating virtual environment..."
source vision-env/bin/activate
echo "✓ Virtual environment activated"
echo ""

# Upgrade pip
echo "Upgrading pip..."
pip install --upgrade pip
echo ""

# Install required packages
echo "Installing required Python packages..."
echo "This may take several minutes..."
echo ""
pip install -r backend/requirements.txt

if [ $? -eq 0 ]; then
    echo ""
    echo "✓ All packages installed successfully"
else
    echo ""
    echo "✗ Package installation failed"
    exit 1
fi
echo ""

# Create necessary directories
echo "Creating directory structure..."
mkdir -p frontend
mkdir -p models
echo "✓ Directories created"
echo ""

# Move frontend files to frontend directory
echo "Setting up frontend files..."
if [ -f "index.html" ]; then
    mv index.html frontend/
    echo "✓ Moved index.html to frontend/"
fi

if [ -f "hp_logo.png" ]; then
    mv hp_logo.png frontend/
    echo "✓ Moved hp_logo.png to frontend/"
fi
echo ""

# Download models (if needed)
echo "Setting up models..."
if [ -f "download_models.sh" ]; then
    bash download_models.sh
fi
echo ""

echo "================================================"
echo "Installation Complete!"
echo "================================================"
echo ""
echo "To start the demo:"
echo "  1. Activate the virtual environment: source vision-env/bin/activate"
echo "  2. Run: python3 main.py"
echo "  3. Open browser to: http://localhost:8000"
echo ""
echo "For remote access from Windows laptop (PREFERRED METHOD):"
echo "  Run: ./start_demo_remote.sh"
echo ""
echo "================================================"
