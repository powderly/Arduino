

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
  pinMode(10, INPUT);
  Serial.begin(9600);
}
//LOOP
void loop(){

int result = digitalRead(10);

if(result == HIGH){  
  digitalWrite(13, HIGH);
  Serial.println("on");
}else if(result == LOW){
  digitalWrite(13, LOW);
    Serial.println("off");
}
}
//FUNCTIONS

