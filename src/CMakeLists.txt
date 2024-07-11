# Set the output directory for libraries
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY
  "${CMAKE_BINARY_DIR}/libs")

# Set main executable source files
set("${PROJECT_NAME}_SRC"
  dir-handler.c
  fancy-text.c
  history.c
  oawp-conf.c
  oawp-gui.c
)

add_executable(${PROJECT_NAME}
  "${${PROJECT_NAME}_SRC}")

set(include_dirs
  "${PROJECT_SOURCE_DIR}/include"
  "${PROJECT_BINARY_DIR}/include"
)

#foreach(target
#  "${PROJECT_NAME}"
#  "${PROJECT_NAME}_<EXAMPLE>"
#)
#  target_include_directories(${target} PRIVATE ${include_dirs})
#endforeach()

# Set the output directory for executables
set(EXECUTABLE_OUTPUT_PATH
  "${CMAKE_BINARY_DIR}/build")
