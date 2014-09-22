

// SRFO2 sensor read and print module
// Powderly & Lee for Black Box
// Based on code by Tom Igoe

#include <Wire.h>

// defs for commands needed for the SRF sensors:

#define sensorAddress 0x70

#define readInches 0x50

// we will use centimeters
#define readCentimeters 0x51

#define readMicroseconds 0x52

// def for the memory register in the sensor that contains the result:
#define resultRegister 0x02

// delay value for sensor reading and commanding
#define sensorDelay 500
#define loopDelay 100

int relayPin=2;
int value = LOW;
long previousMillis = 0;
long relayInterval = 1000;

// global variables

// setup routine
void setup()
{
  // start the I2C bus
  Wire.begin();

  // open the serial port:
  Serial.begin(9600);
  
  // set up output pin
  pinMode (relayPin, OUTPUT);
}

void loop()
{
 //loop variables
  unsigned int sensorVal;
  
  if (Serial.available() > 0) {
    relayInterval = Serial.read() - '0';
    delay (20);
  }
  
  if (millis() - previousMillis > relayInterval) {
    previousMillis = millis(); 
    
    if (value == LOW)
      value = HIGH;
    else
      value = LOW;
    Serial.println (relayInterval);
    digitalWrite(relayPin, value);
  }
  
  //sensorVal=GetSensorData();
  
  //printSensorData(sensorVal);
  
  // wait before next reading:
  //delay(loopDelay);
}

/*

printData prints the sensor data to the serial monitor for diagnotic purposes

*/

void printSensorData(int printVal)
{
// print the sensor Value passed into the function
  Serial.print(printVal);
  Serial.println(" inches");
}

/*

GetSensorData commands the SRF02 and reads the data from the sensor

*/
int GetSensorData()
{
// send the command to read the result in inches:
  sendCommand(sensorAddress, readInches);

  // wait at least 70 milliseconds for a result:
  delay(sensorDelay);

  // sets the register that you want to read the result from:
  setRegister(sensorAddress, resultRegister);

// read the result:
  int sensorReading = readData(sensorAddress, 2);
  
  return sensorReading;
 }
  
/*

  SendCommand() sends commands in the format that the SRF sensors expect

 */

void sendCommand (int address, int command) 
{
  // start I2C transmission:
  Wire.beginTransmission(address);
  
  // send 2-byte command:
  Wire.send(0x00);
  Wire.send(command);

  // end I2C transmission:
  Wire.endTransmission();
}

/*

  setRegister() tells the SRF sensor to change the address pointer position

 */
void setRegister(int address, int thisRegister) 
{
  // start I2C transmission:
  Wire.beginTransmission(address);

  // send address to read from:
  Wire.send(thisRegister);

  // end I2C transmission:
  Wire.endTransmission();
}

/*

readData() returns a result from the SRF sensor

 */

int readData(int address, int numBytes) 
{
  int result = 0;        // the result is two bytes long
// send I2C request for data:

  Wire.requestFrom(address, numBytes);
  // wait for two bytes to return:

  while (Wire.available() < 2 )   {
    // wait for result
  }

  // read the two bytes, and combine them into one int:
  result = Wire.receive() * 256;
  result = result + Wire.receive();

  // return the result:
  return result;
}

/*
int smooth(int data, float filterVal, float smoothedVal){


  if (filterVal > 1){      // check to make sure param's are within range
    filterVal = .99;
  }
  else if (filterVal <= 0){
    filterVal = 0;
  }

  smoothedVal = (data * (1 - filterVal)) + (smoothedVal  *  filterVal);

  return (int)smoothedVal;
}
*/
