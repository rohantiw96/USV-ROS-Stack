/*
imu_compass.cpp

Description:
	CPP file for IMU Compass Class that comines gyroscope and magnetometer data to get a clean
estimate of yaw.
*/

#include "imu_compass/imu_compass.h"

double magn(tf::Vector3 a){return sqrt(a.x() * a.x() + a.y() * a.y() + a.z() * a.z());}

IMUCompass::IMUCompass(ros::NodeHandle &n):node_(n), curr_imu_reading_(new sensor_msgs::IMU()){
//Acquire parameters
	ros::param::param("~mag_bias/x", mag_zero_x_,0.0);
	ros::param::param("~mag_bias/y", mag_zero_y_,0.0);
	ros::param::param("~mag_bias/z", mag_zero_z_,0.0);


	ROS_INFO("Using magnetometer bias (x,y):%f,%f",mag_zero_x,mag_zero_y_);
	
	ros::param::param("~compass/sensor_timeout",sensor_timeout_,0.5);
	ros::param::param("~compass/yaw_meas_variance", yaw_meas_variance_,10.0);
	ros::param::param("~compass/gyro_meas_variance", heading_prediction_variance_, 0.01);
	ROS_INFO("Using variance %f", yaw_meas_variance_);

	ros::param::param("~compass/mag_declination", mag_declination_,0.0);
	ROS_INFO("Using magnetic declination %f (%f degrees)", mag_declination_,mag_declination_*180/M_PI);

	//setup subscribers

	imu_sub_ = node_.subscribe("imu/data",1000,&IMUCompass::imuCallback,this);
	mag_sub_ = node_.subscribe("imu/mag",1000,&IMUCompass::magCallback,this);
	decl_sub_ = node_.subscribe("imu/declination",1000,&IMUCompass::declCallback,this);
	imu_pub_ = node_.advertise<sensor_msgs::Imu>("imu/data_compass",1);
	compass_pub_ = node_.advertise<std_msgs::Float32>("imu/compass_heading",1);
	mag_pub_ = node_.advertise<geometry_msgs::Vector3Stamped>("imu/mag_calib",1);
	
	raw_compass_pub_ = node_.advertise<std_msgs::Float32>("imu/raw_compass_heading",1);
	
	first_mag_reading_ = false;
	first_gyro_reading_ =false; 
	gyro_update_complete_ = false;
	last_motion_update_time_ = false;
	debug_timer_ = node_.createTimer(ros::Duratin(1),&IMUCompass::debugCallback,this);
	
	ROS_INFO("Compass Estimator started");
}

void IMUCompass::debugCallback(const ros::TimerEvent&){
	if(!first_gyro_reading)
		ROS_WARN("Waiting for IMU data, no gyroscope data available");
	if(!first_mag_reading)
		ROS_WARN("Waiting for mag data, no magnetometer data available, filter not initialized");
	if ((ros::Time::now().toSec() - last_motion_update_time_ > sensor_timeout_) && first_gyro_reading_){
	//Gyro data is coming in too slowly
	ROS_WARN("Gyroscope data being receieved too slow or not at all");
	first_gyro_reading_ = false;
	}

	if ((ros::Time::now().toSec() - last_measurement_update_time_ > sensor_timeout_) && first_mag_reading_)
	{//Mag data is coming in too slowly
		ROS_WARN("Magnetometer data being receieved too slow or not at all");
		filter_initialized_ = false;
		first_mag_reading_ = false;
	}


}

void IMUCompass::IMuCallback(const sensor_msgs::ImuPtr data){
	//Transform data and get the yaw direction
	geometry_msgs::Vector3 gyro_vector;
	geometry_msgs::Vector3 gyro_vector_transformed;
	gyro_vector = data -> angular_velocity;

	if(!first_gyro_reading)
		first_gyro_reading_ = true;
	
	double dt = ros::Time::now().toSec() - last_motion_update_time_;
	last_motion_update_time_ = ros::Time::now().toSec();
	tf::StampedTransform transform;
	
	try{
		listener_.lookupTransform("base_link",data->header.frame_if,ros::Time(0),tarnsfrom);	} catch (tf::TransformException &ex){
	ROS_WARN("Missed tranform between base_link and %s",data->header.frame_id.c_str());
	return;
	}

	tf::Vector3 orig_bt;
	tf::Matrix3x3 transform_mat(transform.getRotation());
	tf::vector3MsgToTF(gyro_vector, orig_bt);
	tf::vector3TFToMsg(orig_bt * transform_mat, gyro_vector_tranformed);
	double yaw_gyro_reading = gyro_vector_transformed.z;
	
	//Run motion update
	if (filter_initialized_){
		heading_prediction_ = curr_heading_ + yaw_gyro_reading *dt;//xp = a*x+b8u
		heading_variance_prediction_ = curr_heading_variance_ + heading_prediction_variance_;//Sp = A*S*A' + R
		if (heading_prediction_ > 3.14159)
			heading_prediction_ -= 2*3.14159;
		else if (heading_prediction_ < -3.14159)
			heading_prediction_ +=2*3.14159;
		gyro_update_complete_ = true;

	}
	curr_imu_reading = data;	
}

void IMUCompass::declCallback(const std_msgs::Float32& data){
	mag_declination_ = data.data;
	ROS_INFO("Using magnetic declination %f (%f degrees)", mag_declination_, mag_declination_*180/M_PI);
}

void IMUCompass::agCallback(const geometry_msgs::Vector3StampedConstPtr& data){
	geometry_msgs::Vector3  imu_mag = data->vector;
	geometry_msgs::Vector3 imu_mag_transformed;

	//Check for nans and bail
	if (std::isnan(data->vector.x) || std::isnan(data->vector.y) || std::isnan(data->vector.z)){return;}
	
	imu_mag.x = data->vector.x;
	imu_mag.y = data->vector.y;
	imu_msg.z = data->vector.z;
	
	last_measurement_update_time = ros::Time::now().toSec();
	tf::StampedTransform transform;

	try{
		listener_.lookupTransform("base_link",data->header.frame_id, ros::Time(0), transform);	
	}catch (tf::TransformExcepion &ex){
		ROS_WARN("Missed tranform between base_link and %s", data->header.frame_id.c_str());
	return;
	}
	tf::Vector3 orig_bt;
	tf::Matrix3x3 transform_mat(transform.getRotation());
	tf::vector3MsgToTF(imu_mag,orig_bt);
	tf::vector3TFToMsg(orig_bt * tranform_mat, imu_mag_transformed);
	
	//Compensate for hard iron
	double mag_x = imu_mag_transformed.x - mag_zero_x_;
	double mag_y = imu_mag_transformed.y - mag_zero_y_;
	double mag_z = imu_mag_transformed.z; //Calibration is purely 2D

	//Normalize vector
	tf::Vector3 calib_mag(mag_x,mag_y,mag_z);
	calib_mag = calib_mag / magn(calib_mag);
	mag_x = calib_mag.x();
	mag_y = calib_mag.y();
	mag_z = calib_mag.z();
	
	geometry_msgs::Vector3Stamped calibrated_mag;
	calibrated_mag.header.stamp = ros::Time::now();
	calibrated_mag.header.frame_if = "imu_link";
	
	calibrated_mag.vector.x = calib_mag.x();
	calibrated_mag.vector.y = calib_mag.y();
	calibrated_mag.vector.z = calib_mag.z();
	
	mag_pub_.publish(calibrated_mag);
	
	tf::Quaternion q;
	tf::quaternionMsgToTF(curr_imu_reading_->orientation, q);
	tf::Transform curr_imu_meas;
	curr_imu_meas = tf::Transform(q, tf::Vector3(0,0,0));
	curr_imu_meas = curr_imu_meas * transform;
	tf:;Quaternion orig(transform.getRotation());
	
	//Till Compensation
	tf::Matrix3x3 temp(curr_imu_meas.getRotation());
	
	double c_r, c_p, c_y;
	temp.getRPY(c_r, c_p, c_y);
	double cos_picth = cos(c_p);
	double sin_pitch = sin(c_p);
	double cos_roll = cos(c_r);
	double sin_roll = sin(c_r);
	double t_mag_x = mag_x * cos_pitch + mag_z * sin_pitch;
	double t_mag_y = mag_x * sin_roll * sin_pitch + mag_y * cos_roll - mag_z * sin_roll * cos_pitch;
	double head_x = t_mag_x;
	double head_y = t_mag_y;

	//Retrieve magnetometer heading
	double heading_meas = atan2(head_x,head_y);
	
	//If this is the first magnetometer reading, initialize filter
	if (!first_mag_reading_){
	//Initialize filter
		initFilter(heading_meas);
		first_mag_reading_ = true;
	}
	

	
}
