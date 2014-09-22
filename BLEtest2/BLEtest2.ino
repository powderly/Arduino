 
#define SerialBaud   9600
#define Serial1Baud  9600
void setup()
{
  Serial.begin(SerialBaud);
  Serial1.begin(Serial1Baud);
  while(!Serial.available());
// set master
  Serial1.print("AT+ROLE1");
  delay(1000);
}

void loop()
{
  for(;;)
  {
    // copy from virtual serial line to uart and vice versa
   /*
    */
  //Serial1.print("test I am master ");
  //delay(10000);
    if (Serial.available())
    {
      Serial1.write(Serial.read());
    }
    if (Serial1.available())
    {
      Serial.write(Serial1.read());
    }
  }
}
