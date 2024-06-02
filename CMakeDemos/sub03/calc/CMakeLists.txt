add_library(calc STATIC calc.cpp)
target_link_libraries(calc PRIVATE add sub)
target_include_directories(calc PUBLIC ./)