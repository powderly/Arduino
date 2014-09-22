
#include <SPI.h>
#include <WiFi.h>
#include <WiFiUdp.h>
#include <SoftwareSerial.h>
// define buttonPin
#define buttonPin 8

// Set WIFI
char ssid[] = "SEDGMobile0"; //  your network SSID (name) 
char pass[] = "12345678";   // your network password (use for WPA, or use as key for WEP)
int status = WL_IDLE_STATUS;

//WiFiServer server(23);
WiFiUDP Udp;
char packetBuffer[255];
char ReplyBuffer[255];
IPAddress remoteIp;
int rmtPort;

boolean alreadyConnected = false; // whether or not the client was connected previously
boolean isSending = false;
boolean readyToSend = false; 

//For IMU, USE Software Serial
SoftwareSerial mySerial(2, 3); // RX, TX
int numChar = 0;
int index = 0;
char buffer[256];

// buttonState
int buttonState = 0;
int sendButtonState = 0;

void setup() {
  //Initialize serial and wait for port to open:
  Serial.begin(9600);
  //--------IMU-------------------------------------------------------------
  mySerial.begin(9600);

  //---------pinMode------------------------------------------------------------
  pinMode(buttonPin, INPUT);

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
  //isSending = true;
}


void loop() {
  // button state
  buttonState = digitalRead(buttonPin);
  if (buttonState == HIGH) {
    sendButtonState = 1;
  } else {
    sendButtonState = 0;
  }
  //
  if(mySerial.available() > 0){

    numChar = mySerial.available();
    buffer[numChar] = '\0';
    for(index = 0;index<numChar;index++){
      buffer[index] = mySerial.read();
    }
    if(isSending) {
      Udp.beginPacket(remoteIp, rmtPort);
      // IMU Writing
      Serial.print(buffer);
      Udp.write(buffer);
      Udp.print(":");
      Udp.print(sendButtonState);
      Udp.print("$");
      Udp.endPacket();
      Udp.flush();
    }
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

    if (String(packetBuffer) == "S"){
      isSending = true;
      sendStr("##001$");
    } 
    else if (String(packetBuffer) == "T"){
      isSending = false;
      sendStr("##000$");
    } 
  }
  // Sensor Value Writing --------------------- 
  //Serial.print(buffer);
  //Serial.println(dig8);
  //delay(10);
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


