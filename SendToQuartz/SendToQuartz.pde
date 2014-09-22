/*
This example shows the output of an analogRead() of a Potentiometer.
By M.Gonzalez
www.codingcolor.com
The example code is in the public domain
*/
int potentiometerPin = A0;    // select the input pin for the potentiometer
int potentiometerValue = 0;  // variable to store the value coming from the potentiometer

void setup() {

  Serial.begin(9600);
  pinMode(potentiometerPin, INPUT);
  
}

void loop() {
  // read the value from the potentiometer:
  potentiometerValue = analogRead(potentiometerPin);    
  // send the value to Quartz Composer with line break
  Serial.println(potentiometerValue);  
  delay(50);
}


