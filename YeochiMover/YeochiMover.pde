int randomBump;
int randomInterval;
int randomTime;

int motorPin = 13;

void setup(){
  pinMode(13, HIGH);
  Serial.begin(9600);
  randomSeed(analogRead(0));
  digitalWrite(13, LOW);
}

void loop(){
  int randomBump = random(0,10);
  for(int i = 0; i < randomBump; i++){
    int randomTime = random(10,200);
    digitalWrite(13, HIGH);
    delay(randomTime);
    digitalWrite(13,LOW);
    delay(randomTime);
  }
  int randomInterval = random(10000, 20000);
  delay(randomInterval); 
 }
