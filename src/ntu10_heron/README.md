## A repository for the NTU10 Heron

Edit `/etc/ros/setup.bash` to match the provided etc_ros_setup.bash.bak.
Copy the launch files into the upstart path using:
`sudo cp ~/catkin_ws/src/ntu10_heron/launch/* /etc/ros/indigo/ros.d/`
Onced edited, restart the ros service using `sudo service ros restart`
