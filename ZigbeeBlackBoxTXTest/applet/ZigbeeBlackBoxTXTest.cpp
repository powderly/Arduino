
#include "WProgram.h"
void setup();
void loop();
int outputPin = 12;
int val;

void setup()
{
  Serial.begin(9600);
  pinMode(outputPin, OUTPUT);
}

void loop()
{
  digitalWrite(outputPin, HIGH);
  Serial.write('H');
  delay(1000);
  Serial.write('L');
  digitalWrite(outputPin, LOW);
  delay(3000);
}

int main(void)
{
	init();

	setup();
    
	for (;;)
		loop();
        
	return 0;
}

