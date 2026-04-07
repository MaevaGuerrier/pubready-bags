# WIP. 

**Rosbags - Source Code Mirror**
This repository serves as the official GitHub mirror for the primary repository hosted on GitLab at https://gitlab.com/ternaris/rosbags.

# Publication ready rosbags for roboticist !

ROS2 is now the prefered ros version to use, however we provides the following:

- *Based on rosbags by [Ternaris](https://gitlab.com/ternaris/rosbags) (Apache-2.0).* We provides a ready to go python enviornment and pipeline to convert ros2bags into ros2bags.
- Publication ready bags: somoenes photobomb you bag recording, no worries you can just blured their faces with our pipeline **TODO**

# Usage WIP 

rosbags-convert \ 
--src ros2bags/{bag_name} \ 
--src-typestore ros2_humble \ 
--dst ros1bags/{bag_name}.bag \ 
--dst-typestore ros1_noetic

or 

rosbags-convert --src ros2bags/{bag_name} --src-typestore ros2_humble --dst ros1bags/{bag_name}.bag --dst-typestore ros1_noetic



# evotraj 


evo_traj bag gnm_bunker_mist_office_sharp_no_aug_trial_1.bag /laser_odometry --project_to_plane xy -p 
