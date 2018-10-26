#include <ros/ros.h>
#include <sensor_msgs/Range.h>
#include <iostream>
#include <sensor_msgs/NavSatFix.h>
ros::Time stamp;

void callback(const sensor_msgs::NavSatFix::ConstPtr& gps)
{//Callback function fo the navsat/fix topic's header.stamp
	stamp = gps->header.stamp;
	ROS_INFO("The range_pub is working");


}

using namespace std;

int main(int argc,char** argv)
{
	ros::init(argc,argv,"range_publish");
	ros::NodeHandle n;
	ros::Publisher range_pub=n.advertise<sensor_msgs::Range>("dbs",10);
	ros::Subscriber stamp_sub = n.subscribe<sensor_msgs::NavSatFix>("navsat/fix",10,&callback);
	ros::Rate loop_rate(5);
	while(n.ok())
	{
		sensor_msgs::Range range;
		//range.ULTRASOUND = 1;
		//range.INFRARED = 0;
		range.header.stamp = stamp;
		range.header.frame_id = "sonar_frame";
		range.radiation_type = range.ULTRASOUND;
		range.field_of_view = 3.14;
		range.min_range = 0;
		range.max_range = 50;
		range.range = 0.5; 
		
		range_pub.publish(range);
		ros::spinOnce();
		loop_rate.sleep();

	}

}
