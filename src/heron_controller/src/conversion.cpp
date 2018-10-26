#include <ros/ros.h>
#include <geometry_msgs/Twist.h>
#include <heron_msgs/Drive.h>

#include <heron_controller/controlConfig.h>
#include <dynamic_reconfigure/server.h>

#include <iostream>

using namespace std;

float width_robot;
float vl = 0.0;
float vr = 0.0;
//double ratio;

void callback(heron_controller::controlConfig& config, uint32_t level){

	width_robot = config.width_robot;
	//ratio = config.ratio;
	//ROS_INFO("%f,%f",config.width_robot,config.ratio);
}

void cmd_velCallback(const geometry_msgs::Twist& twist_aux){
	double vel_x = twist_aux.linear.x;
	double vel_th = twist_aux.angular.z;
	float right_vel = 0.0;
	float left_vel = 0.0;
	
	if(vel_th == 0){
		left_vel = right_vel = vel_x;
	}

	else if(vel_x == 0){
		if(vel_th > 0){
			right_vel = vel_th * width_robot * 17/22;//Assume the maximum forward speed is 1.7m/s, and maximum backward speed is 0.5m/s
			left_vel = (-1) * vel_th * width_robot * 5/22;		
		}
		else{
			left_vel = vel_th * width_robot * 17/22;
			right_vel = (-1) * vel_th*width_robot*5/22;					
		}
	}
	else if(vel_x > 0){
		if(vel_th > 0){
		//Forward and turn left
		right_vel = vel_x + vel_th * width_robot * 17/22;
		left_vel =  vel_x - vel_th * width_robot * 5/22;
		}
		else{
		left_vel = vel_x +vel_th * width_robot * 17/22;
		right_vel = vel_x -vel_th * width_robot * 5/22;
		}
	}
	else
	{ROS_INFO("Can not backward and turn!");} 
	
	vr = right_vel;
	vl = left_vel;

	

}

float Ratio(float a){
	if (a > 0){a = a / 1.7;}
	else{a = a / 0.5;}
	return a;
}

int main(int argc,char** argv)
{
	ros::init(argc,argv,"twist_RandL");
	ros::NodeHandle n;
	dynamic_reconfigure::Server<heron_controller::controlConfig> server;
	dynamic_reconfigure::Server<heron_controller::controlConfig>::CallbackType f;
	f = boost::bind(&callback,_1,_2);
	server.setCallback(f);

	ros::Subscriber cmd_vel_sub = n.subscribe("cmd_vel",10,cmd_velCallback);
	ros::Publisher RandL_pub = n.advertise<heron_msgs::Drive>("cmd_drive",10);

	ros::Rate loop_rate(10);

	while(ros::ok())
	{
		 heron_msgs::Drive drive;
		 drive.right = Ratio(vr);
		 drive.left = Ratio(vl);
		 RandL_pub.publish(drive);
		 ros::spinOnce();
		 loop_rate.sleep();		
	}
	return 0;
}
