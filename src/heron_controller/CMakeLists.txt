cmake_minimum_required(VERSION 2.8.3)
project(heron_controller)

find_package(catkin REQUIRED COMPONENTS
  control_toolbox
  kingfisher_msgs
  sensor_msgs
  tf
  dynamic_reconfigure
)
generate_dynamic_reconfigure_options(
#   cfg/DynReconf1.cfg
    cfg/control.cfg
 )
catkin_package(
  INCLUDE_DIRS include
)


include_directories(
  include
  ${catkin_INCLUDE_DIRS}
)

## Declare a cpp executable
add_executable(${PROJECT_NAME}_node src/controller.cpp src/force_compensator)
add_dependencies(${PROJECT_NAME}_node heron_msgs_generate_messages_cpp)
target_link_libraries(${PROJECT_NAME}_node ${catkin_LIBRARIES})
set_target_properties(${PROJECT_NAME}_node
                      PROPERTIES OUTPUT_NAME controller
                      PREFIX "")
add_executable(twist_RandL src/twist_RandL.cpp)
add_dependencies(twist_RandL ${PROJECT_NAME}_gencfg)
add_dependencies(twist_RandL heron_msgs_generate_messages_cpp)
target_link_libraries(twist_RandL ${catkin_LIBRARIES})

add_executable(speed_conversion src/speed_conversion.cpp)
add_dependencies(speed_conversion ${PROJECT_NAME}_gencfg)
add_dependencies(speed_conversion heron_msgs_generate_messages_cpp)
target_link_libraries(speed_conversion ${catkin_LIBRARIES})

add_executable(twist_Helm src/twist_Helm.cpp)
add_dependencies(twist_Helm ${PROJECT_NAME}_gencfg)
add_dependencies(twist_Helm heron_msgs_generate_messages_cpp)
target_link_libraries(twist_Helm ${catkin_LIBRARIES})
#add_executable(test_linear_velocity src/test_linear_velocity.cpp)
#add_dependencies(test_linear_velocity heron_msgs_generate_messages_cpp)
#target_link_libraries(test_linear_velocity ${catkin_LIBRARIES})
# Mark executables and/or libraries for installation
install(TARGETS ${PROJECT_NAME}_node
  RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)

install(DIRECTORY launch config
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
)

## Mark cpp header files for installation
install(DIRECTORY include/${PROJECT_NAME}/
  DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
  FILES_MATCHING PATTERN "*.h"
  PATTERN ".svn" EXCLUDE
)

