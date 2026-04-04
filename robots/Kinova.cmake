option(WITH_Kinova "Build Kinova support" OFF)
option(WITH_Kinova_Bota "Build Kinova with Bota support" OFF)

if(NOT WITH_Kinova)
  return()
endif()

if(NOT WITH_ROS_SUPPORT OR NOT ROS_IS_ROS2)
  message(FATAL_ERROR "ROS2 support is required to use the Kinova robot")
endif()

set(MC_KINOVA_DEPENDS mc_rtc ros_kortex)
if(WITH_Kinova_Bota)
  AddCatkinProject(
    bota_driver
    GITLAB_PRIVATE botasys/drivers/bota_driver_ros2
    GIT_TAG origin/main
    WORKSPACE data_ws INSTALL_DEPENDENCIES
  )

  # AddCatkinProject(
  #   soem
  #   GITHUB mathieu-celerier/soem
  #   GIT_TAG origin/foxy-devel
  #   WORKSPACE data_ws INSTALL_DEPENDENCIES
  # )

  list(APPEND MC_KINOVA_DEPENDS bota_driver)
endif()

AddCatkinProject(
  serial
  GITHUB drashutoshspace/serial
  GIT_TAG origin/main
  WORKSPACE data_ws
)

if(ROS_DISTRO STREQUAL "humble")
  AddCatkinProject(
    ros2_robotiq_gripper
    GITHUB PickNikRobotics/ros2_robotiq_gripper
    GIT_TAG 12e623212e6891a5fcc9af94d67b07e640916394
    # GIT_TAG origin/main
    DEPENDS serial
    WORKSPACE data_ws INSTALL_DEPENDENCIES
  )
else()
  AddCatkinProject(
    ros2_robotiq_gripper
    GITHUB PickNikRobotics/ros2_robotiq_gripper
    GIT_TAG 12e623212e6891a5fcc9af94d67b07e640916394
    DEPENDS serial
    WORKSPACE data_ws INSTALL_DEPENDENCIES
  )
endif()
list(APPEND MC_KINOVA_DEPENDS ros2_robotiq_gripper)

AddCatkinProject(
  ros_kortex
  GITHUB Kinovarobotics/ros2_kortex
  GIT_TAG origin/jazzy
  # GIT_TAG origin/${ROS_DISTRO}
  WORKSPACE data_ws INSTALL_DEPENDENCIES
)

AddProject(
  mc_kinova
  GITHUB mathieu-celerier/mc_kinova
  GIT_TAG origin/topic/add-genA-bota
  DEPENDS ${MC_KINOVA_DEPENDS}
)

AddProject(
  mc_kortex
  GITHUB mathieu-celerier/mc_kortex
  GIT_TAG origin/main
  DEPENDS mc_rtc ros_kortex
)
