// MY FIRST ARDUINO CODE
// JAMES POWDERLY
// OPEN SOURCE NO COPYRIGHT
// I LOVE YOU

//GLOBAL VARIABLES

//SETUP
void setup(){
  //this makes pin 13 into a digital output pin so we can turn on the 
    //built-in LED
  pinMode(13, OUTPUT);
}

//LOOP
void loop(){

digitalWrite(13, HIGH);
delay(1000);
digitalWrite(13, LOW);
  delay(1000);
}

//FUNCTIONS

