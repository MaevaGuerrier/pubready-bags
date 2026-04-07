#!/bin/bash

# Script to convert all ROS2 bags in a folder to ROS1 format


# Dir without ending/trailing slash !
SRC_DIR="ros2bags"
DST_DIR="ros1bags"

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

echo "Converting ROS2 bags from '$SRC_DIR' to '$DST_DIR'..."
echo "================================================"

# Counter for tracking progress
total=0
success=0
failed=0
skipped=0

# Iterate over all directories in ros2bags folder
for bag_dir in "$SRC_DIR"/*; do
    # Check if it's a directory rosbag2 are dir based storage containing sqlite db3 files
    if [ -d "$bag_dir" ]; then
        total=$((total + 1))
        
        # Extract the bag name (folder name without path)
        bag_name=$(basename "$bag_dir")
        
        # Define output file path
        output_file="$DST_DIR/${bag_name}.bag"
        
        echo ""
        echo "[$total] Converting: $bag_name"
        echo "  Source: $bag_dir"
        echo "  Output: $output_file"


        # We don't convert bag that are already converted
        if [ -f "$output_file" ]; then
            skipped=$((skipped + 1))
            echo "  ⊘ Skipped (already exists)"
            continue
        fi
        
        # Run rosbags-convert
        if rosbags-convert \
            --src "$bag_dir" \
            --src-typestore ros2_humble \
            --dst "$output_file" \
            --dst-typestore ros1_noetic; then
            
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