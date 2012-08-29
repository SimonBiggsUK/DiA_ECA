import processing.core.*; 
import processing.xml.*; 

import hypermedia.net.*; 
import java.net.InetAddress; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class r1_21082012 extends PApplet {


//udpTX.send(message,ip,port);
int PORT_RX=0XC350;
String HOST_IP = "172.20.36.161";//IP Address of the PC in which this App is running
String DESTINATION_IP="172.20.36.107";
UDP udp;//Create UDP object for recieving


InetAddress inet;
String myIP;  

PFont font;

public void setup(){
  size(800,600);
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
  textFont(font,24);
  fill(255,0,0);
  text(myIP,100,50);
  HOST_IP=myIP;
  udp= new UDP(this, PORT_RX, HOST_IP);
  udp.log(true);
  udp.listen(true);
  udp.send("aaaaar",DESTINATION_IP,PORT_RX);
}

public void draw(){
  

 
} 
public void keyPressed(){
  udp.send(str(key),DESTINATION_IP,PORT_RX);
}
public void receive(byte[] data, String HOST_IP, int PORT_RX){
 
  String value=new String(data);
  background(50,50,50);
    text(myIP,50,100);
  fill(255,0,0);
  text(value,50,50);
    
}


  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "r1_21082012" });
  }
}
