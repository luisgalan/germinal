#!/bin/bash
set -e

echo "Downloading AlphaFold-Multimer parameters..."
echo ""
echo "This will download approximately 4GB of data."
echo ""

# Create params directory if it doesn't exist
mkdir -p params

cd params

# Check if parameters already exist
if [ -d "params" ]; then
    echo "Parameters directory already exists. Skipping download."
    echo "To re-download, remove the params/params directory first."
    exit 0
fi

# Download using aria2c for faster parallel downloads
if command -v aria2c &> /dev/null; then
    echo "Using aria2c for faster download..."
    aria2c -x 16 https://storage.googleapis.com/alphafold/alphafold_params_2022-12-06.tar
else
    echo "aria2c not found, using wget..."
    echo "Install aria2 for faster downloads: sudo pacman -S aria2"
    wget https://storage.googleapis.com/alphafold/alphafold_params_2022-12-06.tar
fi

# Extract the parameters
echo ""
echo "Extracting parameters..."
tar -xf alphafold_params_2022-12-06.tar

# Clean up the tar file
echo "Cleaning up..."
rm -f alphafold_params_2022-12-06.tar

cd ..

echo ""
echo "AlphaFold parameters downloaded successfully to params/"
echo ""
