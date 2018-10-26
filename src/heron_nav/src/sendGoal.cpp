#include <ros/ros.h>
#include <move_base_msgs/MoveBaseAction.h>
#include <actionlib/client/simple_action_client.h>
#include <dynamic_reconfigure/server.h>
#include <heron_nav/navigationConfig.h>

float goal_x,goal_y,goal_w;

typedef actionlib::SimpleActionClient<move_base_msgs::MoveBaseAction> MoveBaseClient;

void callback(heron_nav::navigationConfig& config, uint32_t level){
	goal_x = config.goal_x;
	goal_y = config.goal_y;
	goal_w = config.goal_w;
	ROS_INFO("%f,%f,%f",config.goal_x,config.goal_y,config.goal_w);
}

int main(int argc, char** argv)
{
	ros::init(argc,argv,"navigation_goals");
	ros::NodeHandle n;
	
	dynamic_reconfigure::Server<heron_nav::navigationConfig> server;
	dynamic_reconfigure::Server<heron_nav::navigationConfig>::CallbackType f;
	f = boost::bind(&callback,_1,_2);
	server.setCallback(f);
	
	MoveBaseClient ac("move_base", true);
	while(!ac.waitForServer())
	{
		ROS_INFO("Waiting for the move_base action server");	
	}
	
	move_base_msgs::MoveBaseGoal goal;

	goal.target_pose.header.frame_id = "odom";
	goal.target_pose.header.stamp = ros::Time::now();
	
	goal.target_pose.pose.position.x = goal_x;
	goal.target_pose.pose.position.y = goal_y;
	goal.target_pose.pose.orientation.w = goal_w;

	ROS_INFO("Sending goal");	

	ac.sendGoal(goal);
	
	ac.waitForResult();
	
	if(ac.getState() == actionlib::SimpleClientGoalState::SUCCEEDED)
	{ 	ROS_INFO("You have arrived to the goal position");
		}
	else
        {ROS_INFO("The base failed for some reason");}
	ros::spin();
	return 0;
}
