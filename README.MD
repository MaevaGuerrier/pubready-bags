# 📦 pubready-bags

> **Convert, clean, and publish your ROS bags PUBLICATION READY.**

A Python pipeline built on top of [rosbags by Ternaris](https://gitlab.com/ternaris/rosbags) that helps roboticists prepare their bag recordings for public release — from format conversion to privacy-safe anonymization.

---

## ✨ Features

| Feature | Status |
|---|---|
| 🔄 Convert ROS 2 bags → ROS 1 bags  | ✅ Ready |
| 🔄 Convert ROS 1 bags → ROS 2 bags  | ✅ Ready |
| 🙈 Blur human faces for publication | 🚧 Coming soon |
| 🖥️ Visualizer in your terminal      | 🚧 Coming soon |

---

## 🚀 Getting Started

> **Prerequisites:** Python 3.8+

```bash
# Clone the repository
git clone https://github.com/MaevaGuerrier/pubready-bags.git
cd pubready-bags

# Create and activate a virtual environment
python -m venv rosbag2_to1
source rosbag2_to1/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt
```

---

## 🔄 ROS 2 → ROS 1 Conversion

This pipeline is intended as a migration helper for teams that have not yet transitioned away from ROS 1. [ROS 2](https://github.com/ros2) is the only actively supported version.
Place the ROS2 bags inside the folder **ros2bags**

```
./convert_ros2_to1.sh
---

## 🔄 ROS 2 → ROS 1 Conversion

You want to use existing datasets that are ros1 based but your pipelines are ROS2 based?
Just place the ROS1 bagfiles under **ros1bags** folder and run the following:

```
./convert_ros1_to2.sh
---

## 🙈 Face Anonymization *(coming soon)*

Did someone photobomb your bag recording? No worries.

The anonymization pipeline will automatically detect and blur human faces in image topics, making your bags safe to share publicly and compliant with privacy regulations.

```bash
# Coming soon
python anonymize.py path/to/your/ros2bag
```

---

## 📁 Project Structure WIP

---

## ⚖️ License & Attribution

This project builds upon **[rosbags](https://gitlab.com/ternaris/rosbags)** by [Ternaris](https://gitlab.com/ternaris), which is licensed under the **Apache License 2.0**.

In accordance with Apache-2.0:
- The original copyright notice and license are preserved in [`LICENSES/Apache-2.0.txt`](./LICENSES/Apache-2.0.txt)
- Modifications made in this repository are documented in [`CHANGES.rst`](./CHANGES.rst)

Additional licenses used in the original rosbags codebase:
- Documentation (`.rst` files): **CC-BY-SA-4.0** © 2016–2025 Ternaris
- Configuration files: **CC0-1.0** © 2016–2025 Ternaris

New code contributed in this repository is released under **Apache-2.0** © Maeva Guerrier.

---

## 🙏 Acknowledgements

A big thank you to **[Ternaris](https://gitlab.com/ternaris)** for building and open-sourcing [rosbags](https://gitlab.com/ternaris/rosbags) — Pure Python library to read, modify, convert, and write rosbag files.

---

*🚧 This project is a work in progress. Contributions and feedback are welcome!*