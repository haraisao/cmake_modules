##################################################################################################
# 
# CMake script for finding TinyXML.
# 
# Input variables:
# 
# - TinyXML_ROOT_DIR (optional): When specified, header files and libraries will be searched for in
#     ${TinyXML_ROOT_DIR}/include
#     ${TinyXML_ROOT_DIR}/libs
#   respectively, and the default CMake search order will be ignored. When unspecified, the default
#   CMake search order is used.
#   This variable can be specified either as a CMake or environment variable. If both are set,
#   preference is given to the CMake variable.
#   Use this variable for finding packages installed in a nonstandard location, or for enforcing
#   that one of multiple package installations is picked up.
# 
# 
# Cache variables (not intended to be used in CMakeLists.txt files)
# 
# - TinyXML_INCLUDE_DIR: Absolute path to package headers.
# - TinyXML_LIBRARY: Absolute path to library.
# 
# 
# Output variables:
# 
# - TinyXML_FOUND: Boolean that indicates if the package was found
# - TinyXML_INCLUDE_DIRS: Paths to the necessary header files
# - TinyXML_LIBRARIES: Package libraries
# 
# 
# Example usage:
# 
#  find_package(TinyXML)
#  if(NOT TinyXML_FOUND)
#    # Error handling
#  endif()
#  ...
#  include_directories(${TinyXML_INCLUDE_DIRS} ...)
#  ...
#  target_link_libraries(my_target ${TinyXML_LIBRARIES})
# 
##################################################################################################

# Get package location hint from environment variable (if any)
if(NOT TinyXML_ROOT_DIR AND DEFINED ENV{TinyXML_ROOT_DIR})
  set(TinyXML_ROOT_DIR "$ENV{TinyXML_ROOT_DIR}" CACHE PATH
      "TinyXML base directory location (optional, used for nonstandard installation paths)")
endif()

# Search path for nonstandard package locations
if(TinyXML_ROOT_DIR)
  set(TinyXML_INCLUDE_PATH PATHS "${TinyXML_ROOT_DIR}/include" NO_DEFAULT_PATH)
  set(TinyXML_LIBRARY_PATH PATHS "${TinyXML_ROOT_DIR}/lib"     NO_DEFAULT_PATH)
endif()

# Find headers and libraries
if(WIN32)
  find_path(TinyXML_INCLUDE_DIR NAMES tinyxml.h PATH_SUFFIXES "tinyxml/include" ${TinyXML_INCLUDE_PATH})
  find_library(TinyXML_LIBRARY  NAMES tinyxml   PATH_SUFFIXES "tinyxml/lib" ${TinyXML_LIBRARY_PATH})
else()
  find_path(TinyXML_INCLUDE_DIR NAMES tinyxml.h PATH_SUFFIXES "tinyxml" ${TinyXML_INCLUDE_PATH})
  find_library(TinyXML_LIBRARY  NAMES tinyxml   PATH_SUFFIXES "tinyxml" ${TinyXML_LIBRARY_PATH})
endif()

mark_as_advanced(TinyXML_INCLUDE_DIR
                 TinyXML_LIBRARY)

# Output variables generation
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(TinyXML DEFAULT_MSG TinyXML_LIBRARY
                                                      TinyXML_INCLUDE_DIR)

set(TinyXML_FOUND ${TINYXML_FOUND}) # Enforce case-correctness: Set appropriately cased variable...
unset(TINYXML_FOUND) # ...and unset uppercase variable generated by find_package_handle_standard_args

if(TinyXML_FOUND)
  set(TinyXML_INCLUDE_DIRS ${TinyXML_INCLUDE_DIR})
  set(TinyXML_LIBRARIES ${TinyXML_LIBRARY})
endif()
