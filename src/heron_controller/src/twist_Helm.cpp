#include <ros/ros.h>
#include <geometry_msgs/Twist.h>
#include <heron_msgs/Helm.h>

#include <heron_controller/controlConfig.h> 
#include <dynamic_reconfigure/server.h>

#include <iostream>

using namespace std;

double forward_maximum_speed;
double backward_maximum_speed;
ros::Publisher helm_pub;

void callback(heron_controller::controlConfig& config){
	//The callback function for dynamic reconfigure server.
	forward_maximum_speed = config.forward_ratio;
	backward_maximum_speed = config.backward_ratio;
	ROS_INFO("forward_maximum_speed: %lf  backward_maximum_speed: %lf", forward_maximum_speed, backward_maximum_speed);
}

float constraint(float a){
	//The constraint function for linear speed, convert the linear speed to range of [-1,1]
	if (a>forward_maximum_speed)
		a = 1.0;
	else if (a > 0)
		a = a / forward_maximum_speed;
	else if (a < (-1) * backward_maximum_speed)
		a = -1.0;
	else
		a = a / backward_maximum_speed;
	
	return a;
}

void twistCallback(const geometry_msgs::Twist& twist_aux){
	//The callback function for twist message, convert the twist into helm message provided by heron
	heron_msgs::Helm helm;
	helm.thrust = constraint(twist_aux.linear.x);
	helm.yaw_rate = twist_aux.angular.z;
	
	helm_pub.publish(helm);

}

int main(int argc, char** argv)
{//The main function 
	ros::init (argc,argv,"Twist_Helm");
	ros::NodeHandle nh;
	dynamic_reconfigure::Server<heron_controller::controlConfig> server;
	dynamic_reconfigure::Server<heron_controller::controlConfig>::CallbackType f;
	f = boost::bind(&callback,_1);
	server.setCallback(f);

	helm_pub = nh.advertise<heron_msgs::Helm>("cmd_helm",1);
	ros::Subscriber twist_sub = nh.subscribe("cmd_vel",10,twistCallback);

	ros::spin();

	return 0;


}
