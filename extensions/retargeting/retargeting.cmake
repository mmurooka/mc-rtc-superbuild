AddProject(
  McRtcTactileSensorPlugin
  GITHUB_PRIVATE isri-aist/McRtcTactileSensorPlugin
  GIT_TAG origin/master
  DEPENDS mc_rtc MujocoTactileSensorPlugin
  CMAKE_ARGS -DENABLE_MUJOCO=ON -DENABLE_ESKIN=OFF
)

AddCatkinProject(
  RHP7MultiContactMotion
  GITHUB_PRIVATE isri-aist/RHP7MultiContactMotion
  GIT_TAG origin/motion-reach
  WORKSPACE mc_rtc_ws
  DEPENDS mc_rtc mc_mujoco
  CMAKE_ARGS -DENABLE_MUJOCO=ON
)
