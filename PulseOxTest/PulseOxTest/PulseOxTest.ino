
include <PinChangeInt.h>
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
  Serial.print("PRbpm : "); 
  Serial.print(eHealth.getBPM()); 
  Serial.print(" %SPo2 : "); 
  Serial.print(eHealth.getOxygenSaturation()); 
  Serial.print("\n"); 
  Serial.println("============================="); 
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


