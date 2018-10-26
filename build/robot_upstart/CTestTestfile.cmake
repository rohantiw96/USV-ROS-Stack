# CMake generated Testfile for 
# Source directory: /home/lukewen/heron_ws/src/robot_upstart
# Build directory: /home/lukewen/heron_ws/build/robot_upstart
# 
# This file includes the relevent testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
ADD_TEST(_ctest_robot_upstart_roslint_package "/home/lukewen/heron_ws/build/catkin_generated/env_cached.sh" "/usr/bin/python" "/opt/ros/hydro/share/catkin/cmake/test/run_tests.py" "/home/lukewen/heron_ws/build/test_results/robot_upstart/roslint-robot_upstart.xml" "--working-dir" "/home/lukewen/heron_ws/build/robot_upstart" "--return-code" "/opt/ros/hydro/share/roslint/cmake/../../../lib/roslint/test_wrapper /home/lukewen/heron_ws/build/test_results/robot_upstart/roslint-robot_upstart.xml make roslint_robot_upstart")
ADD_TEST(_ctest_robot_upstart_nosetests_test "/home/lukewen/heron_ws/build/catkin_generated/env_cached.sh" "/usr/bin/python" "/opt/ros/hydro/share/catkin/cmake/test/run_tests.py" "/home/lukewen/heron_ws/build/test_results/robot_upstart/nosetests-test.xml" "--return-code" "/usr/bin/cmake -E make_directory /home/lukewen/heron_ws/build/test_results/robot_upstart" "/usr/bin/nosetests -P --process-timeout=60 --where=/home/lukewen/heron_ws/src/robot_upstart/test --with-xunit --xunit-file=/home/lukewen/heron_ws/build/test_results/robot_upstart/nosetests-test.xml")
