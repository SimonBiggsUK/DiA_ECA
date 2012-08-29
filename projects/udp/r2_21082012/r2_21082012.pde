//Library for udp
import hypermedia.net.*;
//library for using kinect
import SimpleOpenNI.*;

ArrayList users;

//defining a context for initializing kinect.
SimpleOpenNI  context;
boolean       autoCalib=true;

//udpTX.send(message,ip,port);
int PORT_RX=8102;
String HOST_IP = "172.20.36.161";//IP Address of the PC in which this App is running
UDP udp;//Create UDP object for recieving

//valuues order in udp package
final static int USERID=0;
final static int JOINT_NAME = 1;
final static int POS_X = 2;
final static int POS_Y = 3;
final static int POS_Z = 4;

void setup() {
  size(100, 100);
  background(100);
  udp= new UDP(this, PORT_RX, HOST_IP);
  udp.log(true);
  udp.listen(true);
  //Initializing Kinect,Starting Depth and then skeleton tracking
  context = new SimpleOpenNI(this);

  users=new ArrayList();

  // enable depthMap generation 
  startKinect();


  //    noLoop();
}
// enable depthMap generation 
void startKinect() {
  if (context.enableDepth() == false)
  {
    println("Can't open the depthMap, maybe the camera is not connected!"); 
    exit();
    return;
  }

  // enable skeleton generation for all joints
  context.enableUser(SimpleOpenNI.SKEL_PROFILE_ALL);
}

void draw() {
  // update the cam
  context.update();
  background(120);
  if (frameCount%500==0) {
    udp.send("test packet!!" + frameCount, HOST_IP, PORT_RX);
  }
  sendSkeleton();
  
  for(int i = users.size()-1 ; i >=0 ; i--){
    UserC user = (UserC) users.get(i);
    user.paint();
  }
} 

void sendSkeleton() {
  int[] userList = context.getUsers();
  PVector jointPos = new PVector();
  int userId;
  if (userList.length<=0) {
    udp.send("no user detected" + frameCount, HOST_IP, PORT_RX);
  }
  for (int i=0;i<userList.length;i++)
  {
    userId=userList[i];
    if (context.isTrackingSkeleton(userId)) {

      context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_HEAD, jointPos);
      udp.send(userId + "," + "SKEL_HEAD" + "," + jointPos.x + "," + jointPos.y+ "," + jointPos.z, HOST_IP, PORT_RX);

            context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, jointPos);
            udp.send(userId + "," + "SKEL_LEFT_SHOULDER" + "," + jointPos.x + "," + jointPos.y+ "," + jointPos.z, HOST_IP, PORT_RX);
            context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_ELBOW, jointPos);
            udp.send(userId + "," + "SKEL_LEFT_ELBOW" + "," + jointPos.x + "," + jointPos.y+ "," + jointPos.z, HOST_IP, PORT_RX);
            context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_HAND, jointPos);
            udp.send(userId + "," + "SKEL_LEFT_HAND" + "," + jointPos.x + "," + jointPos.y+ "," + jointPos.z, HOST_IP, PORT_RX);
      
            context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, jointPos);
            udp.send(userId + "," + "SKEL_RIGHT_SHOULDER" + "," + jointPos.x + "," + jointPos.y+ "," + jointPos.z, HOST_IP, PORT_RX);
            context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, jointPos);
            udp.send(userId + "," + "SKEL_RIGHT_ELBOW" + "," + jointPos.x + "," + jointPos.y+ "," + jointPos.z, HOST_IP, PORT_RX);
            context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_HAND, jointPos);
            udp.send(userId + "," + "SKEL_RIGHT_HAND" + "," + jointPos.x + "," + jointPos.y+ "," + jointPos.z, HOST_IP, PORT_RX);
      
            context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_TORSO, jointPos);
            udp.send(userId + "," + "SKEL_TORSO" + "," + jointPos.x + "," + jointPos.y+ "," + jointPos.z, HOST_IP, PORT_RX);
            context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_HIP, jointPos);
            udp.send(userId + "," + "SKEL_LEFT_HIP" + "," + jointPos.x + "," + jointPos.y+ "," + jointPos.z, HOST_IP, PORT_RX);
            context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_HIP, jointPos);   
            udp.send(userId + "," + "SKEL_RIGHT_HIP" + "," + jointPos.x + "," + jointPos.y+ "," + jointPos.z, HOST_IP, PORT_RX);
      
      
            context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_KNEE, jointPos);
            udp.send(userId + "," + "SKEL_LEFT_KNEE" + "," + jointPos.x + "," + jointPos.y+ "," + jointPos.z, HOST_IP, PORT_RX);
            context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_FOOT, jointPos);
            udp.send(userId + "," + "SKEL_LEFT_FOOT" + "," + jointPos.x + "," + jointPos.y+ "," + jointPos.z, HOST_IP, PORT_RX);
      
            context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_KNEE, jointPos);      
            udp.send(userId + "," + "SKEL_RIGHT_KNEE" + "," + jointPos.x + "," + jointPos.y+ "," + jointPos.z, HOST_IP, PORT_RX);
            context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_FOOT, jointPos);
            udp.send(userId + "," + "SKEL_RIGHT_FOOT" + "," + jointPos.x + "," + jointPos.y+ "," + jointPos.z, HOST_IP, PORT_RX);
    }
  }
}
void stop() {
  udp.close();
} 

void receive(byte[] data, String HOST_IP, int PORT_RX) {

  String value=new String(data);
  parseMessage(value);
}

void parseMessage(String _message) {
  String[] vals = _message.split(",");
  for (int i = users.size()-1 ; i >=0 ; i --) {
    UserC user = (UserC) users.get(i);
    if (user.mUserId==int(vals[USERID])) {

      //      println(new PVector(float(vals[POS_X]),float(vals[POS_Y]),float(vals[POS_Z])));
      //      println(vals[JOINT_NAME]);
      user.addJoint(vals[JOINT_NAME], new PVector(float(vals[POS_X]), float(vals[POS_Y]), float(vals[POS_Z])));
    }
  }
}
void keyPressed() {
}
void onNewUser(int userId)
{
  println("onNewUser - userId: " + userId);
  println("  start pose detection");
  users.add(new UserC(userId));
  if (autoCalib)
    context.requestCalibrationSkeleton(userId, true);
  else    
    context.startPoseDetection("Psi", userId);
}

void onLostUser(int userId)
{
  println("onLostUser - userId: " + userId);
}

void onExitUser(int userId)
{
  println("onExitUser - userId: " + userId);
}

void onReEnterUser(int userId)
{
  println("onReEnterUser - userId: " + userId);
}


void onStartCalibration(int userId)
{
  println("onStartCalibration - userId: " + userId);
}

void onEndCalibration(int userId, boolean successfull)
{
  println("onEndCalibration - userId: " + userId + ", successfull: " + successfull);

  if (successfull) 
  { 
    println("  User calibrated !!!");
    context.startTrackingSkeleton(userId);
  } 
  else 
  { 
    println("  Failed to calibrate user !!!");
    println("  Start pose detection");
    context.startPoseDetection("Psi", userId);
  }
}

void onStartPose(String pose, int userId)
{
  println("onStartdPose - userId: " + userId + ", pose: " + pose);
  println(" stop pose detection");

  context.stopPoseDetection(userId); 
  context.requestCalibrationSkeleton(userId, true);
}

void onEndPose(String pose, int userId)
{
  println("onEndPose - userId: " + userId + ", pose: " + pose);
}

// -----------------------------------------------------------------
// Keyboard events

