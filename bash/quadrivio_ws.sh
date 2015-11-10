#!/bin/sh

VER=$(rosversion -d)

if [ $? -eq 0 ]; then
	echo "ROS $VER already installed"
else
	echo "Installing ROS jade..."
	sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
	sudo apt-key adv --keyserver hkp://pool.sks-keyservers.net:80 --recv-key 0xB01FA116
	sudo apt-get update
	sudo apt-get -y install ros-jade-desktop

	sudo rosdep init
	rosdep update

	echo "source /opt/ros/jade/setup.bash" >> ~/.bashrc
	source ~/.bashrc
	
	sudo apt-get -y install python-rosinstall
	
	VER=$(rosversion -d)
fi

sudo apt-get -y install ros-$VER-joy
sudo apt-get -y install libgsl0-dev libsuitesparse-dev libeigen3-dev libboost-all-dev

echo "Creating catking workspace..."
mkdir -p ~/quadrivio_ws/catkin/src
cd ~/quadrivio_ws/catkin/src
catkin_init_workspace

cd ~/quadrivio_ws/catkin
catkin_make

echo "source ~/quadrivio_ws/catkin/devel/setup.bash" >> ~/.bashrc
source ~/.bashrc

echo "Downloading source code..."
cd ~/quadrivio_ws/catkin/src
git clone https://github.com/AIRLab-POLIMI/quadrivio.git
git clone https://github.com/AIRLab-POLIMI/ROAMFREE.git

cd ~/quadrivio_ws
git clone https://github.com/AIRLab-POLIMI/sbpl.git
cd sbpl
mkdir build
cd build
cmake ..
make
sudo make install

echo "Downloading simulator..."
cd ~/quadrivio_ws
wget wget http://coppeliarobotics.com/V-REP_PRO_EDU_V3_1_2_64_Linux.tar.gz
tar -zxvf V-REP_PRO_EDU_V3_1_2_64_Linux.tar.gz
rm V-REP_PRO_EDU_V3_1_2_64_Linux.tar.gz
mv V-REP_PRO_EDU_V3_1_2_64_Linux VRep
cd ~/quadrivio_ws/VRep/programming/ros_packages/vrep_plugin
sed "s/hydro/$VER/" <CMakeLists.txt >tmp.txt
rm CMakeLists.txt
mv tmp.txt CMakeLists.txt

cd ~/quadrivio_ws/catkin/src
ln -s ~/quadrivio_ws/VRep/programming/ros_packages/vrep_common
ln -s ~/quadrivio_ws/VRep/programming/ros_packages/vrep_plugin

echo "Compiling..."
cd ~/quadrivio_ws/catkin
catkin_make --pkg vrep_common -DCMAKE_BUILD_TYPE=Release
catkin_make --pkg vrep_plugin -DCMAKE_BUILD_TYPE=Release
catkin_make --pkg roamros_msgs -DCMAKE_BUILD_TYPE=Release
catkin_make -DCMAKE_BUILD_TYPE=Release
