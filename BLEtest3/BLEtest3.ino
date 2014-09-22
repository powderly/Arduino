
#include <Wire.h>
#include "xadow.h"
#define SerialBaud   9600
#define Serial1Baud  9600

void setup()
{
  Xadow.init();
  //Serial.begin(SerialBaud);
  Serial1.begin(Serial1Baud);
  //while(!Serial.available());
// set slave 
  Serial1.print("AT+ROLE0");
  delay(1000);
}

void loop()
{
    Serial1.print("fuck off angelo");
    delay(1000);
    char test = Serial1.read();
    delay(1000);
    
    if (test == 'a'){
     Xadow.greenLed(LEDON);              	// green led on
   // Xadow.redLed(LEDOFF);                	// red led off
     delay(200);
    } else if (test == 'b'){
      Xadow.greenLed(LEDOFF);              	// green led off
      delay(200);
    } 


}

