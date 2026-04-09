#!/bin/bash
# source ~/.bashrc
# source 
target_dir=/workspace/.packages_anonymizer
export PYTHONPATH=${target_dir}:$PYTHONPATH
source /opt/ros/humble/setup.bash

exec "$@"