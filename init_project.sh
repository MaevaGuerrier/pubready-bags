#!/bin/bash

#alias ano="python3 /workspace/.packages_anonymizer/anonymizer.py"

target_dir=/workspace/.packages_anonymizer

anonymizer_dir=/workspace/third_party/autoware_rosbag2_anonymizer/

# Configuration
anonymizer_url="git@github.com:MaevaGuerrier/autoware_rosbag2_anonymizer.git"
third_party_dir="/workspace/third_party"

if [ ! -d "$anonymizer_dir" ]; then
    echo "--- [1/4] Preparing Workspace ---"
    mkdir -p "$third_party_dir"
    cd "$third_party_dir" || { echo "Error: Could not enter $third_party_dir"; exit 1; }

    echo "--- [2/4] Cloning Repository ---"
    if ! git clone "$anonymizer_url"; then
        echo "Error: Failed to clone repository."
        exit 1
    fi

    cd "$anonymizer_dir" || { echo "Error: Could not enter $anonymizer_dir"; exit 1; }

    echo "--- [3/4] Downloading Weights and Configs ---"
    # List of files to download
    urls=(
        "https://dl.fbaipublicfiles.com/segment_anything_2/092824/sam2.1_hiera_small.pt"
        "https://huggingface.co/ShilongLiu/GroundingDINO/resolve/main/GroundingDINO_SwinB.cfg.py"
        "https://huggingface.co/ShilongLiu/GroundingDINO/resolve/main/groundingdino_swinb_cogcoor.pth"
        "https://github.com/autowarefoundation/autoware_rosbag2_anonymizer/releases/download/v1.0.0/yolo11x_anonymizer.pt"
        "https://github.com/autowarefoundation/autoware_rosbag2_anonymizer/releases/download/v1.0.0/yolo_config.yaml"
    )

    for url in "${urls[@]}"; do
        echo "Downloading: $(basename "$url")..."
        # --continue allows resuming, --tries handles shaky connections
        if ! wget --continue --tries=3 "$url"; then
            echo "Error: Failed to download $(basename "$url")"
            exit 1
        fi
    done

    echo "--- [4/4] Installing Package ---"
    if [ -f "setup.py" ] || [ -f "pyproject.toml" ]; then
        if ! pip3 install . --target "$target_dir"; then
            echo "Error: Pip installation failed."
            exit 1
        fi
    else
        echo "Error: No installation file (setup.py/pyproject.toml) found in $anonymizer_dir"
        exit 1
    fi

    echo "Success: Rosbag2 Anonymizer set up correctly."
else
    echo "Rosbag2 Anonymizer directory already exists at $anonymizer_dir. Skipping setup."
fi



