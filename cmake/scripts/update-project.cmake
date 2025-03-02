cmake_minimum_required(VERSION 3.20)

# Skip update for non git repository
if(NOT EXISTS "${SOURCE_DIR}/.git")
  message("[SKIP] Update ${NAME}: not a git repository")
  return()
endif()

# Skip update for fixed tags
# It is technically possible to reposition a tag but we accept the risk
if(NOT GIT_TAG MATCHES "^origin/(.*)")
  message("[SKIP] Update ${NAME}: fixed to ${GIT_TAG}")
  return()
endif()

# We check that our work tree is clean and matches the desired branch

# First update the index
execute_process(
  COMMAND git update-index -q --ignore-submodules --refresh
  WORKING_DIRECTORY "${SOURCE_DIR}"
)

# Disallow unstaged changes in the working tree
execute_process(
  COMMAND git diff-files --quiet --ignore-submodules --
  RESULT_VARIABLE git_diff_err
  WORKING_DIRECTORY "${SOURCE_DIR}"
)
if(git_diff_err)
  message("[SKIP] Update ${NAME}: unstaged changes")
  return()
endif()

# Disallow uncommitted changes in the index
execute_process(
  COMMAND git diff-index --cached --quiet HEAD --ignore-submodules --
  RESULT_VARIABLE git_diff_err
  WORKING_DIRECTORY "${SOURCE_DIR}"
)
if(git_diff_err)
  message("[SKIP] Update ${NAME}: uncommited changes")
  return()
endif()


# Find the current remote branch
execute_process(
  COMMAND git rev-parse --abbrev-ref --symbolic-full-name @{u}
  RESULT_VARIABLE git_rev_parse_err
  OUTPUT_VARIABLE CURRENT_REMOTE_BRANCH
  OUTPUT_STRIP_TRAILING_WHITESPACE
  WORKING_DIRECTORY "${SOURCE_DIR}"
)

if(git_rev_parse_err OR NOT "${CURRENT_REMOTE_BRANCH}" STREQUAL "${GIT_TAG}")
  message("[SKIP] Update ${NAME}: not tracking ${GIT_TAG}")
  return()
endif()

message("Update ${NAME}")
execute_process(
  COMMAND git pull --rebase
  RESULT_VARIABLE git_pull_err
  WORKING_DIRECTORY "${SOURCE_DIR}"
)
if(git_pull_err)
  message("[ERROR] Failed to update ${NAME}")
endif()

execute_process(
  COMMAND git submodule sync
  COMMAND git submodule update --init --recursive
  WORKING_DIRECTORY "${SOURCE_DIR}"
)

execute_process(
  COMMAND git add .
  WORKING_DIRECTORY "${SOURCE_DESTINATION}"
  OUTPUT_QUIET ERROR_QUIET
)
execute_process(
  COMMAND git commit -m "[${TARGET_FOLDER}] Updated submodule"
  WORKING_DIRECTORY "${SOURCE_DESTINATION}"
  OUTPUT_QUIET ERROR_QUIET
)
