
#include "WProgram.h"
void setup();
void loop();
int outputPin = 13;
int val;

void setup()
{
  Serial.begin(9600);
  pinMode(outputPin, OUTPUT);
}

void loop()
{
  if (Serial.available()) {
    val = Serial.read();
    Serial.flush();
   }
   
   if (val != 10 && val !=13)
     Serial.println(val, DEC);
     
   delay (50);
}

int main(void)
{
	init();

	setup();
    
	for (;;)
		loop();
        
	return 0;
}

