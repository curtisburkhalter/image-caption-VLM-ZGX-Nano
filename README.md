# Vision Language Model (VLM) Image Captioning Demo

A demonstration application showcasing Vision Language Model capabilities using the ViT-GPT2 model for automatic image caption generation. This demo is designed for HP ZGX Nano sales and marketing teams to showcase AI capabilities at events or customer calls.

## Overview

This demo application allows users to upload one or two images through a web interface and receive AI-generated captions describing the content of each image. The application uses a Vision Transformer (ViT) combined with GPT-2 for image understanding and natural language generation.

## Features

- Web-based interface for easy demonstration
- Support for uploading and analyzing 1-2 images simultaneously  
- Real-time image caption generation using VLM technology
- Responsive design suitable for various display sizes
- HP branding integration

## System Requirements

- HP ZGX Nano
- Python 3.8 or higher
- pip package manager
- At least 8GB of RAM recommended for model inference
- Network connectivity for initial model download

## Directory Structure

```
vision-language-demo/
├── backend/
│   ├── main.py           # FastAPI server application
│   └── requirements.txt  # Python dependencies
├── frontend/
│   ├── index.html       # Web interface
│   └── hp_logo.png      # HP logo asset
├── models/              # Model storage directory (created during setup)
├── install.sh           # Installation script
├── start_demo_remote.sh # Remote access startup script
└── download_models.sh   # Model download script
```

## Installation

### Step 1: Clone the Repository

```bash
git clone <repository-url>
cd vision-language-demo
```

### Step 2: Run the Installation Script

```bash
chmod +x install.sh
./install.sh
```

The installation script will:
- Verify Python 3 and pip are installed
- Create a Python virtual environment named `vision-env`
- Install all required Python packages from `backend/requirements.txt`
- Create necessary directory structure  
- Move frontend files to the appropriate location
- Attempt to download models if `download_models.sh` is present

**Note:** The installation completion message shows `python3 main.py` but the correct command is `python3 backend/main.py` (as shown in the Running the Demo section below).

### Step 3: Model Setup

The demo uses the `nlpconnect/vit-gpt2-image-captioning` model which will be automatically downloaded from Hugging Face on first run. If you have custom models:

**Important for Sales Teams:** If using custom models stored on S3 or elsewhere, modify the `download_models.sh` file:
- Update the S3 bucket URL or model source location
- Ensure proper AWS credentials are configured if using S3
- Verify the model path matches what's expected in `main.py`

## Configuration Points for Sales Teams

### 1. File Path Modifications

If your directory structure differs, update these locations:

**In `main.py`:**
- Line 32: Static files directory path
  ```python
  app.mount("/static", StaticFiles(directory="frontend"), name="static")
  ```
- Line 48: Frontend HTML file path
  ```python
  with open("frontend/index.html", "r") as f:
  ```

**In `index.html`:**
- Line 134 & 141: Logo image paths
  ```html
  <img src="/static/hp_logo.png" alt="HP Logo" class="logo">
  ```

### 2. Port Configuration

Default port is 8000. To change:
- Edit `main.py` line 118:
  ```python
  uvicorn.run(app, host="0.0.0.0", port=8000)
  ```
- Update corresponding references in `start_demo_remote.sh`

### 3. Model Selection

To use a different VLM model:
- Edit `main.py` line 37:
  ```python
  image_to_text = pipeline("image-to-text", model="nlpconnect/vit-gpt2-image-captioning")
  ```
- Replace with your preferred model from Hugging Face or local path

### 4. Network Configuration
IMPORTANT: Sales and marketing teams must update the server IP address to match their demo system's IP address.

The demo is configured for remote access. When running on your demo system:

Open start_demo_remote.sh
Locate the Server IP address in the ./start_demo_remote.sh file
E.g., SERVER_IP="xxx.xxx.xx.xxx"  

Update this to your demo system's actual IP address

To find your system's IP address:

hostname -I | awk '{print $1}'

## Running the Demo

### Local Access

1. Activate the virtual environment:
   ```bash
   source vision-env/bin/activate
   ```

2. Start the application:
   ```bash
   python3 backend/main.py
   ```

3. Open a browser and navigate to: `http://localhost:8000`

### Remote Access (Preferred Method for HP ZGX Nano)
####  This will allow you to open up the web app frontend on Windows (or other device) that is not the ZGX if you are executing the start_demo_remote.sh file from your HP ZGX Nano

Use the provided remote start script:

```bash
chmod +x start_demo_remote.sh
./start_demo_remote.sh
```

This script will:
- Display the server's IP address
- Start the FastAPI server
- Provide SSH tunnel instructions for remote access

## Usage Instructions

1. **Upload Images**: Click on the upload boxes to select images from your device
   - Image 1 is required
   - Image 2 is optional

2. **Analyze**: Click the "Analyze Images" button to generate captions

3. **View Results**: Captions will appear below each uploaded image

## Troubleshooting

### Model Loading Errors

If the model fails to load:
- Verify internet connectivity for initial model download
- Check available disk space (models can be several GB)
- Ensure CUDA is properly configured if using GPU acceleration

### Port Already in Use

If port 8000 is occupied:
```bash
# Find process using port 8000
lsof -i :8000

# Kill the process if needed
kill -9 <PID>
```

### Frontend Not Loading

If you see "Frontend not found" error:
- Verify `frontend/index.html` exists
- Check file permissions
- Ensure the installation script completed successfully

## Stopping the Demo
Press `Ctrl+C` in the terminal running the demo to gracefully shutdown all services.

## Demo Tips for Sales Teams

1. **Pre-load the Model**: Start the application before the demo to ensure the model is loaded in memory

2. **Test Images**: Have a set of tested images ready that produce good captions

3. **Network Configuration**: For remote demos, test the SSH tunnel connection beforehand

4. **Backup Plan**: Keep screenshots or recorded videos as backup in case of technical issues

5. **Performance Note**: First inference may be slower as the model loads; subsequent inferences will be faster

## Support

For technical issues or questions about the HP ZGX Nano and ZGX Toolkit, reach out Curtis Burkhalter at curtis.burkhalter@hp.com

## License

This demo is provided for sales and marketing purposes
