include(${CMAKE_CURRENT_LIST_DIR}/../utils/GTest.cmake)

set(QP_SOLVER_COLLECTION_DEPENDS
  eigen-qld
  eigen-quadprog
)
if(TARGET googletest)
  list(APPEND QP_SOLVER_COLLECTION_DEPENDS googletest)
endif()

AddProject(QpSolverCollection
  GITHUB isri-aist/QpSolverCollection
  GIT_TAG origin/master
  CMAKE_ARGS -DDEFAULT_ENABLE_ALL=OFF -DENABLE_QLD=ON -DENABLE_QUADPROG=ON -DSKIP_PRIVATE_SOLVER_TEST=ON
  DEPENDS ${QP_SOLVER_COLLECTION_DEPENDS}
)
