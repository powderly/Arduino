
int outputPin = 12;
int val;

void setup()
{
  Serial.begin(9600);
  pinMode(outputPin, OUTPUT);
}

void loop()
{
    digitalWrite(outputPin, High);
    Serial.write('H');
    delay(3000);
    Serial.write('L');
    digitalWrite(outputPin, LOW);
    delay(3000);
}
