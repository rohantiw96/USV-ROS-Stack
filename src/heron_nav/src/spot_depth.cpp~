#include <ros/ros.h>
#include <message_filters/subscriber.h>
#include <message_filters/synchronizer.h>
#include <message_filters/sync_policies/approximate_time.h>
#include <sensor_msgs/Range.h>
#include <geometry_msgs/TwistStamped.h>
#include <sensor_msgs/NavSatFix.h>
#include <heron_nav/spot_depth.h>
#include <iostream>

//using namespace std;
using namespace message_filters;
using namespace sensor_msgs;
using namespace geometry_msgs;

heron_nav::spot_depth spot_depth;


void callback(const Range::ConstPtr& range, const sensor_msgs::NavSatFix::ConstPtr& gps)
{// the callback function for depth and gps position
	spot_depth.depth = range->range;
	spot_depth.lat_spot = gps->latitude;
	spot_depth.long_spot = gps->longitude;
	ROS_INFO("%f,%f,%f,%f,%f,%f",gps->latitude,gps->longitude,range->range,spot_depth.depth,spot_depth.lat_spot,spot_depth.long_spot);
	
	

}

int main(int argc,char** argv)
{//The main function for the spot_depth information
	ros::init(argc,argv,"spot_depth");
	ros::NodeHandle n;
	ros::Publisher spot_depth_pub = n.advertise<heron_nav::spot_depth>("spot_depth",2);
	message_filters::Subscriber<Range> range_sub(n,"sonar/dbs",1);
	message_filters::Subscriber<NavSatFix> gps_sub(n,"navsat/fix",1);
	typedef sync_policies::ApproximateTime<Range,NavSatFix> MySyncPolicy;
	//ApprocimateTime takes a queue size as its constructor argument
	Synchronizer<MySyncPolicy> sync(MySyncPolicy(5),range_sub,gps_sub);
	sync.registerCallback(boost::bind(&callback, _1, _2));
	ros::Rate loop_rate(2);
	while(n.ok())
	{
	spot_depth_pub.publish(spot_depth);
	//ROS_WARN("%f",spot_depth.depth);
	
	ros::spinOnce();
	loop_rate.sleep();		
	}
	return 0;


}
/*#include <ros/ros.h>
#include <sensor_msgs/NavSatFix.h>
#include <sensor_msgs/Range.h>
#include <message_filters/subscriber.h>
#include <message_filters/synchronizer.h>
#include <message_filters/sync_policies/approximate_time.h>
#include <heron_nav/spot_depth.h>
#include <iostream>

using namespace std;
using namespace sensor_msgs;
using namespace message_filters;

heron_nav::spot_depth spot_depth;

void callback(const Range::ConstPtr& range, const NavSatFix::ConstPtr& gps)
{//The callback function for subscribeing the two topics
	spot_depth.depth = range->range;
	spot_depth.lat_spot = gps->latitude;
	spot_depth.long_spot = gps->longitude;
	ROS_INFO("%f,%f,%f",range->range,gps->latitude,gps->longitude,spot_depth.depth,spot_depth.lat_spot,spot_depth.long_spot);

}

int main(int argc,char** argv)
{//The main function for the spot_dpeth topic.
	ros::init(argc,argv,"spot_depth");
	ros::NodeHandle n;
	ros::Publisher spot_depth_pub = n.advertise<heron_nav::spot_depth>("spot_depth",10);
	ros::Rate loop_rate(3);
	message_filters::Subscriber<Range> range_sub(n,"dbs",1);
	message_filters::Subscriber<NavSatFix> gps_sub(n,"navsat/fix",1);
	typedef sync_policies::ApproximateTime<Range,NavSatFix> MySyncPolicy;
	//ApproxiamteTime takes a queue size as its constructor argument
	Synchronizer<MySyncPolicy> sync(MySyncPolicy(5),range_sub,gps_sub);
	sync.registerCallback(boost::bind(&callback,_1,_2));
	
	while(n.ok())
	{
		spot_depth_pub.publish(spot_depth);
		ros::spinOnce();
		loop_rate.sleep();	
	}
	
	
	return 0;	



}



/*#include <ros/ros.h>
#include <message_filters/subscriber.h>
#include <message_filters/time_synchronizer.h>
#include <heron_nav/spot_depth.h>
#include <sensor_msgs/NavSatFix.h>
//#include <sensor_msgs/Range.h>
#include <geometry_msgs/TwistStamped.h>
#include <iostream>

using namespace sensor_msgs;
using namespace message_filters;
using namespace std;
using namespace geometry_msgs;

class Spot_depth{
public:
	Spot_depth();
private:
	ros::NodeHandle n;
	heron_nav::spot_depth spot_depth;
	ros::Publisher spot_depth_pub;
	//ros::Subscriber gps_sub;
	//ros::Subscriber range_sub;
	//void gpsCallback(const sensor_msgs::NavSatFix::ConstPtr& gps);
	//void rangeCallback(const sensor_msgs::Range::ConstPtr& range); 
	void callback(const NavSatFix::ConstPtr& gps, const TwistStamped::ConstPtr& range);
};

Spot_depth::Spot_depth()
{//Constructor function to do the main job.
	spot_depth_pub = n.advertise<heron_nav::spot_depth>("spot_depth",2);
	//gps_sub = n.subscribe<sensor_msgs::NavSatFix>("navsat/fix",10,&Spot_depth::gpsCallback,this);
	//range_sub = n.subscribe<sensor_msgs::Range>("dbt",10,&Spot_depth::rangeCallback,this);
	//spot_depth_pub.publish(spot_depth);
	message_filters::Subscriber<NavSatFix> gps_sub(n,"navsat/fix",1);
	message_filters::Subscriber<TwistStamped> range_sub(n,"navsat/vel",1);
	TimeSynchronizer<NavSatFix,TwistStamped> sync(gps_sub,range_sub,10);
	sync.registerCallback(boost::bind(&Spot_depth::callback, this,_1, _2));
}

void Spot_depth::callback(const sensor_msgs::NavSatFix::ConstPtr& gps,const TwistStamped::ConstPtr& range)
{//The callback function for the gps signal subscriber
	spot_depth.lat_spot = gps->latitude;
	spot_depth.long_spot = gps->longitude;
	spot_depth.depth = range->twist.linear.x;
	ROS_INFO("%f,%f",gps->latitude,gps->longitude,range->twist.linear.x);
 	spot_depth_pub.publish(spot_depth);
}

//void Spot_depth::rangeCallback(const sensor_msgs::Range::ConstPtr& range)
//{//Callback function for range subcriber
//	spot_depth.depth =  range->range;
//	ROS_INFO("%f",range->range);

//}

int main(int argc, char** argv)
{
	ros::init(argc,argv,"spot_depth");
	Spot_depth spot_depth;
	ros::spin();
	return 0;
}*/



/*#include <ros/ros.h>
#include <message_filters/subscriber.h>
#include <message_filters/time_synchronizer.h>
#include <heron_nav/spot_depth.h>
#include <geometry_msgs/TwistStamped.h>
#include <sensor_msgs/NavSatFix.h>
#include <iostream>

using namespace std;
using namespace message_filters;
using namespace geometry_msgs;
using namespace sensor_msgs;

heron_nav::spot_depth spot_depth;
void callback(const TwistStamped::ConstPtr& vel, const NavSatFix::ConstPtr& gps)
{//The callback fucntion for subscribing the two topics
	spot_depth.depth = vel->twist.linear.x;
	spot_depth.lat_spot = gps->latitude;
	spot_depth.long_spot = gps->longitude;
	ROS_INFO("%f,%f,%f",vel->twist.linear.x,gps->latitude,gps->longitude);

}

int main(int argc, char** argv)
{//The ros node initilization
	ros::init(argc,argv,"spot_depth");
	ros::NodeHandle n;
	ros::Publisher spot_depth_pub = n.advertise<heron_nav::spot_depth>("spot_depth",5);
	ros::Rate loop_rate(10);
	message_filters::Subscriber<NavSatFix> gps_sub(n,"navsat/fix",1);
	message_filters::Subscriber<TwistStamped> vel_sub(n,"navsat/vel",1);
	TimeSynchronizer<TwistStamped,NavSatFix> sync(vel_sub,gps_sub,10);
	sync.registerCallback(boost::bind(&callback,_1,_2));
	while(n.ok())
	{
		spot_depth_pub.publish(spot_depth);
		ros::spinOnce();
		loop_rate.sleep();
		
 	}		 



	return 0;
}*/
