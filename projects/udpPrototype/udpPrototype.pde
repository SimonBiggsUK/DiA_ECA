//Library for udp
import hypermedia.net.*;
//library for using kinect
import SimpleOpenNI.*;
//getting the host ip. this computer ip address.
import java.net.InetAddress;
InetAddress inet;
String myIP;  
PFont font;
boolean IsKinectAvailable;

String udpMessage="empty";


ArrayList users;

//defining a context for initializing kinect.
SimpleOpenNI  context;

//udpTX.send(message,ip,port);
int DESTINATION_PORT=8105;
int PORT_ME=8105;
String HOST_IP = "172.20.24.161";//IP Address of the PC in which this App is running
String DESTINATION_IP = "172.20.36.117";
UDP udp;//Create UDP object for sending & recieving.


//valuues order in udp package
final static int USERID=0;
final static int JOINT_NAME = 1;
final static int POS_X = 2;
final static int POS_Y = 3;
final static int POS_Z = 4;


//simpleopenni settings
float        zoomF =0.5f;
float        rotX = radians(180);  // by default rotate the hole scene 180deg around the x-axis, 
// the data from openni comes upside down
float        rotY = radians(0);
boolean      autoCalib=true;

void setup() {
  try {    
    inet = InetAddress.getLocalHost();    
    myIP = inet.getHostAddress();
  }  
  catch (Exception e) {    
    e.printStackTrace();   
    println("could not get host ip");
    exit();
  }

  font=loadFont("GillSans.vlw");
  textFont(font, 24);
  HOST_IP = myIP;
  //DESTINATION_IP=myIP;
  size(1024, 768, P3D);
  background(100);
  //creating listener
  udp= new UDP(this, PORT_ME, HOST_IP);
  //  udp.log(true);
  udp.listen(true);
  //creating sender
  //  sender= new UDP(this, PORT_RX, HOST_IP);
  //  sender.log(true);
  //  sender.listen(true);

  //Initializing Kinect,Starting Depth and then skeleton tracking
  context = new SimpleOpenNI(this);

  users=new ArrayList();

  // enable depthMap generation 
  startKinect();
  stroke(0, 0, 255);
  strokeWeight(3);
  smooth();


  setupCamera();


  //    noLoop();
}
// enable depthMap generation 
void startKinect() {
  if (context.enableDepth() == false)
  {
    println("Can't open the depthMap, maybe the camera is not connected!"); 
    //exit();
    IsKinectAvailable=false;
    return;
  }
  IsKinectAvailable=true;

  // enable skeleton generation for all joints
  context.enableUser(SimpleOpenNI.SKEL_PROFILE_ALL);
  context.setMirror(true);
}
void setupCamera() {
  smooth();  
  perspective(radians(45), 
  float(width)/float(height), 
  10, 150000);
  translate(width/2, height/2, 0);
  rotateX(rotX);
  rotateY(rotY);
  scale(zoomF);
  translate(0, 0, -1000);  // set the rotation center of the scene 1000 infront of the camera
}


void draw() {
  // update the cam
  context.update();
  background(120);
      fill(255, 0, 0);
    text(udpMessage, 100, 50);
//    print(udpMessage + " " );

  //  if (frameCount%500==0) {
  //    udp.send("test packet!!" + frameCount, HOST_IP, PORT_RX);
  //  }
  if (IsKinectAvailable) {
    sendSkeleton();
  }

  for (int i = users.size()-1 ; i >=0 ; i--) {
    UserC user = (UserC) users.get(i);
    user.paint();
  }
} 

void sendSkeleton() {
  int[] userList = context.getUsers();
  PVector jointPos = new PVector();
  int userId;
  for (int i=0;i<userList.length;i++)
  {
    userId=userList[i];
    if (context.isTrackingSkeleton(userId)) {

      context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_HEAD, jointPos);
      udp.send(userId + "," + "SKEL_HEAD" + "," + jointPos.x + "," + jointPos.y+ "," + jointPos.z, DESTINATION_IP, DESTINATION_PORT);

      context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, jointPos);
      udp.send(userId + "," + "SKEL_LEFT_SHOULDER" + "," + jointPos.x + "," + jointPos.y+ "," + jointPos.z, DESTINATION_IP, DESTINATION_PORT);
      context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_ELBOW, jointPos);
      udp.send(userId + "," + "SKEL_LEFT_ELBOW" + "," + jointPos.x + "," + jointPos.y+ "," + jointPos.z, DESTINATION_IP, DESTINATION_PORT);
      context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_HAND, jointPos);
      udp.send(userId + "," + "SKEL_LEFT_HAND" + "," + jointPos.x + "," + jointPos.y+ "," + jointPos.z, DESTINATION_IP, DESTINATION_PORT);

      context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, jointPos);
      udp.send(userId + "," + "SKEL_RIGHT_SHOULDER" + "," + jointPos.x + "," + jointPos.y+ "," + jointPos.z, DESTINATION_IP, DESTINATION_PORT);
      context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, jointPos);
      udp.send(userId + "," + "SKEL_RIGHT_ELBOW" + "," + jointPos.x + "," + jointPos.y+ "," + jointPos.z, DESTINATION_IP, DESTINATION_PORT);
      context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_HAND, jointPos);
      udp.send(userId + "," + "SKEL_RIGHT_HAND" + "," + jointPos.x + "," + jointPos.y+ "," + jointPos.z, DESTINATION_IP, DESTINATION_PORT);

      context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_TORSO, jointPos);
      udp.send(userId + "," + "SKEL_TORSO" + "," + jointPos.x + "," + jointPos.y+ "," + jointPos.z, DESTINATION_IP, DESTINATION_PORT);
      context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_HIP, jointPos);
      udp.send(userId + "," + "SKEL_LEFT_HIP" + "," + jointPos.x + "," + jointPos.y+ "," + jointPos.z, DESTINATION_IP, DESTINATION_PORT);
      context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_HIP, jointPos);   
      udp.send(userId + "," + "SKEL_RIGHT_HIP" + "," + jointPos.x + "," + jointPos.y+ "," + jointPos.z, DESTINATION_IP, DESTINATION_PORT);


      context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_KNEE, jointPos);
      udp.send(userId + "," + "SKEL_LEFT_KNEE" + "," + jointPos.x + "," + jointPos.y+ "," + jointPos.z, DESTINATION_IP, DESTINATION_PORT);
      context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_FOOT, jointPos);
      udp.send(userId + "," + "SKEL_LEFT_FOOT" + "," + jointPos.x + "," + jointPos.y+ "," + jointPos.z, DESTINATION_IP, DESTINATION_PORT);

      context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_KNEE, jointPos);      
      udp.send(userId + "," + "SKEL_RIGHT_KNEE" + "," + jointPos.x + "," + jointPos.y+ "," + jointPos.z, DESTINATION_IP, DESTINATION_PORT);
      context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_FOOT, jointPos);
      udp.send(userId + "," + "SKEL_RIGHT_FOOT" + "," + jointPos.x + "," + jointPos.y+ "," + jointPos.z, DESTINATION_IP, DESTINATION_PORT);
    }
  }
}

void stop() {
  udp.close();
  //  reciever.close();
} 

void receive(byte[] data, String HOST_IP, int PORT_RX) {

  String value=new String(data);
  parseMessage(value);
}

void parseMessage(String _message) {
  String[] vals = _message.split(",");
  if (vals.length==5) {
    if (users.size()==0) {
      users.add(new UserC(int(vals[USERID])));
    }
    for (int i = users.size()-1 ; i >=0 ; i --) {
      UserC user = (UserC) users.get(i);
      if (user.mUserId==int(vals[USERID])) {

        //      println(new PVector(float(vals[POS_X]),float(vals[POS_Y]),float(vals[POS_Z])));
        //      println(vals[JOINT_NAME]);
        user.addJoint(vals[JOINT_NAME], new PVector(float(vals[POS_X]), float(vals[POS_Y]), float(vals[POS_Z])));
      }
    }
  }
  else {  
    udpMessage=_message;
  }
}
void keyPressed() {
  udp.send(str(key), DESTINATION_IP, DESTINATION_PORT);
}
void onNewUser(int userId)
{
  println("onNewUser - userId: " + userId);
  println("  start pose detection");
  // users.add(new UserC(userId));
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

