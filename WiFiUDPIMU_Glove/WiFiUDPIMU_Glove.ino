#include <SPI.h>
#include <WiFi.h>
#include <WiFiUdp.h>

#include <PinChangeInt.h>
#include <eHealth.h>

///////6DOF
//#include <FreeSixIMU.h>
//#include <FIMU_ADXL345.h>
//#include <FIMU_ITG3200.h>
//#define DEBUG
//#ifdef DEBUG
//#include "DebugUtils.h"
//#endif

//#include "CommunicationUtils.h"
//#include "FreeSixIMU.h"
//#include <Wire.h>

char ssid[] = "SEDGMobile0"; //  your network SSID (name) 
char pass[] = "12345678";   // your network password (use for WPA, or use as key for WEP)

int cont = 0;

int status = WL_IDLE_STATUS;

//UDP Server setup and init
WiFiUDP Udp;
char packetBuffer[255];
char ReplyBuffer[255];
IPAddress remoteIp;
int rmtPort;

// Set the FreeIMU object
//FreeSixIMU my3IMU = FreeSixIMU();
//float q[4]; //hold q values
//float angles[3];
//float acc[3];

//TCP-IP Server Only
//WiFiServer server(23);


//int LED = 9;
//int BUTTON = 8;
//int dig8=0;

boolean alreadyConnected = false; // whether or not the client was connected previously
boolean isSending = false;
String command;

float temperature;
float conductance;
float resistance;
float conductanceVol;  
int bpm;
int os;


/* timer variables */

int samplingInterval = 19;          // how often to run the main loop (in ms)
byte ana0,ana1,ana2,ana3,ana4,ana5;
int b, o;


void setup() {
  //Initialize serial and wait for port to open:
  //Serial.begin(9600); 

  // 6DOF SPI and setup/intit
  //Wire.begin();
  //delay(5);
  //my3IMU.init();
  //delay(5);

  // check for the presence of the shield:
  if (WiFi.status() == WL_NO_SHIELD) {
    //Serial.println("WiFi shield not present"); 
    //don't continue:
    while(true);
  } 

  // attempt to connect to Wifi network:
  while ( status != WL_CONNECTED) { 
    //    Serial.print("Attempting to connect to SSID: ");
    //    Serial.println(ssid);
    // Connect to WPA/WPA2 network. Change this line if using open or WEP network:    
    status = WiFi.begin(ssid, pass);
    //wait 10 seconds for connection:
    delay(1000);
  } 

  //start the UDP Server 
  Udp.begin(23); 
  //start the TCP-IP server:
  //server.begin();
  // you're connected now, so print out the status:
  printWifiStatus();
  delay(250);
  eHealth.initPulsioximeter();
  //Serial.println("Pulsioximeter initialized");
  delay(500);
  //Attach the inttruptions for using the pulsioximeter.   
  PCintPort::attachInterrupt(6, readPulsioximeter, RISING);
  delay(100);

  //button and LED pins for 6DOF home trigger
  //pinMode(LED, OUTPUT);
  //pinMode(BUTTON, INPUT);
}


void loop() {

  //grab the 6DOF angles
  //my3IMU.getYawPitchRoll(angles);
  //my3IMU.getValues(acc);
  //delay(60);

  temperature = eHealth.getTemperature();

  conductance = eHealth.getSkinConductance();
  resistance = eHealth.getSkinResistance();
  conductanceVol = eHealth.getSkinConductanceVoltage();

  bpm = eHealth.getBPM();
  os = eHealth.getOxygenSaturation();

  //-------------WIFI------------------------------
  int packetSize = Udp.parsePacket();

  // Read Packet
  if(packetSize){  
    remoteIp = Udp.remoteIP();
    rmtPort = Udp.remotePort();

    // read the packet into packetBufffer
    int len = Udp.read(packetBuffer,255);
    if (len >0) packetBuffer[len]=0;


    if (String(packetBuffer) == "S"){
      isSending = true;
      sendStr("##001$");
    } 
    else if (String(packetBuffer) == "T"){
      isSending = false;
      sendStr("##000$");
    } 


  }
  // Write Packet
  if(isSending) {

    Udp.beginPacket(remoteIp, rmtPort);

    // Sensor Value Writing ---------------------

    char t[10];
    dtostrf(temperature,0,2,t);
    b = bpm;
    o = os;
    char c[10];
    dtostrf(conductance,0,2,c);

    /*
        for(int i=0; i<3; i++) {
     char an[10];
     dtostrf(angles[i],0,2,an);
     Udp.print(an);
     Udp.print(",");
     } 
     
     for(int i=0; i<3; i++) {
     char ac[10];
     dtostrf(acc[i],0,2,ac);
     Udp.print(ac);
     Udp.print(",");
     }
     
     Udp.print(":");
     */
    Udp.print(t);
    Udp.print(":");
    Udp.print(b);
    Udp.print(":");
    Udp.print(o);
    Udp.print(":");
    Udp.print(c);

    Udp.print("\r\n");
    Udp.endPacket();
    Udp.flush();
  }
  //printDiagnostics();
}

void sendStr(String str) {
  Udp.beginPacket(remoteIp, rmtPort);
  Udp.println(str);
  Udp.endPacket();
  Udp.flush();
  //  Serial.println(str);
}


void printWifiStatus() {
  // print the SSID of the network you're attached to:
  //Serial.print("SSID: ");
  //Serial.println(WiFi.SSID());

  // print your WiFi shield's IP address:
  IPAddress ip = WiFi.localIP();
  //  Serial.print("IP Address: ");
  //  Serial.println(ip);

  // print the received signal strength:
  long rssi = WiFi.RSSI();
  //Serial.print("signal strength (RSSI):");
  //Serial.print(rssi);
  //Serial.println(" dBm");
}

void readPulsioximeter(){  

  cont ++;

  if (cont == 50) { //Get only of one 50 measures to reduce the latency
    eHealth.readPulsioximeter();  
    cont = 0;
  }
}

/*
void printDiagnostics(){
 
 
 Serial.print("    angles : "); 
 //Serial.print(angles);
 
 Serial.print("    acc : ");
 //Serial.print(acc);
 
 rial.println(" ");
 
 Serial.print("PRbpm : "); 
 Serial.print(bpm);
 
 Serial.print("    %SPo2 : ");
 Serial.print(os);
 
 Serial.println(" ");
 
 Serial.print("Temperature (ºC): ");       
 Serial.print(temperature, 2);  
 Serial.println(" "); 
 
 
 if (conductance == -1) {
 Serial.print("Conductance : ");       
 Serial.print(conductance, 2);
 Serial.println(" ");
 } 
 else {
 
 Serial.print("Conductance : ");       
 Serial.print(conductance, 2);  
 Serial.println("");         
 
 Serial.print("Resistance : ");       
 Serial.print(resistance, 2);  
 Serial.println("");    
 
 Serial.print("Conductance Voltage : ");       
 Serial.print(conductanceVol, 4);  
 Serial.println("");
 
 }
 
 Serial.print("\n");  
 Serial.println("============================="); 
 Serial.print("\n");
 
 delay(200);
 
 
 }*/







