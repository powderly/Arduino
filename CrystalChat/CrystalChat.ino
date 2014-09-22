/*

Copyright (c) 2012-2014 RedBearLab

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

*/

/*
 *    Chat
 *
 *    Simple chat sketch, work with the Chat iOS/Android App.
 *    Type something from the Arduino serial monitor to send
 *    to the Chat App or vice verse.
 *
 */

//"services.h/spi.h/boards.h" is needed in every new project
#include <SPI.h>
#include <boards.h>
#include <RBL_nRF8001.h>
#include <services.h> 

void setup()
{  
  // Default pins set to 9 and 8 for REQN and RDYN
  // Set your REQN and RDYN here before ble_begin() if you need
  //ble_set_pins(3, 2);
  
  // Set your BLE Shield name here, max. length 10
  //ble_set_name("My Name");
  
  // Init. and start BLE library.
  ble_begin();
  
  // Enable serial debug
  Serial.begin(57600);
}

unsigned char buf[16] = {0};
unsigned char len = 0;
unsigned char state =0;
 int crystal = 11  ; // analogwrite on analog pin5
int brightness = 0;    // set initial brightness
int fadeAmount = 5;    // set initial step interval
int frameDelay = 30;
int pause = 1000;
int mode = 0;
int lastmode = 0;

void loop()
{
  if ( ble_available() )
  {
    while ( ble_available() ){
      state = ble_read(); Serial.write(state);
    }
    Serial.println();
  }
  
  checkIncoming(state);
  setOutputMode();
  writeNewOuputMode();
  Serial.println(mode);
  //ble_write(mode);
  
  //if ( Serial.available() )
  //{
  //  delay(5);
   // while ( Serial.available() )
   //     ble_write( Serial.read() );
 // }
  
  ble_do_events();
}

void writeNewOuputMode(){
      if(mode == lastmode){
        //do nothing
      }else{
        lastmode = mode;  
        switch (mode) {
              case 1:
                //fade
                ble_write(state);
                break;
              case 2:
                //flash
                ble_write(state);
                break;
              case 3:
                //on
                ble_write(state);
                break;
              case 4:
                ble_write(state);
                break;
              case 5:
                //off
               ble_write(state);
                break;
            default: 
                break;
        }
      }
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
              break;
            case 5:
              //off
              digitalWrite(crystal, LOW);
              break;
          default: 
              break;
    }
}

void checkIncoming(unsigned char v){
      switch (v) {
            case 'k':
              //fade
              mode=1;
              break;
            case 'l':
              //flash
              mode=2;
              break;
            case 'y':
              //on
              mode=3;
              break;
            case 'r':
              //off
              mode=4;
              break;
            case 'f':
              //off
              mode=5;
              break;
          default: 
              mode=mode;
    }
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
