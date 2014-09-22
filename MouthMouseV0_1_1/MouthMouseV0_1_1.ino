/*
  Blink
  Turns on an LED on for one second, then off for one second, repeatedly.
 
  This example code is in the public domain.
 */
 
//variables for LEDS
// Pin 4 LED
// Pin 5 LED
int led5 = 5;
int led4 = 4;
//variables for buttons
const int buttonPin2 = 2;     
const int buttonPin3 = 3; 
// variable for reading the pushbutton status
int button2State = 0;         
int button3State = 0;
//variables for the joystick pot
int sensorPinX = A5;    // select the input pin for the potentiometer
int sensorPinY = A4;    // select the input pin for the potentiometer
int potXVal = 0;  // variable to store the value coming from the sensor
int potYVal = 0;  // variable to store the value coming from the sensor
//incoming serial variable
int inByte = 0;         // incoming serial byte

// the setup routine runs once when you press reset:
void setup() {                
  // initialize the digital pins as a LED output.
  pinMode(led4, OUTPUT);     
  pinMode(led5, OUTPUT);
  // initialize the digital pens as switch inputs
  pinMode(buttonPin2, INPUT); 
  pinMode(buttonPin3, INPUT);  
  //initialize serial and wait for incoming data bit
  Serial.begin(9600); 
  while (!Serial) {
    ; // wait for serial port to connect. Needed for Leonardo only
  }
  //once we get a byte over serial then send return a byte over serial
  establishContact();  // send a byte to establish contact until receiver responds 
}

// the loop routine runs over and over again forever:
void loop() {
  
  button2State = digitalRead(buttonPin2);
  button3State = digitalRead(buttonPin3);
  
  if (Serial.available() > 0) {
    // get incoming byte:
    inByte = Serial.read();
    // read the ANALOG state of pinA5 and pinA4
    potYVal = analogRead(sensorPinY);
    delay(20);    
    potXVal = analogRead(sensorPinX);
    delay(20);    
    Serial.print(potXVal);
    Serial.print(",");
    Serial.print(potYVal);
    Serial.print(",");
    Serial.println(button2State);               
  }
    
  if(button2State==HIGH){
    digitalWrite(led4, HIGH);   // turn the LED on (HIGH is the voltage level)
  }else if (button2State==LOW){
    digitalWrite(led4, LOW);    // turn the LED off by making the voltage LOW
  }
 
  if(button3State==HIGH){
    digitalWrite(led5, HIGH);   // turn the LED on (HIGH is the voltage level)
  }else if (button3State==LOW){
    digitalWrite(led5, LOW);    // turn the LED off by making the voltage LOW
  }
  delay(30);               
}

void establishContact() {
  while (Serial.available() <= 0) {
    Serial.println("0,0,0");   // send an initial string
    delay(300);
  }
}
