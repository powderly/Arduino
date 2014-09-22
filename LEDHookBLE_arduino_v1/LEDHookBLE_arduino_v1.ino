
#include <Wire.h>
#include "xadow.h"
#define SerialBaud   9600
#define Serial1Baud  9600

int crystal = 3; // analogwrite on analog pin5
int brightness = 0;    // set initial brightness
int fadeAmount = 5;    // set initial step interval
int frameDelay = 30;
int pause = 1000;
int mode = 0;

void setup()
{
  Xadow.init();
  Serial1.begin(Serial1Baud);
  // set slave mode
  Serial1.print("AT+ROLE0");
  delay(1000);
  pinMode(crystal, OUTPUT);
  Serial1.print("Connected + Ready");
  //setup the vibrating motor
  DDRF |= 0x01;	
  DDRB |= 0x04;
}

void loop(){
    char invar = Serial1.read();
    Xadow.greenLed(LEDON); 
    checkIncoming(invar);
    setOutputMode();
    Serial1.print(mode);
}

void crystalFader(int pin, int fade_step, int dly, int highpause, int lowpause){
      delay(dly);
      analogWrite(pin, brightness);
      brightness = brightness + fadeAmount;
      if (brightness == 0){  
        digitalWrite(pin,LOW);
        delay(lowpause);
        fadeAmount = -fade_step;
      } else if(brightness == 255) {       
        delay(highpause);
        fadeAmount = -fade_step;
      }
      delay(dly);
}

void setOutputMode(){
      switch (mode) {
            case 1:
              //fade
              crystalFader(crystal, fadeAmount, frameDelay, pause, pause);
              break;
            case 2:
              //flash
              crystalFader(crystal, fadeAmount*2, frameDelay/2, 10, 10);
              break;
            case 3:
              //on
              digitalWrite(crystal, HIGH);
              break;
            case 4:
              //vibration
              vibrate(1000);
              break;
            case 5:
              //off
              digitalWrite(crystal, LOW);
              break;
          default: 
              break;
    }
}

void checkIncoming(int v){
      switch (v) {
            case 'a':
              //fade
              mode=1;
              break;
            case 'b':
              //flash
              mode=2;
              break;
            case 'c':
              //on
              mode=3;
              break;
            case 'd':
              //off
              mode=4;
              break;
            case 'e':
              //off
              mode=5;
              break;
          default: 
              mode=mode;
    }
}

void vibrate(int vdly){
  //turn on the vibration motor	
  PORTF |= 0x01;	
  PORTB |= 0x04;	
  delay(vdly);	
//turn off the vibration motor	
  PORTF &= ~(0x01);	
  PORTB &= ~(0x04);	
  delay(vdly);
}
