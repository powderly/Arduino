#include <SPI.h>
#include <WiFi.h>

char ssid[] = "SEDGMobile"; //  your network SSID (name) 
char pass[] = "12345678";   // your network password (use for WPA, or use as key for WEP)

//char ssid[] = "SEDG"; //  your network SSID (name) 
//char pass[] = "01043185805"; 

int status = WL_IDLE_STATUS;

WiFiServer server(23);

boolean alreadyConnected = false; // whether or not the client was connected previously


/* timer variables */
unsigned long currentMillis;        // store the current value from millis()
unsigned long previousMillis;       // for comparison with currentMillis
int samplingInterval = 19;          // how often to run the main loop (in ms)
byte ana0,ana1,ana2,ana3,ana4,ana5;

const int pingPin = 4;
void setup() {
  //Initialize serial and wait for port to open:
  Serial.begin(9600); 
  while (!Serial) {
    ; // wait for serial port to connect. Needed for Leonardo only
  }

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

    // wait 10 seconds for connection:
    delay(1000);
  } 
  // start the server:
  server.begin();
  // you're connected now, so print out the status:
  printWifiStatus();
}


void loop() {

  // For Ultrasonic Sensor (will be replaced)
  long duration, inches, cm;
  pinMode(pingPin, OUTPUT);
  digitalWrite(pingPin, LOW);
  delayMicroseconds(2);
  digitalWrite(pingPin, HIGH);
  delayMicroseconds(5);
  digitalWrite(pingPin, LOW);
  pinMode(pingPin, INPUT);
  duration = pulseIn(pingPin, HIGH);
  inches = microsecondsToInches(duration);
  cm = microsecondsToCentimeters(duration);

  delay(100);
  // wait for a new client:
  WiFiClient client = server.available();
  // when the client sends the first byte, say hello:
  if (client) {
    if (!alreadyConnected) {
      // clead out the input buffer:
      client.flush();    
      Serial.println("Client Connected");
      client.println("Server Opened"); 
      alreadyConnected = true;
    } 
    if (client.available() > 0) {
      //char thisChar = client.read();
      // echo the bytes back to the client:

      // echo the bytes to the server as well:
      //Serial.println(thisChar);

      //client.flush();
      ana0 = cm;//analogRead(0);
      ana1 = ;//analogRead(1);
      ana2 = 0;//analogRead(2);
      ana3 = 0;//analogRead(3);
      ana4 = 0;//analogRead(4);
      ana5 = 0;//analogRead(5);

      server.print(ana0);
      server.print(":");
      server.print(ana1);
      server.print(":");
      server.print(ana2);
      server.print(":");
      server.print(ana3);
      server.print(":");
      server.print(ana4);
      server.print(":");
      server.print(ana5);
      server.print("$");
      client.flush();
    }
  } 
  else {
    if (alreadyConnected) {
      // clead out the input buffer:
      client.flush();    
      Serial.println("Client disconnected");
      alreadyConnected = false;
    } 
  }
  //Serial.print(cm);
  //       Serial.print(",");
  //       Serial.print(ana1);
  //       Serial.print(",");
  //       Serial.print(ana2);
  //       Serial.print(",");
  //       Serial.print(ana3);
  //Serial.println("$");
  /*
    currentMillis = millis();
   if (currentMillis - previousMillis > samplingInterval) {
   previousMillis += samplingInterval;
   // BroadCasting
   }
   */

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
long microsecondsToInches(long microseconds)
{
  // According to Parallax's datasheet for the PING))), there are
  // 73.746 microseconds per inch (i.e. sound travels at 1130 feet per
  // second).  This gives the distance travelled by the ping, outbound
  // and return, so we divide by 2 to get the distance of the obstacle.
  // See: http://www.parallax.com/dl/docs/prod/acc/28015-PING-v1.3.pdf
  return microseconds / 74 / 2;
}

long microsecondsToCentimeters(long microseconds)
{
  // The speed of sound is 340 m/s or 29 microseconds per centimeter.
  // The ping travels out and back, so to find the distance of the
  // object we take half of the distance travelled.
  return microseconds / 29 / 2;
}




