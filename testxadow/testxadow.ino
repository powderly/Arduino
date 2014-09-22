#include <Wire.h>

#include "xadow.h"

void setup()
{
    Xadow.init();
}


void loop()
{
    Xadow.greenLed(LEDON);                  // green led on
    Xadow.redLed(LEDOFF);                   // red led off
    delay(200);
    Xadow.redLed(LEDON);                    // red led on
    Xadow.greenLed(LEDOFF);                 // green led off
    delay(200);
}
