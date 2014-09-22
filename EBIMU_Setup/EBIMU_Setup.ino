#include <SoftwareSerial.h>

SoftwareSerial mySerial(2, 3); // RX, TX
int numChar = 0;
int index = 0;

void setup() {
  Serial.begin(9600);
  //pinMode(2, INPUT);
  //pinMode(3, OUTPUT);
  mySerial.begin(9600);
  
  // setup IMU
  delay(500);
  //mySerial.print("<lf>");
  //mySerial.print("<sb5>");
  //mySerial.print("<sor100>");
  //mySerial.print("<soa1>");
  //mySerial.print("<cmco>");
  //mySerial.print("<cmo>");
  //mySerial.print("<sof1>");
}

void loop() {
  if(mySerial.available()>0){
    numChar = mySerial.available();
    char buffer[256];
    buffer[numChar] = '\0';
    
    for(index = 0;index<numChar;index++){
      buffer[index] = mySerial.read();
    }
    
    Serial.print(buffer);
  }
}

