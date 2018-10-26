#include <ros/ros.h>
#include <move_base_msgs/MoveBaseAction.h>
#include <actionlib/client/simple_action_client.h>
#include <iostream>
 
typedef actionlib::SimpleActionClient<move_base_msgs::MoveBaseAction> MoveBaseClient;

int main (int argc, char** argv)
{
	ros::init (argc,argv,"simple_navigation_goals");
	
	//Tell the action client that we want to spin a thread bu default
	MoveBaseClient  ac("move_base",true);
	
	//wait for the action server to come up
	while (!ac.waitForServer(ros::Duration(5.0)))
	{
		ROS_INFO("Waiting for the move_base action server to come up");
	
	}
	
	move_base_msgs::MoveBaseGoal goal;
	float x[] = {0.0,3.0,3.0,6.0,6.0,9.0,9.0,12.0,12.0,15.0,15.0,0.0,0.0,15.0,15.0,0.0,0.0,15.0,15.0,0.0,0.0,15.0,15.0,0.0,0.0,15.0,15.0,0.0,0.0,15.0,15.0,0.0,0.0	
		   };
	float y[] = {20.0,20.0,0.0,0.0,20.0,20.0,0.0,0.0,20.0,20.0,0.0,0.0,2.0,2.0,4.0,4.0,6.0,6.0,8.0,8.0,10.0,10.0,12.0,12.0,14.0,14.0,16.0,16.0,18.0,18.0,20.0,20.0,0.0
                     };
	
	//We'll send the goals
	for (size_t i = 0; i < sizeof(x); ++i)
	{
		goal.target_pose.header.frame_id = "odom";
		goal.target_pose.header.stamp = ros::Time::now();
		
		goal.target_pose.pose.position.x = x[i];
		goal.target_pose.pose.position.y = y[i];
		goal.target_pose.pose.orientation.w = 1.0;
	
		ROS_INFO("Sending goal");
		ac.sendGoal(goal);

		ac.waitForResult(ros::Duration(60));
		
		if (ac.getState() == actionlib::SimpleClientGoalState::SUCCEEDED)
			ROS_INFO("Luke, the base moved successfully to : %f %f",x[i],y[i]);
		else
			ROS_INFO("Failed to : %f %f",x[i],y[i]);
	}
	
 
	return 0;

}

