include(${CMAKE_CURRENT_LIST_DIR}/../simulation/MuJoCo.cmake)

AptInstall(libxrandr-dev libxinerama-dev libxcursor-dev libxi-dev libglew-dev)

AddProject(mc_mujoco
  GITHUB rohanpsingh/mc_mujoco
  GIT_TAG origin/main
  CMAKE_ARGS -DMUJOCO_ROOT_DIR=${MUJOCO_ROOT_DIR}
  DEPENDS mc_rtc
)

set(MC_RTC_WS_PREFIX_FILE "${PROJECT_BINARY_DIR}/catkin-stamps/cmake-prefix.cmake")
if(EXISTS "${MC_RTC_WS_PREFIX_FILE}")
  string(REPLACE " " "\\ " MUJOCO_ROOT_DIR_ESCAPED "${MUJOCO_ROOT_DIR}")
  file(APPEND "${MC_RTC_WS_PREFIX_FILE}" " MUJOCO_ROOT_DIR=${MUJOCO_ROOT_DIR_ESCAPED}")
endif()

AddCatkinProject(
  MujocoRosUtils
  GITHUB isri-aist/MujocoRosUtils.git
  GIT_TAG origin/mujoco-3.0.0
  WORKSPACE mc_rtc_ws
  DEPENDS mc_mujoco
)

AddCatkinProject(
  MujocoTactileSensorPlugin
  GITHUB isri-aist/MujocoTactileSensorPlugin.git
  GIT_TAG origin/mujoco-3.0.0
  WORKSPACE mc_rtc_ws
  DEPENDS mc_mujoco
)

if(WITH_HRP5)
  AddProject(hrp5p_mj_description
    GITHUB_PRIVATE isri-aist/hrp5p_mj_description
    GIT_TAG origin/main
    DEPENDS mc_mujoco
  )
endif()

if(WITH_HRP4CR)
  AddProject(hrp4cr_mj_description
    GITHUB_PRIVATE isri-aist/hrp4cr_mj_description
    GIT_TAG origin/main
    DEPENDS mc_mujoco
  )
endif()

if(WITH_HRP4)
  AddProject(hrp4_mj_description
    GITE mc-hrp4/hrp4_mj_description
    GIT_TAG origin/master
    DEPENDS mc_mujoco hrp4_description
  )
endif()

if(WITH_RHPS1)
  AddProject(rhps1_mj_description
    GITHUB_PRIVATE isri-aist/rhps1_mj_description
    GIT_TAG origin/master
    DEPENDS mc_mujoco rhps1_description
  )
endif()

if(WITH_RHP7)
  AddProject(rhp7_mj_description
    GITHUB_PRIVATE Yoshida-Lab-TUS/rhp7_mj_description
    GIT_TAG origin/motion-reach
    DEPENDS mc_mujoco rhp7_description
  )
endif()

if(WITH_HUMAN)
  AddProject(human_mj_description
    GITHUB Hugo-L3174/human_mj_description
    GIT_TAG origin/main
    DEPENDS mc_mujoco human_description
  )
endif()
