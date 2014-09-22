#include <SPI.h>
#include <WiFi.h>
#include <WiFiUdp.h>

#include <FreeSixIMU.h>
#include <FIMU_ADXL345.h>
#include <FIMU_ITG3200.h>
#define DEBUG
#ifdef DEBUG
#include "DebugUtils.h"
#endif

#include "CommunicationUtils.h"
#include "FreeSixIMU.h"
#include <Wire.h>

// Set WIFI
char ssid[] = "LavianRose"; //  your network SSID (name) 
char pass[] = "qwertasdfg";   // your network password (use for WPA, or use as key for WEP)
int status = WL_IDLE_STATUS;

//WiFiServer server(23);
WiFiUDP Udp;
char packetBuffer[255];
char ReplyBuffer[255];
IPAddress remoteIp;
int rmtPort;

// Set the FreeIMU object
FreeSixIMU my3IMU = FreeSixIMU();
float q[4]; //hold q values
float angles[3];
float acc[3];

//
int LED = 9;
int BUTTON = 8;
int dig8=0;


boolean alreadyConnected = false; // whether or not the client was connected previously
boolean isSending = false;
String command;
int pcount=0;

void setup() {

  //Initialize serial and wait for port to open:
  Serial.begin(9600); 
  //--------IMU-------------------------------------------------------------
//  Wire.begin();
//  delay(5);
//  my3IMU.init();
//  delay(5);
  //---------WIFI------------------------------------------------------------

  // check for the presence of the shield:
  if (WiFi.status() == WL_NO_SHIELD) {
    Serial.println("WiFi shield not present"); 
    // don't continue:
    while(true);
  } 
  // attempt to connect to Wifi network:
  while ( status != WL_CONNECTED) { 
    Serial.print("Attempting to connect to SSID: ");
    Serial.println(ssid);
    // Connect to WPA/WPA2 network. Change this line if using open or WEP network:    
    status = WiFi.begin(ssid, pass);
    // wait 1 seconds for connection:
    delay(1000);
  } 
  // start the server:
  //server.begin();
  Udp.begin(23);
  // you're connected now, so print out the status:
  printWifiStatus();

  //Button Test
  pinMode(LED, OUTPUT);
  pinMode(BUTTON, INPUT); 
}


void loop() {
  //--------IMU-------------------------------------------------------------
  
  // Get Quaternion
  //my3IMU.getQ(q);
  //serialPrintFloatArr(q, 4);

  //Get Euler and Accelometer
  //my3IMU.getEuler(angles);
  //my3IMU.getYawPitchRoll(angles);
  //my3IMU.getValues(acc);
  delay(60);
  //
  
  int val = digitalRead(BUTTON); 
  if(val == HIGH){
    digitalWrite(LED,HIGH);
    dig8 = 1;
  } 
  else {
    digitalWrite(LED,LOW);
    dig8 = 0;
  }

  //---------WIFI------------------------------------------------------------


  int packetSize = Udp.parsePacket();

  // Read Packet
  if(packetSize)
  {  
    remoteIp = Udp.remoteIP();
    rmtPort = Udp.remotePort();

    // read the packet into packetBufffer
    int len = Udp.read(packetBuffer,255);
    if (len >0) packetBuffer[len]=0;


    //    Serial.print("Received packet of size ");
    //    Serial.print(packetSize);
    //    Serial.print(" From ");
    //    Serial.print(remoteIp);
    //    Serial.print(", port ");
    //    Serial.println(Udp.remotePort());
    //    Serial.println("Contents:");
    //    Serial.println(packetBuffer);

    if (String(packetBuffer) == "S"){
      isSending = true;
      sendStr("##001$");
    } 
    else if (String(packetBuffer) == "T"){
      isSending = false;
      sendStr("##000$");
    } 
    else if (String(packetBuffer) == "D"){
      // Write Packet
      if(isSending) {

        Udp.beginPacket(remoteIp, rmtPort);
        
//        pcount++;
//        Serial.println(pcount);
//        Udp.print(pcount);
        // Sensor Value Writing ---------------------
        for(int i=0; i<3; i++) {
          char a[10];
          dtostrf(angles[i],0,2,a);
          Udp.print(a);
          Udp.print(",");
        }
        for(int i=0; i<3; i++) {
          char a[10];
          dtostrf(acc[i],0,2,a);
          Udp.print(a);
          Udp.print(",");
        }
        // Sensor Value Writing ---------------------
        Udp.print(":");
        Udp.print(dig8);

        Udp.print("$");
        Udp.endPacket();
        Udp.flush();
      }
    }
  }
  
 

  //-------------------------------------------------------------------------

}

void sendStr(String str) {
  Udp.beginPacket(remoteIp, rmtPort);
  Udp.print(str);
  Udp.endPacket();
  Udp.flush();
  Serial.println(str);
}

void printWifiStatus() {
  // print the SSID of the network you're attached to:
  Serial.print("SSID: ");
  Serial.println(WiFi.SSID());

  // print your WiFi shield's IP address:
  IPAddress ip = WiFi.localIP();
  Serial.print("IP Address: ");
  Serial.println(ip);

  // print the received signal strength:
  long rssi = WiFi.RSSI();
  Serial.print("signal strength (RSSI):");
  Serial.print(rssi);
  Serial.println(" dBm");
}














