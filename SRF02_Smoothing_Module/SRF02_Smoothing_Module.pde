

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

// the size of our array of sensor values, used to remove noise from the sensor and always select the smallest sensor value delta
#define arraySize 10

//Global Variable
// array of sensor values
unsigned int sensorValArray[arraySize] = {0,1,2,3,4,5,6,7,8,9};
// pointer to sensor value array
unsigned int* parrayVal = sensorValArray;
unsigned int sensorVal=0;


// setup routine
void setup()
{
  // start the I2C bus
  Wire.begin();

  // open the serial port:
  Serial.begin(9600);
}

void loop()
{
 //loop variables
  // sensor value
  
  printArray(parrayVal);
  
 for (unsigned int i = 100; i < 150; i++)
 {
  //sensorVal=GetSensorData;
  //printSensorData(sensorVal);
  parrayVal = refreshSensorArray(10, sensorValArray);
  printArray(parrayVal);
 }
  // wait before next reading:
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
unsigned int GetSensorData()
{
// send the command to read the result in inches:
  sendCommand(sensorAddress, readInches);

  // wait at least 70 milliseconds for a result:
  delay(sensorDelay);

  // sets the register that you want to read the result from:
  setRegister(sensorAddress, resultRegister);

// read the result:
  unsigned int sensorReading = readData(sensorAddress, 2);
  
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

unsigned int readData(int address, int numBytes) 
{
// send I2C request for data:
  Wire.requestFrom(address, numBytes);
  // wait for two bytes to return:

  while (Wire.available() < 2 )   {
    // wait for result
  }

  // read the two bytes, shift the first resut over 8 places and combine it with the next incoming byte using ogica or
  //the result is that you combine the two bytes into one unsigned 16 bit unsigned int and return it
  unsigned int result = ((Wire.receive() << 8) | Wire.receive());
  return result;
}

unsigned int* refreshSensorArray(unsigned int newVal, unsigned int *pvalArray)
{
  pvalArray = pvalArray+1;
  //*(pvalArray + (arraySize-1)) = 10;
  Serial.println("hi");
  
  return pvalArray;
}

/*
printArray prints the current sensor value array
*/

void printArray( unsigned int *pvalArray)
{
 for (int i=0; i<arraySize; i++)
  {
    Serial.println(*(pvalArray + i));
    delay(200);
  } 
}
/*

GetLowestSensorVal is a function that takes an array of sensor values, traverses it and finds the lowest value
This function removes noise from the sensor caused by that fact that the sensor
return distances greater than the objects in its field thanks to errant pings and pangs returning to the transducer


unsigned int GetLowestSensorVal(unsigned int newVal, unsigned int valArray[arraySize])
{


return newVal;
}
*/
