# Download a file to the given file and error immediately if the download fails
function(DownloadFile URL DESTINATION EXPECTED_SHA256)
  set(MAX_ATTEMPTS 5)
  set(ATTEMPT_I 1)
  while(${ATTEMPT_I} LESS_EQUAL ${MAX_ATTEMPTS})
    file(DOWNLOAD "${URL}" "${DESTINATION}" SHOW_PROGRESS STATUS DOWNLOAD_STATUS LOG DOWNLOAD_LOG)
    list(GET DOWNLOAD_STATUS 0 STATUS_CODE)
    if(${STATUS_CODE} EQUAL 0)
      file(SHA256 "${DESTINATION}" DOWNLOAD_HASH)
      if("${DOWNLOAD_HASH}" STREQUAL "${EXPECTED_SHA256}")
        break()
      else()
        message("Missmatched SHA256, expected ${EXPECTED_SHA256} but got ${DOWNLOAD_HASH}")
      endif()
    endif()
    file(REMOVE "${DESTINATION}")
    list(GET DOWNLOAD_STATUS 1 ERROR_MESSAGE)
    math(EXPR ATTEMPT_I "${ATTEMPT_I} + 1")
    if(${ATTEMPT_I} LESS ${MAX_ATTEMPTS})
      message("Download failed, attempt ${ATTEMPT_I} out of ${MAX_ATTEMPTS}")
      message("Failure message: ${ERROR_MESSAGE}")
    else()
      message("Download failed ${MAX_ATTEMPTS} times")
      message("Final download log:")
      message("${DOWNLOAD_LOG}")
      message(FATAL_ERROR "Download failed, see logs above")
    endif()
  endwhile()
endfunction()
