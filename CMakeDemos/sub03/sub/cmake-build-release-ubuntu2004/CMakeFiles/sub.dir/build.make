# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.25

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Produce verbose output by default.
VERBOSE = 1

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/sgt/CPlus/Demo01/sub03/sub

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/sgt/CPlus/Demo01/sub03/sub/cmake-build-release-ubuntu2004

# Include any dependencies generated for this target.
include CMakeFiles/sub.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/sub.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/sub.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/sub.dir/flags.make

CMakeFiles/sub.dir/sub.o: CMakeFiles/sub.dir/flags.make
CMakeFiles/sub.dir/sub.o: /home/sgt/CPlus/Demo01/sub03/sub/sub.cpp
CMakeFiles/sub.dir/sub.o: CMakeFiles/sub.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/sgt/CPlus/Demo01/sub03/sub/cmake-build-release-ubuntu2004/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/sub.dir/sub.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/sub.dir/sub.o -MF CMakeFiles/sub.dir/sub.o.d -o CMakeFiles/sub.dir/sub.o -c /home/sgt/CPlus/Demo01/sub03/sub/sub.cpp

CMakeFiles/sub.dir/sub.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/sub.dir/sub.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/sgt/CPlus/Demo01/sub03/sub/sub.cpp > CMakeFiles/sub.dir/sub.i

CMakeFiles/sub.dir/sub.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/sub.dir/sub.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/sgt/CPlus/Demo01/sub03/sub/sub.cpp -o CMakeFiles/sub.dir/sub.s

# Object files for target sub
sub_OBJECTS = \
"CMakeFiles/sub.dir/sub.o"

# External object files for target sub
sub_EXTERNAL_OBJECTS =

libsub.a: CMakeFiles/sub.dir/sub.o
libsub.a: CMakeFiles/sub.dir/build.make
libsub.a: CMakeFiles/sub.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/sgt/CPlus/Demo01/sub03/sub/cmake-build-release-ubuntu2004/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX static library libsub.a"
	$(CMAKE_COMMAND) -P CMakeFiles/sub.dir/cmake_clean_target.cmake
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/sub.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/sub.dir/build: libsub.a
.PHONY : CMakeFiles/sub.dir/build

CMakeFiles/sub.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/sub.dir/cmake_clean.cmake
.PHONY : CMakeFiles/sub.dir/clean

CMakeFiles/sub.dir/depend:
	cd /home/sgt/CPlus/Demo01/sub03/sub/cmake-build-release-ubuntu2004 && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/sgt/CPlus/Demo01/sub03/sub /home/sgt/CPlus/Demo01/sub03/sub /home/sgt/CPlus/Demo01/sub03/sub/cmake-build-release-ubuntu2004 /home/sgt/CPlus/Demo01/sub03/sub/cmake-build-release-ubuntu2004 /home/sgt/CPlus/Demo01/sub03/sub/cmake-build-release-ubuntu2004/CMakeFiles/sub.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/sub.dir/depend

