/*
 Fade
 
 This example shows how to fade an LED on pin 9
 using the analogWrite() function.
 
 This example code is in the public domain.
 
 */
int brightness = 0;    // how bright the LED is
int fadeAmount = 5;    // how many points to fade the LED by

const int REDLED=6;
const int GREENLED=5;
const int BLUELED=4;

const int WHITELED1 = 17;
const int WHITELED2 = 18;

const int SW1=14;
const int SW2=15;
const int SW3=16;

const int ELWIRE=7;

int sw1Status =0;
int sw2Status =0;
int sw3Status =0;

int mode = 0;
int ELStatus =0;
int WHITELEDStatus=0;

void setup()  { 
  // declare pin 9 to be an output:
  pinMode(REDLED, OUTPUT);
  pinMode(GREENLED, OUTPUT);
  pinMode(BLUELED, OUTPUT);
  pinMode(ELWIRE, OUTPUT);
  
  pinMode(WHITELED1, OUTPUT);
  pinMode(WHITELED2, OUTPUT);
  
  pinMode(SW1, INPUT);
  pinMode(SW2, INPUT);
  pinMode(SW3, INPUT);
  
  Serial.begin(9600); 
    
} 

void loop(){ 
  setMode();
 
 switch (mode){
    case 0:
      digitalWrite(ELWIRE, LOW);
      break;
    case 1:
      digitalWrite(ELWIRE, LOW);
      fullFade(REDLED, fadeAmount, 30);
      break;
    case 2:
      digitalWrite(ELWIRE, LOW);
      fullFade(WHITELED1, fadeAmount, 30);
      fullFade(WHITELED2, fadeAmount, 30);
      fullFadeWHITELEDS(fadeAmount, 30); 
      break;
    case 3:
      digitalWrite(ELWIRE, LOW);
      fullFade(BLUELED, fadeAmount, 30);
      break;
    case 4:
      ELSwitch();
      fullFade(REDLED, fadeAmount, 10);
      fullFade(BLUELED, fadeAmount, 10);
      fullFade(GREENLED, fadeAmount, 10);
      break;
    case 5:
      ELSwitch();
      WHITELEDswitch();
      delay(200);
      break;
    case 6:
      ELSwitch();
      WHITELEDswitch();
      delay(30);
      break;
    case 7:
    fullFade_ELSTROBE(REDLED, fadeAmount, 30);
    fullFade_ELSTROBE(GREENLED, fadeAmount, 30);
    fullFade_ELSTROBE(BLUELED, fadeAmount, 30);
      break;
  }
}

void setMode(){
  
  checkSwitches();  
  
  if(sw1Status == LOW && sw2Status == LOW && sw3Status == LOW){
    mode = 0;
  }
  
  if(sw1Status == HIGH && sw2Status == LOW && sw3Status == LOW){
    mode = 1;
  }
   if(sw1Status == LOW && sw2Status == HIGH && sw3Status == LOW){
    mode = 2;
  }
  if(sw1Status == LOW && sw2Status == LOW && sw3Status == HIGH){
    mode = 3;
  }
  if(sw1Status == HIGH && sw2Status == HIGH && sw3Status == LOW){
    mode = 4;
  }
  if(sw1Status == HIGH && sw2Status == LOW && sw3Status == HIGH){
    mode = 5;
  }
  if(sw1Status == LOW && sw2Status == HIGH && sw3Status == HIGH){
    mode = 6;
  }
  if(sw1Status == HIGH && sw2Status == HIGH && sw3Status == HIGH){
    mode = 7;
  }
  
    Serial.println(mode);
}

void ELSwitch(){
  if(ELStatus==0){
    ELStatus=1;
  }else if(ELStatus == 1){
    ELStatus = 0;  
  }
  digitalWrite(ELWIRE, ELStatus);
}

void WHITELEDswitch(){
  if(WHITELEDStatus==0){
    WHITELEDStatus=1;
  }else if(WHITELEDStatus == 1){
    WHITELEDStatus = 0;  
  }
    digitalWrite(WHITELED1, WHITELEDStatus);
    digitalWrite(WHITELED2, WHITELEDStatus);
}
void fadeUp(int theLED, int myFade, int fadeSpeed){
   for(int b = 0; b < 255; b+=myFade){;
    analogWrite(theLED, b); 
    delay(fadeSpeed);  
  }
}

void fadeDown(int theLED, int myFade, int fadeSpeed){
  for(int b = 255; b > 0; b-=myFade){
    analogWrite(theLED, b); 
    delay(fadeSpeed);  
  }        
}

void fullFade(int theLED, int myFade, int fadeSpeed){
  for(int b = 0; b < 255; b+=myFade){;
    analogWrite(theLED, b); 
    delay(fadeSpeed);  
  }
  
  for(signed int b = 255; b > -5; b-=myFade){
    analogWrite(theLED, b); 
    delay(fadeSpeed);  
  }                             
}

void fullFade_ELSTROBE(int theLED, int myFade, int fadeSpeed){
   for(int b = 0; b < 255; b+=myFade){;
    analogWrite(theLED, b); 
    delay(fadeSpeed);  
    ELSwitch();
  }
  
  for(signed int b = 255; b > -5; b-=myFade){
    analogWrite(theLED, b); 
    delay(fadeSpeed);
    ELSwitch();  
  }                             
}

void checkSwitches(){
   sw1Status = digitalRead(SW1);
   sw2Status = digitalRead(SW2);
   sw3Status = digitalRead(SW3);
}

void fullFadeWHITELEDS(int myFade, int fadeSpeed){
  for(int b = 0; b < 255; b+=myFade){;
    analogWrite(WHITELED1, b); 
    analogWrite(WHITELED2, b); 
    delay(fadeSpeed);  
  }
  
  for(signed int b = 255; b > -5; b-=myFade){
    analogWrite(WHITELED1, b); 
    analogWrite(WHITELED2, b); 
    delay(fadeSpeed);  
  }                             
}
 
