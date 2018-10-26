# CMake generated Testfile for 
# Source directory: /home/lukewen/heron_ws/src/um6
# Build directory: /home/lukewen/heron_ws/build/um6
# 
# This file includes the relevent testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
ADD_TEST(_ctest_um6_gtest_um6_test_registers "/home/lukewen/heron_ws/build/catkin_generated/env_cached.sh" "/usr/bin/python" "/opt/ros/hydro/share/catkin/cmake/test/run_tests.py" "/home/lukewen/heron_ws/build/test_results/um6/gtest-um6_test_registers.xml" "--return-code" "/home/lukewen/heron_ws/devel/lib/um6/um6_test_registers --gtest_output=xml:/home/lukewen/heron_ws/build/test_results/um6/gtest-um6_test_registers.xml")
ADD_TEST(_ctest_um6_gtest_um6_test_comms "/home/lukewen/heron_ws/build/catkin_generated/env_cached.sh" "/usr/bin/python" "/opt/ros/hydro/share/catkin/cmake/test/run_tests.py" "/home/lukewen/heron_ws/build/test_results/um6/gtest-um6_test_comms.xml" "--return-code" "/home/lukewen/heron_ws/devel/lib/um6/um6_test_comms --gtest_output=xml:/home/lukewen/heron_ws/build/test_results/um6/gtest-um6_test_comms.xml")
ADD_TEST(_ctest_um6_roslint_package "/home/lukewen/heron_ws/build/catkin_generated/env_cached.sh" "/usr/bin/python" "/opt/ros/hydro/share/catkin/cmake/test/run_tests.py" "/home/lukewen/heron_ws/build/test_results/um6/roslint-um6.xml" "--working-dir" "/home/lukewen/heron_ws/build/um6" "--return-code" "/opt/ros/hydro/share/roslint/cmake/../../../lib/roslint/test_wrapper /home/lukewen/heron_ws/build/test_results/um6/roslint-um6.xml make roslint_um6")
