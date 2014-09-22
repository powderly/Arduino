 #include "WS2801.h"

int dataPin1 = 2;       // 'blue' wire
int clockPin1 = 3;      // 'red' wire

int dataPin2 = 4;
int clockPin2 = 5;

int dataPin3 = 6;
int clockPin3 = 7;

int dataPin4 = 8;
int clockPin4 = 9 ;

int offset=10;


WS2801 strip1 = WS2801(55, dataPin1, clockPin1);
WS2801 strip2 = WS2801(55, dataPin2, clockPin2);
WS2801 strip3 = WS2801(55, dataPin3, clockPin3);
WS2801 strip4 = WS2801(55, dataPin4, clockPin4);

void setup() {
    
  strip1.begin();
  strip2.begin();
  strip3.begin();
  strip4.begin();

  strip1.show();
  strip2.show();
  strip3.show();
  strip4.show();
  
}


void loop() {
  
  //colorWipe(strip1,Color(colorc, 0, 0), 1);
  //colorc++;
  //if(colorc>254){
    //colorc=254;
  //}
  
  //colorWipe(strip1, strip2, strip3, strip4, Color(255, 0, 0), Color(255,255,255), 1); //blue
  
  //colorWipeAll(strip1, strip2, strip3, strip4, Color(0, 255, 0), Color(255, 0, 0), Color(0, 0, 255), Color(255, 255, 255), 10);
  //colorWipe(Color(0, 255, 0), 50);
  //colorWipe(Color(0, 0, 255), 50);
  for(int beat = 0; beat < 5; beat ++){
    setColor(strip1,1, Color(255,255,255));
    setColor(strip2,1, Color(255,255,255));
    setColor(strip3,1, Color(255,255,255));
    setColor(strip4,1, Color(255,255,255));
  
    setColor(strip1,1, Color(0,0,0));
    setColor(strip2,1, Color(0,0,0));
    setColor(strip3,1, Color(0,0,0));
    setColor(strip4,1, Color(0,0,0));
  }
  
  delay(random(1000, 5000));
  
  //setColor(strip5, 20, 200 );
  
 // rainbow(20);
 // rainbowCycle(20);
 //delay(random(1000, 5000));
}

void rainbow(uint8_t wait) {
  int i, j;
   
  for (j=0; j < 1; j++) {     // 3 cycles of all 256 colors in the wheel
    for (i=0; i < strip2.numPixels(); i++) {
      strip2.setPixelColor(i, Wheel( (i + j) % 150));
    }  
    strip2.show();   // write all the pixels out
    delay(wait);
  }
}

void setColor(WS2801 w, uint8_t wait, int c) {
  int i, j;
  for (i=0; i < w.numPixels(); i++) {
    w.setPixelColor(i, Wheel(c));
  }  
  w.show();   // write all the pixels out
  delay(wait);
}

void setColor(WS2801 w, uint8_t wait, uint32_t c) {
  int i, j;
  for (i=0; i < w.numPixels(); i++) {
    w.setPixelColor(i, c);
  }  
  w.show();   // write all the pixels out
  delay(wait);
}

// Slightly different, this one makes the rainbow wheel equally distributed 
// along the chain
void rainbowCycle(uint8_t wait) {
  int i, j;
  
  for (j=0; j < 256 * 5; j++) {     // 5 cycles of all 25 colors in the wheel
    for (i=0; i < strip1.numPixels(); i++) {
      // tricky math! we use each pixel as a fraction of the full 96-color wheel
      // (thats the i / strip.numPixels() part)
      // Then add in j which makes the colors go around per pixel
      // the % 96 is to make the wheel cycle around
      strip2.setPixelColor(i, Wheel( ((i * 256 / strip1.numPixels()) + j) % 256) );
    }  
    strip2  .show();   // write all the pixels out
    delay(wait);
  }
}

// fill the dots one after the other with said color
// good for testing purposes
void colorWipe(WS2801 w1, WS2801 w2, WS2801 w3, WS2801 w4, uint32_t c1, uint32_t c2, uint8_t wait) {
  int i;
  
  for (i=0; i < w1.numPixels()+(offset*3); i++) {
      w1.setPixelColor(i, c2);
      if(i>offset){
        w2.setPixelColor(i-offset, c2);
      }
      
      if(i>offset*2){
        w3.setPixelColor(i-offset*2, c2);
      }
      
      if(i>offset*3){
        w4.setPixelColor(i-offset*3, c2);
      }
      
      w1.show();
      
      w2.show();
      
      w3.show();
      
      w4.show();
      /*if(i>offset){
        w2.show();
      }
      if(i>offset*2){
        w3.show();
      }
      if(i>offset*3){
      w4.show();
      }*/
      
      delay(wait);
      w1.setPixelColor(i, 0);
      w1.show();
/*      if(i>offset){
        w2.setPixelColor(i-offset, 0);
        w2.show();
      }
      if(i>offset*2){
        w3.setPixelColor(i-offset*2, 0);
        w3.show();
      }
      if(i>offset*3){
        w4.setPixelColor(i-offset*3, 0);
        w4.show();
      }    */
      
      for(int j = 0; j<i; j++){
                w1.setPixelColor(i, 0);
                w2.setPixelColor(i, 0);
                w3.setPixelColor(i, 0);
                w4.setPixelColor(i, 0); 
      }
      w1.show();
      
      w2.show();
      
      w3.show();
      
      w4.show();
  }
}

void colorWipeAll(WS2801 w1, WS2801 w2, WS2801 w3, WS2801 w4, uint32_t c1, uint32_t c2, uint32_t c3, uint32_t c4, uint8_t wait) {
  int i;
  
  for (i=0; i < w1.numPixels(); i++) {
      w1.setPixelColor(i, c1); 
      w2.setPixelColor(i, c2);
      w3.setPixelColor(i, c3);
      w4.setPixelColor(i, c4);
      w1.show();
      w2.show();
      w3.show();
      w4.show();
      delay(wait);
  }
}

/* Helper functions */

// Create a 24 bit color value from R,G,B
uint32_t Color(byte r, byte g, byte b)
{
  uint32_t c;
  c = r;
  c <<= 8;
  c |= g;
  c <<= 8;
  c |= b;
  return c;
}

//Input a value 0 to 255 to get a color value.
//The colours are a transition r - g -b - back to r
uint32_t Wheel(byte WheelPos)
{
  if (WheelPos < 85) {
   return Color(WheelPos * 3, 255 - WheelPos * 3, 0);
  } else if (WheelPos < 170) {
   WheelPos -= 85;
   return Color(255 - WheelPos * 3, 0, WheelPos * 3);
  } else {
   WheelPos -= 170; 
   return Color(0, WheelPos * 3, 255 - WheelPos * 3);
  }
}
