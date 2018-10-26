# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "heron_msgs: 5 messages, 0 services")

set(MSG_I_FLAGS "-Iheron_msgs:/home/lukewen/heron_ws/src/heron/heron_msgs/msg;-Istd_msgs:/opt/ros/hydro/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(genlisp REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(heron_msgs_generate_messages ALL)

#
#  langs = gencpp;genlisp;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(heron_msgs
  "/home/lukewen/heron_ws/src/heron/heron_msgs/msg/Sense.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/hydro/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/heron_msgs
)
_generate_msg_cpp(heron_msgs
  "/home/lukewen/heron_ws/src/heron/heron_msgs/msg/Drive.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/heron_msgs
)
_generate_msg_cpp(heron_msgs
  "/home/lukewen/heron_ws/src/heron/heron_msgs/msg/Helm.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/heron_msgs
)
_generate_msg_cpp(heron_msgs
  "/home/lukewen/heron_ws/src/heron/heron_msgs/msg/Course.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/heron_msgs
)
_generate_msg_cpp(heron_msgs
  "/home/lukewen/heron_ws/src/heron/heron_msgs/msg/Status.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/hydro/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/heron_msgs
)

### Generating Services

### Generating Module File
_generate_module_cpp(heron_msgs
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/heron_msgs
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(heron_msgs_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(heron_msgs_generate_messages heron_msgs_generate_messages_cpp)

# target for backward compatibility
add_custom_target(heron_msgs_gencpp)
add_dependencies(heron_msgs_gencpp heron_msgs_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS heron_msgs_generate_messages_cpp)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(heron_msgs
  "/home/lukewen/heron_ws/src/heron/heron_msgs/msg/Sense.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/hydro/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/heron_msgs
)
_generate_msg_lisp(heron_msgs
  "/home/lukewen/heron_ws/src/heron/heron_msgs/msg/Drive.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/heron_msgs
)
_generate_msg_lisp(heron_msgs
  "/home/lukewen/heron_ws/src/heron/heron_msgs/msg/Helm.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/heron_msgs
)
_generate_msg_lisp(heron_msgs
  "/home/lukewen/heron_ws/src/heron/heron_msgs/msg/Course.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/heron_msgs
)
_generate_msg_lisp(heron_msgs
  "/home/lukewen/heron_ws/src/heron/heron_msgs/msg/Status.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/hydro/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/heron_msgs
)

### Generating Services

### Generating Module File
_generate_module_lisp(heron_msgs
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/heron_msgs
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(heron_msgs_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(heron_msgs_generate_messages heron_msgs_generate_messages_lisp)

# target for backward compatibility
add_custom_target(heron_msgs_genlisp)
add_dependencies(heron_msgs_genlisp heron_msgs_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS heron_msgs_generate_messages_lisp)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(heron_msgs
  "/home/lukewen/heron_ws/src/heron/heron_msgs/msg/Sense.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/hydro/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/heron_msgs
)
_generate_msg_py(heron_msgs
  "/home/lukewen/heron_ws/src/heron/heron_msgs/msg/Drive.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/heron_msgs
)
_generate_msg_py(heron_msgs
  "/home/lukewen/heron_ws/src/heron/heron_msgs/msg/Helm.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/heron_msgs
)
_generate_msg_py(heron_msgs
  "/home/lukewen/heron_ws/src/heron/heron_msgs/msg/Course.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/heron_msgs
)
_generate_msg_py(heron_msgs
  "/home/lukewen/heron_ws/src/heron/heron_msgs/msg/Status.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/hydro/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/heron_msgs
)

### Generating Services

### Generating Module File
_generate_module_py(heron_msgs
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/heron_msgs
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(heron_msgs_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(heron_msgs_generate_messages heron_msgs_generate_messages_py)

# target for backward compatibility
add_custom_target(heron_msgs_genpy)
add_dependencies(heron_msgs_genpy heron_msgs_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS heron_msgs_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/heron_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/heron_msgs
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
add_dependencies(heron_msgs_generate_messages_cpp std_msgs_generate_messages_cpp)

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/heron_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/heron_msgs
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
add_dependencies(heron_msgs_generate_messages_lisp std_msgs_generate_messages_lisp)

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/heron_msgs)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/heron_msgs\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/heron_msgs
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
add_dependencies(heron_msgs_generate_messages_py std_msgs_generate_messages_py)
