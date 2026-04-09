# FROM img_name:tag
FROM nvidia/cuda:12.9.0-cudnn-devel-ubuntu22.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -qq -y --no-install-recommends \
    build-essential \
    cmake \
    git \
    libssl-dev \
    libusb-1.0-0-dev \
    pkg-config \
    libgtk-3-dev \
    libglfw3-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \    
    curl \	
    libusb-1.0-0 \
    udev \
    apt-transport-https \
    ca-certificates \
    swig \
    wget \
    software-properties-common \
    apt-utils \
    python3-grpcio \
    python3-scipy \
    psmisc \
    vim-gtk \ 
    libcppunit-dev \
    python3-pip \
    nano

# Add ROS 2 GPG key and Repo for Ubuntu 22.04
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu jammy main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

RUN apt-get update && \
    apt-get install -y \
    ros-humble-ros-base \
    ros-humble-ament-cmake \
    ros-humble-cv-bridge \
    ros-humble-nav-msgs \
    ros-humble-rosbag2-storage-mcap \
    python3-colcon-common-extensions \
    python3-argcomplete \
    && rm -rf /var/lib/apt/lists/*


RUN pip install --no-cache-dir --index-url https://pypi.org/simple \
    torch torchvision --extra-index-url https://download.pytorch.org/whl/cu129 \
    supervision==0.27.0.post2 \
    transformers==4.30.2 \
    open_clip_torch \
    segment-anything \
    groundingdino-py \
    sam2 \
    pyyaml \
    rospkg \
    numpy==2.2.6 \
    bagpy 


ARG CACHE_BUST=1
COPY ./setup.sh /tmp/setup.sh

RUN chmod +x /tmp/setup.sh
RUN echo "source /tmp/setup.sh" >> /root/.bashrc
ENTRYPOINT ["/tmp/setup.sh"]
CMD ["bash","-l"]