#
#
if(WIN32)
  find_path(CURL_INCLUDE_DIRS curl/curl.h PATH_SUFFIXES "curl/include" )
  find_library(CURL_LIBRARIES "libcurl_imp.lib" PATH_SUFFIXES "curl/lib")
  if (EXISTS ${CURL_INCLUDE_DIRS} AND EXISTS ${CURL_LIBRARIES})
    set(CURL_FOUND True)
    get_filename_component(CURL_BIN_DIR "${CURL_INCLUDE_DIRS}/../bin" ABSOLUTE)
  endif()
endif()