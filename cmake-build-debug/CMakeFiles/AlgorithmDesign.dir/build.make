# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.7

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /home/tsf/Clion/bin/cmake/bin/cmake

# The command to remove a file.
RM = /home/tsf/Clion/bin/cmake/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/tsf/CLionProjects/AlgorithmDesign

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/tsf/CLionProjects/AlgorithmDesign/cmake-build-debug

# Include any dependencies generated for this target.
include CMakeFiles/AlgorithmDesign.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/AlgorithmDesign.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/AlgorithmDesign.dir/flags.make

CMakeFiles/AlgorithmDesign.dir/test.cpp.o: CMakeFiles/AlgorithmDesign.dir/flags.make
CMakeFiles/AlgorithmDesign.dir/test.cpp.o: ../test.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/tsf/CLionProjects/AlgorithmDesign/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/AlgorithmDesign.dir/test.cpp.o"
	/usr/bin/c++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/AlgorithmDesign.dir/test.cpp.o -c /home/tsf/CLionProjects/AlgorithmDesign/test.cpp

CMakeFiles/AlgorithmDesign.dir/test.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/AlgorithmDesign.dir/test.cpp.i"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/tsf/CLionProjects/AlgorithmDesign/test.cpp > CMakeFiles/AlgorithmDesign.dir/test.cpp.i

CMakeFiles/AlgorithmDesign.dir/test.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/AlgorithmDesign.dir/test.cpp.s"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/tsf/CLionProjects/AlgorithmDesign/test.cpp -o CMakeFiles/AlgorithmDesign.dir/test.cpp.s

CMakeFiles/AlgorithmDesign.dir/test.cpp.o.requires:

.PHONY : CMakeFiles/AlgorithmDesign.dir/test.cpp.o.requires

CMakeFiles/AlgorithmDesign.dir/test.cpp.o.provides: CMakeFiles/AlgorithmDesign.dir/test.cpp.o.requires
	$(MAKE) -f CMakeFiles/AlgorithmDesign.dir/build.make CMakeFiles/AlgorithmDesign.dir/test.cpp.o.provides.build
.PHONY : CMakeFiles/AlgorithmDesign.dir/test.cpp.o.provides

CMakeFiles/AlgorithmDesign.dir/test.cpp.o.provides.build: CMakeFiles/AlgorithmDesign.dir/test.cpp.o


# Object files for target AlgorithmDesign
AlgorithmDesign_OBJECTS = \
"CMakeFiles/AlgorithmDesign.dir/test.cpp.o"

# External object files for target AlgorithmDesign
AlgorithmDesign_EXTERNAL_OBJECTS =

AlgorithmDesign: CMakeFiles/AlgorithmDesign.dir/test.cpp.o
AlgorithmDesign: CMakeFiles/AlgorithmDesign.dir/build.make
AlgorithmDesign: CMakeFiles/AlgorithmDesign.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/tsf/CLionProjects/AlgorithmDesign/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable AlgorithmDesign"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/AlgorithmDesign.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/AlgorithmDesign.dir/build: AlgorithmDesign

.PHONY : CMakeFiles/AlgorithmDesign.dir/build

CMakeFiles/AlgorithmDesign.dir/requires: CMakeFiles/AlgorithmDesign.dir/test.cpp.o.requires

.PHONY : CMakeFiles/AlgorithmDesign.dir/requires

CMakeFiles/AlgorithmDesign.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/AlgorithmDesign.dir/cmake_clean.cmake
.PHONY : CMakeFiles/AlgorithmDesign.dir/clean

CMakeFiles/AlgorithmDesign.dir/depend:
	cd /home/tsf/CLionProjects/AlgorithmDesign/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/tsf/CLionProjects/AlgorithmDesign /home/tsf/CLionProjects/AlgorithmDesign /home/tsf/CLionProjects/AlgorithmDesign/cmake-build-debug /home/tsf/CLionProjects/AlgorithmDesign/cmake-build-debug /home/tsf/CLionProjects/AlgorithmDesign/cmake-build-debug/CMakeFiles/AlgorithmDesign.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/AlgorithmDesign.dir/depend

