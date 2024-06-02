cmake_minimum_required(VERSION 3.25)
project(sub03)
add_subdirectory(common)
add_subdirectory(add)
add_subdirectory(sub)
add_subdirectory(calc)

add_executable(sub03 main.cpp)
target_link_libraries(sub03 calc)