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
CMAKE_SOURCE_DIR = /home/tsf/CLionProject

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/tsf/CLionProject/cmake-build-debug

# Include any dependencies generated for this target.
include CMakeFiles/CLionProject.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/CLionProject.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/CLionProject.dir/flags.make

CMakeFiles/CLionProject.dir/socket/socketServer.c.o: CMakeFiles/CLionProject.dir/flags.make
CMakeFiles/CLionProject.dir/socket/socketServer.c.o: ../socket/socketServer.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/tsf/CLionProject/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/CLionProject.dir/socket/socketServer.c.o"
	/usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/CLionProject.dir/socket/socketServer.c.o   -c /home/tsf/CLionProject/socket/socketServer.c

CMakeFiles/CLionProject.dir/socket/socketServer.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/CLionProject.dir/socket/socketServer.c.i"
	/usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/tsf/CLionProject/socket/socketServer.c > CMakeFiles/CLionProject.dir/socket/socketServer.c.i

CMakeFiles/CLionProject.dir/socket/socketServer.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/CLionProject.dir/socket/socketServer.c.s"
	/usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/tsf/CLionProject/socket/socketServer.c -o CMakeFiles/CLionProject.dir/socket/socketServer.c.s

CMakeFiles/CLionProject.dir/socket/socketServer.c.o.requires:

.PHONY : CMakeFiles/CLionProject.dir/socket/socketServer.c.o.requires

CMakeFiles/CLionProject.dir/socket/socketServer.c.o.provides: CMakeFiles/CLionProject.dir/socket/socketServer.c.o.requires
	$(MAKE) -f CMakeFiles/CLionProject.dir/build.make CMakeFiles/CLionProject.dir/socket/socketServer.c.o.provides.build
.PHONY : CMakeFiles/CLionProject.dir/socket/socketServer.c.o.provides

CMakeFiles/CLionProject.dir/socket/socketServer.c.o.provides.build: CMakeFiles/CLionProject.dir/socket/socketServer.c.o


# Object files for target CLionProject
CLionProject_OBJECTS = \
"CMakeFiles/CLionProject.dir/socket/socketServer.c.o"

# External object files for target CLionProject
CLionProject_EXTERNAL_OBJECTS =

CLionProject: CMakeFiles/CLionProject.dir/socket/socketServer.c.o
CLionProject: CMakeFiles/CLionProject.dir/build.make
CLionProject: CMakeFiles/CLionProject.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/tsf/CLionProject/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable CLionProject"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/CLionProject.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/CLionProject.dir/build: CLionProject

.PHONY : CMakeFiles/CLionProject.dir/build

CMakeFiles/CLionProject.dir/requires: CMakeFiles/CLionProject.dir/socket/socketServer.c.o.requires

.PHONY : CMakeFiles/CLionProject.dir/requires

CMakeFiles/CLionProject.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/CLionProject.dir/cmake_clean.cmake
.PHONY : CMakeFiles/CLionProject.dir/clean

CMakeFiles/CLionProject.dir/depend:
	cd /home/tsf/CLionProject/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/tsf/CLionProject /home/tsf/CLionProject /home/tsf/CLionProject/cmake-build-debug /home/tsf/CLionProject/cmake-build-debug /home/tsf/CLionProject/cmake-build-debug/CMakeFiles/CLionProject.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/CLionProject.dir/depend

