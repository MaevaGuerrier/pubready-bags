import sqlite3
import numpy as np
import matplotlib.pyplot as plt

from rosidl_runtime_py.utilities import get_message
from rclpy.serialization import deserialize_message  # only serialization, not full rclpy


def read_odometry_from_db3(db3_path, topic_name="/odom"):
    conn = sqlite3.connect(db3_path)
    cursor = conn.cursor()

    # Get topic id and type
    cursor.execute("SELECT id, type FROM topics WHERE name=?", (topic_name,))
    result = cursor.fetchone()

    if result is None:
        raise ValueError(f"Topic {topic_name} not found")

    topic_id, topic_type = result

    msg_type = get_message(topic_type)

    # Fetch all messages
    cursor.execute(
        "SELECT timestamp, data FROM messages WHERE topic_id=? ORDER BY timestamp",
        (topic_id,),
    )

    timestamps = []
    xs, ys, zs = [], [], []

    for timestamp, data in cursor.fetchall():
        msg = deserialize_message(data, msg_type)

        timestamps.append(timestamp * 1e-9)  # ns → s
        xs.append(msg.pose.pose.position.x)
        ys.append(msg.pose.pose.position.y)
        zs.append(msg.pose.pose.position.z)

    conn.close()

    return (
        np.array(timestamps),
        np.array(xs),
        np.array(ys),
        np.array(zs),
    )


def plot_xy(xs, ys):
    plt.figure()
    plt.plot(xs, ys)
    plt.xlabel("X [m]")
    plt.ylabel("Y [m]")
    plt.title("Odometry Trajectory")
    plt.axis("equal")
    plt.grid()
    plt.show()


if __name__ == "__main__":
    db3_path = "./ros2bags/cross_bunker_easy_office_no_aug_trial_1/cross_bunker_easy_office_no_aug_trial_1_bag.db3"
    topic_name = "/laser_odometry"

    t, x, y, z = read_odometry_from_db3(db3_path, topic_name)

    plot_xy(x, y)