#include <ros/ros.h>
#include <ros/time.h>
#include <geometry_msgs/Twist.h>
#include <heron_msgs/Drive.h>
#include <std_msgs/Float32.h>
#include <iostream>

using namespace std;

int main(int argc, char** argv)
{
	ros::init(argc,argv,"forward_speed");
	ros::NodeHandle nh;
	//ros::Subscriber drive_sub = nh.subscribe<heron_msgs::Drive>("cmd_drive",2);
	//Subscriber for the cmd_drive topics
	ros::Publisher  drive_pub = nh.advertise<heron_msgs::Drive>("cmd_drive",2);
	//The variables used in this programme	
	//float left;
	//float right; //The ros node params
	heron_msgs::Drive drive;
	ros::Time time1;
	ros::Time time2;// The time for timer
	double secs;
	int distance = 10;
	double speed;//The speed of heron
	ros::Rate loop_rate(10);
	//nh.param<std_msgs::Float32>("left",left,1.0);
	//nh.param<std_msgs::Float32>("right",right,1.0);
	drive.left = 1.0;
	drive.right = 1.0;
	//time1 = ros::Time::now();
	while(ros::ok()){
	drive_pub.publish(drive);
	
	ros::spinOnce();
	loop_rate.sleep();
	
	//time2 = ros::Time::now();
	//secs = (time2 - time1).toSec();
 	//speed = distance / secs;
	ROS_INFO("The speed of heron is ");}
		
	return 0;
	
}



/* #include <ros/ros.h>
#include <heron_msgs/Drive.h>
#include <iostream>

using namespace std;

int main(int argc, char** argv)
{
	ros::init(argc,argv,"drive");
	ros::NodeHandle nh;
	ros::Publisher drive_pub = nh.advertise<heron_msgs::Drive>("Drive",2);
	ros::Rate loop_rate(10);
	heron_msgs::Drive drive;
	drive.left = 1.0;
	drive.right = 1.0;
	while(ros::ok()){
	drive_pub.publish(drive);	
	ros::spinOnce();
	loop_rate.sleep();}

	return 0;

}*/
