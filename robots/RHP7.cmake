option(WITH_RHP7 "Build RHP7 support" ON)

if(NOT WITH_RHP7)
  return()
endif()

AddCatkinProject(
  rhp7_description
  GITHUB_PRIVATE isri-aist/rhp7_description
  GIT_TAG origin/motion-reach-ros2
  WORKSPACE data_ws
  CMAKE_ARGS ${MC_RTC_ROS_OPTION}
)

AddProject(
  mc_rhp7
  GITHUB_PRIVATE Yoshida-Lab-TUS/mc_rhp7
  GIT_TAG origin/motion-reach
  DEPENDS rhp7_description mc_rtc
  CMAKE_ARGS -DCMAKE_POLICY_VERSION_MINIMUM=3.5
)
