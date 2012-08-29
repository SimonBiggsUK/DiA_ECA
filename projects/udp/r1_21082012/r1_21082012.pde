import hypermedia.net.*;
//udpTX.send(message,ip,port);
int PORT_RX=0XC350;
String HOST_IP = "172.20.36.161";//IP Address of the PC in which this App is running
String DESTINATION_IP="172.20.36.107";
UDP udp;//Create UDP object for recieving

import java.net.InetAddress;
InetAddress inet;
String myIP;  

PFont font;

void setup(){
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

void draw(){
  

 
} 
void keyPressed(){
  udp.send(str(key),DESTINATION_IP,PORT_RX);
}
void receive(byte[] data, String HOST_IP, int PORT_RX){
 
  String value=new String(data);
  background(50,50,50);
    text(myIP,50,100);
  fill(255,0,0);
  text(value,50,50);
    
}


