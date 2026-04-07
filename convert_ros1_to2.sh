#!/bin/bash

# Script to convert all ROS1 bags in a folder to ROS2 format


# Dir without ending/trailing slash !
SRC_DIR="ros1bags"
DST_DIR="ros2bags"

# Check if source directory exists
if [ ! -d "$SRC_DIR" ]; then
    echo "Error: Source directory '$SRC_DIR' does not exist"
    exit 1
fi

# Check if source directory exists
if [ ! -d "$DST_DIR" ]; then
    echo "Error: Dest. directory '$DST_DIR' does not exist"
    exit 1
fi

# Check if rosbags-convert is available
if ! command -v rosbags-convert &> /dev/null; then
    echo "Error: rosbags-convert command not found"
    echo "Install it with: pip install rosbags"
    exit 1
fi

echo "Converting ROS1 bags from '$SRC_DIR' to '$DST_DIR'..."
echo "================================================"

# Counter for tracking progress
total=0
success=0
failed=0
skipped=0

# Iterate over all directories in ros1bags folder
for bag_file in "$SRC_DIR"/*; do
    # 1. Sanity Check: Ensure it is a file and ends in .bag
    if [[ -f "$bag_file" && "$bag_file" == *.bag ]]; then
        total=$((total + 1))
        
        # Get the filename without the extension
        bag_name=$(basename "$bag_file" .bag)
        output_folder="$DST_DIR/$bag_name"

        echo ""
        echo "[$total] Converting: $bag_name"
        echo "  Source: $bag_file"
        echo "  Output: $output_folder"

        # 2. Skip if the conversion folder already exists
        if [ -d "$output_folder" ]; then
            skipped=$((skipped + 1))
            echo "  ⊘ Skipped (already exists)"
            continue
        fi

        if rosbags-convert \
            --src "$bag_file" \
            --src-typestore ros1_noetic \
            --dst "$output_folder" \
            --dst-typestore ros2_humble; then

            success=$((success + 1))
            echo "  ✓ Success"
        else
            failed=$((failed + 1))
            echo "  ✗ Failed"
        fi
    fi
done

echo ""
echo "================================================"
echo "Conversion complete!"
echo "Total bags found: $total"
echo "Skipped (already exist): $skipped"
echo "Successfully converted: $success"
echo "Failed: $failed"

if [ $failed -gt 0 ]; then
    exit 1
fi