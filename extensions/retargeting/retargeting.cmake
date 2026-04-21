AddProject(
  McRtcTactileSensorPlugin
  GITHUB isri-aist/McRtcTactileSensorPlugin
  GIT_TAG origin/master
  DEPENDS mc_rtc
  CMAKE_ARGS -DENABLE_MUJOCO=ON
)

AddCatkinProject(
  RHP7MultiContactMotion
  GITHUB isri-aist/RHP7MultiContactMotion
  GIT_TAG origin/motion-reach
  WORKSPACE mc_rtc_ws
  DEPENDS mc_rtc
  CMAKE_ARGS -DENABLE_MUJOCO=ON
)
