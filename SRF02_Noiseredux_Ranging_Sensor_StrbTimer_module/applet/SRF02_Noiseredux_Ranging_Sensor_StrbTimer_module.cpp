
// SRFO2 sensor read, adjust, range, timing and print module
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
#define loopDelay 250
#define sensorInterval 100
#define threshold 80
#define relayPin 12

// the size of our array used for smoothing data and removing noise
#define arraySize 10
//MIN_MAX ranges for the sensor and the strobe
#define SENSOR_MIN 10
#define SENSOR_MAX 109
#define STROBE_MIN 50
#define STROBE_MAX 1000

//Global Variable
// array of sensor values initiaized to have
#include "WProgram.h"
void setup();
void loop();
boolean sensorUpdateReady();
void printSensorData(signed int printVal);
int GetSensorData();
void sendCommand (int address, int command);
void setRegister(int address, int thisRegister);
int readData(int address, int numBytes);
void printArray( unsigned int *pvalArray);
void refreshSensorArray(unsigned int newVal);
unsigned int getLowestSensorVal(unsigned int newVal);
void initArray();
unsigned int sensorValArray[arraySize];
// pointer to sensor value array
unsigned int* parrayVal = sensorValArray;
unsigned int sensorVal=0;
unsigned int lowestSensorVal=0;
unsigned int rangedSensorVal=0;
unsigned int previousSensorMillis=0;

// setup routine
void setup()
{
  // start the I2C bus
  Wire.begin();

  // open the serial port:
  Serial.begin(9600);
  initArray();
   pinMode (relayPin, OUTPUT);
  Serial.println("Black Box coming online now");
}

void loop()
{
 //loop variables
  
  if(sensorUpdateReady())
  {
    sensorVal=GetSensorData();
    refreshSensorArray(sensorVal);
    lowestSensorVal=getLowestSensorVal(sensorVal);
    //rangedSensorVal = map(lowestSensorVal, SENSOR_MIN, SENSOR_MAX, STROBE_MIN, STROBE_MAX);
    printSensorData (lowestSensorVal);  
  }

if (lowestSensorVal > threshold)
{
  digitalWrite(relayPin, LOW);
  Serial.print('L');
}

if (lowestSensorVal < threshold)
{
  Serial.print('H');
  digitalWrite(relayPin, HIGH);
}

  delay(loopDelay);
}

/*

sensorUpdateReady checks the timer to see if the sensor is ready for an update
every 70ms

*/

boolean sensorUpdateReady()
{
  boolean ready = false; 
  if (millis() - previousSensorMillis > sensorInterval) 
  {
    previousSensorMillis = millis(); 
    ready = true;
   }
  return ready;  
}


/*

printData prints the sensor data to the serial monitor for diagnotic purposes

*/

void printSensorData(signed int printVal)
{
// print the sensor Value passed into the function
  Serial.println(printVal);
}

/*

GetSensorData commands the SRF02 and reads the data from the sensor

*/
int GetSensorData()
{
// send the command to read the result in inches:
  sendCommand(sensorAddress, readInches);

  // wait at least 70 milliseconds for a result:
  // deprecated thanks to sensorUpdateReady
  // delay(sensorDelay);

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
  return ((Wire.receive() << 8) | Wire.receive());
}
/*
printArray prints the current sensor value array
*/

void printArray( unsigned int *pvalArray)
{
 for (int i=0; i<arraySize; i++)
  {
    Serial.print("SensorValArray["); 
    Serial.print(i);
    Serial.print("] =");
    Serial.println (sensorValArray[i]);
    delay(500);
  } 
}

/* 

refreshSensorArray is a really dumb version of a queue that shifts the contents
of the array over by one and adds the new sensor value so we can find the lowest
sensor return and remove some of the noise... a pointer version coming as soon as i have time...
leave me alone im just an artist

*/

void refreshSensorArray(unsigned int newVal)
{
  //move through the array 4 times shifting the first position out
  //and shifting the other values down one place
  if (newVal>0)
  {
    for (int j =0; j< (arraySize-1); j++)
    { 
      sensorValArray[j] = sensorValArray[j+1];
     }
    sensorValArray[arraySize-1]=newVal;    
  }
}


/*

GetLowestSensorVal is a function that takes an array of sensor values, traverses it and finds the lowest value
This function removes noise from the sensor caused by that fact that the sensor
return distances greater than the objects in its field thanks to errant pings and pangs returning to the transducer

*/

unsigned int getLowestSensorVal(unsigned int newVal)
{
 
  unsigned int lowestVal=1000;
  for (int x=0;x<arraySize;x++)
  {
    signed int mintest = sensorValArray[x];
    lowestVal = min(lowestVal, mintest);
    //Serial.print("lowest value is ");
    //Serial.println(sensorValArray[x]);  
    //Serial.print("adjusted sensor value= ");
    //Serial.println(lowestVal);
}  
  
return lowestVal;
}

/*

initArrayt fills the array with dummy values in our case the number 1000

*/

void initArray()
{
  for(int i=0; i<arraySize; i++)
  {
    sensorValArray[i]=1000;
  }
}

int main(void)
{
	init();

	setup();
    
	for (;;)
		loop();
        
	return 0;
}

