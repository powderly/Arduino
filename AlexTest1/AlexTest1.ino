// status LEDs

 int onStatusLedPin = 2;
 int connectedStatusLedPin = 7;

//joystick ADC pins
 int joystickPinX = 6;                 // slider variable connecetd to analog pin 0
 int joystickPinY = 7;                 // slider variable connecetd to analog pin 1

//pressure sensor ADC pins
int PSIPin = 2;

 //analog values variables
 int xVal = 0;                  // variable to read the value from the analog pin 0
 int yVal = 0;                  // variable to read the value from the analog pin 1
 int PSIVal = 0;
 
 //butttons
 int joystickSwitch = 3;
 int extRightClick = 11;
 int extLeftClick = 6;
 int onMode1Switch = 4;
 int onMode2Switch = 5;
 
 //button sates
 int joystickSwState = 0;
 int extRightState = 0;
 int extLeftState = 0;

 
 void setup() {
 
  //ON status and connected status LEDs 
  pinMode(onStatusLedPin, OUTPUT);              // initializes digital pins 0 to 7 as outputs
  pinMode(connectedStatusLedPin, OUTPUT);  
  
  //communicate with the PC at 9600 
  Serial.begin(9600);
  
  //swithes with internal pullups
  //joystick push switch = 3
  //external left and right buttons = 12 & 6
  
  pinMode(joystickSwitch, INPUT); // set pin to input
  digitalWrite(joystickSwitch, HIGH); // turn on pullup resistors 
  
  pinMode(extRightClick, INPUT); // set pin to input
  digitalWrite(extRightClick, HIGH); // turn on pullup resistors 
  
  pinMode(extLeftClick, INPUT); // set pin to input
  digitalWrite(extLeftClick, HIGH); // turn on pullup resistors 
  
  //on/connected status LED mode
  digitalWrite(onStatusLedPin, HIGH);
  digitalWrite(connectedStatusLedPin, HIGH);
  
 }

  void loop() {
  //read the value of the joystick x 
    xVal = analogRead(joystickPinX);  
    delay(20);//pause to reset adc register             
  //read the value of the joystick y 
    yVal = analogRead(joystickPinY);   
    delay(20);  
  //read the value of the pressure sensor
    PSIVal = analogRead(PSIPin); 

  //read the digital input pins
    joystickSwState = digitalRead(joystickSwitch);       
    extRightState = digitalRead(extRightClick);    
    extLeftState = digitalRead(extLeftClick);            
 
   //-------------DIGITAL OUTPUT VALUE------------//
    //joystick push switch
    Serial.println(joystickSwState);
    //external breakout box buttons
    Serial.println(extRightState);
    Serial.println(extLeftState);
    
    //-------------ANALOG OUTPUT VALUE------------//
    //joystick pots
    Serial.println(xVal);
    Serial.println(yVal);
    //pressure sensor
    Serial.println(PSIVal);
    
    /*
    Serial.print(swState);
    Serial.print(extRightClick);
    Serial.print(extLeftClick);
    Serial.print(map(xVal,0, 1023, 0, 254));
    Serial.print(map(yVal,0, 1023, 0, 254));
    Serial.print(map(PSIVale,0, 1023, 0, 254))
    */
    
    //delay for testing purposes
    delay(250);
 }
