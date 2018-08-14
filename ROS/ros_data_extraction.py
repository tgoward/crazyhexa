#!/usr/bin/env python
import rospy, sys, os
from geometry_msgs.msg import PoseStamped
import numpy as np
from tf.transformations import euler_from_quaternion

def callback_waypoint(data):
    global w_x,w_y,w_z
    w_x = data.pose.position.x
    w_y = data.pose.position.y
    w_z = data.pose.position.z

def callback_tracker(data):
    global outfile,w_x,w_y,w_z,first,init_time
    try:
        first
    except:
        init_time = rospy.get_time()
        first = False
    t = rospy.get_time() - init_time
    v_x = data.pose.position.x
    v_y = data.pose.position.y
    v_z = data.pose.position.z

    orientation = (
        data.pose.orientation.x,
        data.pose.orientation.y,
        data.pose.orientation.z,
        data.pose.orientation.w)
    angles = euler_from_quaternion(orientation)
    outfile.write('{} {} {} {} {} {} {} {} {} {}\n'.format(t,v_x,v_y,v_z,w_x,w_y,w_z,angles[0],angles[1],angles[2]))

if __name__ == '__main__':
    # init ros node 
    rospy.init_node('test', anonymous=False,log_level=rospy.INFO)

    # subscribe to vicon tracker
    tracker = '/vrpn_client_node/crazyhexa/pose'
    tracker_waypoint = '/crazyflie/goal'

# create file and subscribe to Hypercube sensor data
    global outfile
    outfile = open(sys.argv[1], "w")
    rospy.Subscriber(tracker_waypoint, PoseStamped, callback_waypoint)
    rospy.wait_for_message(tracker_waypoint,PoseStamped)
    rospy.loginfo("tracker_waypoint received")
    rospy.Subscriber(tracker, PoseStamped, callback_tracker)
    rospy.wait_for_message(tracker,PoseStamped)
    rospy.loginfo("tracker received")
    

    rospy.spin()
    
    if rospy.is_shutdown():
        outfile.close()
