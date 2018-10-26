# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "um6: 0 messages, 1 services")

set(MSG_I_FLAGS "")

# Find all generators
find_package(gencpp REQUIRED)
find_package(genlisp REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(um6_generate_messages ALL)

#
#  langs = gencpp;genlisp;genpy
#

### Section generating for lang: gencpp
### Generating Messages

### Generating Services
_generate_srv_cpp(um6
  "/home/lukewen/heron_ws/src/um6/srv/Reset.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/um6
)

### Generating Module File
_generate_module_cpp(um6
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/um6
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(um6_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(um6_generate_messages um6_generate_messages_cpp)

# target for backward compatibility
add_custom_target(um6_gencpp)
add_dependencies(um6_gencpp um6_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS um6_generate_messages_cpp)

### Section generating for lang: genlisp
### Generating Messages

### Generating Services
_generate_srv_lisp(um6
  "/home/lukewen/heron_ws/src/um6/srv/Reset.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/um6
)

### Generating Module File
_generate_module_lisp(um6
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/um6
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(um6_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(um6_generate_messages um6_generate_messages_lisp)

# target for backward compatibility
add_custom_target(um6_genlisp)
add_dependencies(um6_genlisp um6_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS um6_generate_messages_lisp)

### Section generating for lang: genpy
### Generating Messages

### Generating Services
_generate_srv_py(um6
  "/home/lukewen/heron_ws/src/um6/srv/Reset.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/um6
)

### Generating Module File
_generate_module_py(um6
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/um6
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(um6_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(um6_generate_messages um6_generate_messages_py)

# target for backward compatibility
add_custom_target(um6_genpy)
add_dependencies(um6_genpy um6_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS um6_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/um6)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/um6
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/um6)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/um6
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/um6)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/um6\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/um6
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
