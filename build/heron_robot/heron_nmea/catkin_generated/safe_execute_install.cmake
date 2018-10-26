execute_process(COMMAND "/home/lukewen/heron_ws/build/heron_robot/heron_nmea/catkin_generated/python_distutils_install.sh" RESULT_VARIABLE res)

if(NOT res EQUAL 0)
  message(FATAL_ERROR "execute_process(/home/lukewen/heron_ws/build/heron_robot/heron_nmea/catkin_generated/python_distutils_install.sh) returned error code ")
endif()
