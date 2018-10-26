/*
This program is aiming to republish the external_imu_information since the directions of the IMU linear acceleration are inversed.

Luke Wen,
1st, June, 2017
*/

#include <ros/ros.h>
#include <sensor_msgs/Imu.h>
#include <iostream>

using namespace std;

class RepublishImu
{
	public:
		RepublishImu();

	private:
		ros::NodeHandle n;
		ros::Publisher pub;
		ros::Subscriber sub;

		void ImuCallback(const sensor_msgs::Imu imu);
};

RepublishImu::RepublishImu()
{
	pub = n.advertise<sensor_msgs::Imu> ("imu/data_compass_modified",1);
	sub = n.subscribe<sensor_msgs::Imu> ("imu/data_compass",10,&RepublishImu::ImuCallback,this);

}


void RepublishImu::ImuCallback(const sensor_msgs::Imu imu)
{ 
	sensor_msgs::Imu imu_modified;
	imu_modified = imu;
	imu_modified.linear_acceleration.x = imu_modified.linear_acceleration.x*(-1);
	imu_modified.linear_acceleration.y = imu_modified.linear_acceleration.y*(-1);
	imu_modified.linear_acceleration.z = imu_modified.linear_acceleration.z*(-1);
	
	pub.publish(imu_modified);
}

int main(int argc,char** argv)
{
 	ros::init(argc,argv,"republish_imu");
	RepublishImu republishImu;

	ros::spin();

}
