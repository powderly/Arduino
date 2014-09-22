#include <PinChangeInt.h>
#include <PinChangeIntConfig.h>

#include <eHealth.h>
#include <eHealthDisplay.h>



int cont = 0; 

void setup() { 
  Serial.begin(115200); 
  eHealth.initPulsioximeter(); 
  //Attach the inttruptions for using the pulsioximeter. 
  PCintPort::attachInterrupt(6, readPulsioximeter, RISING); 
} 

void loop() { 
  Serial.println("=======PULSE and PULSEOX================");
  Serial.print("PRbpm : "); 
  Serial.print(eHealth.getBPM()); 
  Serial.print(" %SPo2 : "); 
  Serial.print(eHealth.getOxygenSaturation()); 
  Serial.print("\n"); 

  Serial.println("========ECG============");
  float ECG = eHealth.getECG();\
  Serial.print("ECG value :  ");
  Serial.print(ECG, 2); 
  Serial.print(" V"); 
  Serial.println(""); 
  delay(1);	// wait for a millisecond 

  Serial.println("========TEMP============");
  float temperature = eHealth.getTemperature();
  Serial.print("Temperature (ºC): ");       
  Serial.print(temperature, 2);  
  Serial.println(""); 
 
  delay(500); 
} 

//Include always this code when using the pulsioximeter sensor //========================================================================= 
void readPulsioximeter(){ 
  cont ++; 
  if (cont == 50) { 
    //Get only one 50 measures to reduce the latency 
    eHealth.readPulsioximeter();
    cont = 0; 
  } 
} 


