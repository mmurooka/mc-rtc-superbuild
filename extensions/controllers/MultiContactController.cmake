include(${CMAKE_CURRENT_LIST_DIR}/../controllers/BaseLineWalkingController.cmake)

AddProject(MultiContactController
  GITHUB mmurooka/MultiContactController
  GIT_TAG origin/wholebody-contact
  DEPENDS BaseLineWalkingController
  CMAKE_ARGS -DENABLE_CNOID=OFF
)
