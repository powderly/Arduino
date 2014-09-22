

// MY FIRST ARDUINO CODE
// JAMES POWDERLY
// OPEN SOURCE NO COPYRIGHT
// I LOVE YOU

//GLOBAL VARIABLES

// THIS IS FOR A FLEX SENSOR WITH R1 set at 30KOHM
//RANGE = 65 - 120

//SETUP

int analogVal;

void setup(){
  //this makes pin 13 into a digital output pin so we can turn on the 
    //built-in LED
  //pinMode(13, OUTPUT);
  //pinMode(10, INPUT);
  Serial.begin(9600);
  //here
}
//LOOP
void loop(){

  //int result = digitalRead(10);
  analogVal = analogRead(2);
  delay(10);
  //function that maps my output value to a more usefull range
  int tempValue = map((analogVal/4),65,120,0, 255);
  Serial.println(tempValue);
  
 /* if(result == HIGH){  
    digitalWrite(13, HIGH);
    Serial.println("on");
  }else if(result == LOW){
    digitalWrite(13, LOW);
    Serial.println("off");
  }*/
}
//FUNCTIONS
