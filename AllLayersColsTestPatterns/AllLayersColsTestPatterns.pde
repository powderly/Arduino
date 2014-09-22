int layer1 = 5;    
int layer2 = 6;    
int layer3 = 7;    
int layer4 = 8;    
int layer5 = 9;    
int layer6 = 10;    
int layer7 = 11; 

int layers[]={
  5,6,7,8,9,10,11};

int layerNum = 7;
int rowNum = 49;

int pixelArray[]={
  A0, A1, A2, A3, A4, A5, A6, 
  A7, A8, A9, A10, A11, A12, A13, 
  A14,17, 18, 19, 20, 21, 16,
  15,14,0,1,25,31,33,
  2,A15,53,52,50,48,46,
  44,42,40,38,36,34,32,
  30,28,26,24,22,27,29};

int col1[]={
  A0, A1, A2, A3, A4, A5, A6};
int col2[]={
  A7, A8, A9, A10, A11, A12, A13};
int col3[]={
  A14,17, 18, 19, 20, 21, 16};
int col4[]={
  15,14,0,1,25,31,33};
int col5[]={
  2,A15,53,52,50,48,46}; 
int col6[]={
  44,42,40,38,36,34,32};
int col7[]={
  30,28,26,24,22,27,29};

void setup()  { 
  //set the ports as outputs
  setPorts();

} 

void loop()  { 
  //for(int j=5; j >=0; j--){
  //sequentialLayerOnForward(1);
  //sequentialLayerOnBackword(1);
  //sequentialColOnDown(1);
  //sequentialColOnUp(1);
  //}

  //testAllLights(1);
  //sequentialLayerForwardBackFast(100); 
  //sequentialColOnDownFast(30);
  //sequentialColOnUpFast(30);

  //centerEgg();

  //int tempSpeed=200;
  //for(int k=10; k>0;k--){
  //sequentialLayerForwardBackFast(tempSpeed);
  //tempSpeed-=15;
  //layerSequentialEchoForward(100); 
  //layerSequentialEchoBack(100); 
  //}

  allFade(50);  
  for(int i = 5; i > 1; i--){
    sequentialColOnUp(i);
  }
  sequentialColOnUpFill(1);
  for (int i = 5; i>0;i--){
    sequentialColOnDownFast(i);
    sequentialColOnUpFast(i);
  }

  sequentialColOnUpFill(1);
  for (int i = 5; i>0;i--){
    sequentialColOnDownFast(i);
    sequentialColOnUpFast(i);
    sequentialLayerForwardBackFast(20); 
  }

  allFade(25);
  delay(2000);


  int tempSpeed=200;
  for(int k=11; k>0;k--){
    //sequentialLayerForwardBackFast(tempSpeed);
    tempSpeed-=15;
    layerSequentialEchoForward(tempSpeed); 
    layerSequentialEchoBack(tempSpeed); 
  }
    testAllLights(1);
    testAllLights(5);

}


void testAllLights(int fadeSpeed){
  for(int l = 0; l<7; l++){
    analogWrite(layers[l], 100);
    for(int c=0;c<7;c++){
      digitalWrite(col1[c], HIGH);
      delay(fadeSpeed);
      digitalWrite(col1[c], LOW);
      digitalWrite(col2[c], HIGH);
      delay(fadeSpeed);
      digitalWrite(col2[c], LOW);
      digitalWrite(col3[c], HIGH);
      delay(fadeSpeed);
      digitalWrite(col3[c], LOW);
      digitalWrite(col4[c], HIGH);
      delay(fadeSpeed);
      digitalWrite(col4[c], LOW);
      digitalWrite(col5[c], HIGH);
      delay(fadeSpeed);
      digitalWrite(col5[c], LOW);
      digitalWrite(col6[c], HIGH);
      delay(fadeSpeed);
      digitalWrite(col6[c], LOW);
      digitalWrite(col7[c], HIGH);
      delay(fadeSpeed);
      digitalWrite(col7[c], LOW);
    }
    analogWrite(layers[l],0);
  }  
}

void layerSequentialEchoForward(int fadeSpeed){
  int fadeValue = 255;


  for (int i = 5; i < 17; i++){
    analogWrite(i, fadeValue);
    analogWrite(i-1, fadeValue-50);
    analogWrite(i-2, fadeValue-100);
    analogWrite(i-3, fadeValue-150);
    analogWrite(i-4, fadeValue-200);
    analogWrite(i-5, fadeValue-250);
    // wait for 30 milliseconds to see the dimming effect    
    delay(fadeSpeed);   
  } 
}

void layerSequentialEchoBack(int fadeSpeed){
  allColsOff();
  int fadeValue = 255;
  for (int i = 11; i > 1; i--){
    analogWrite(i, fadeValue);
    analogWrite(i+1, fadeValue-50);
    analogWrite(i+2, fadeValue-100);
    analogWrite(i+3, fadeValue-150);
    analogWrite(i+4, fadeValue-200);
    analogWrite(i+5, fadeValue-250);
    allColsOn();
    // wait for 30 milliseconds to see the dimming effect    
    delay(fadeSpeed);                            
  } 
}

void allFade(int fadeSpeed){

  allColsOn();

  for(int fadeValue = 0 ; fadeValue <= 255; fadeValue +=1) { 
    // sets the value (range from 0 to 255):
    analogWrite(layer1, fadeValue);  
    analogWrite(layer2, fadeValue);  
    analogWrite(layer3, fadeValue);  
    analogWrite(layer4, fadeValue);  
    analogWrite(layer5, fadeValue);  
    analogWrite(layer6, fadeValue);  
    analogWrite(layer7, fadeValue);  
    // wait for 30 milliseconds to see the dimming effect    
    delay(fadeSpeed);                            
  } 
  // fade out from max to min in increments of 5 points:
  for(int fadeValue = 255 ; fadeValue >= 0; fadeValue -=1) { 
    // sets the value (range from 0 to 255):
    analogWrite(layer1, fadeValue);  
    analogWrite(layer2, fadeValue);  
    analogWrite(layer3, fadeValue);  
    analogWrite(layer4, fadeValue);  
    analogWrite(layer5, fadeValue);  
    analogWrite(layer6, fadeValue);  
    analogWrite(layer7, fadeValue);          
    // wait for 30 milliseconds to see the dimming effect    
    delay(fadeSpeed);                            
  }

  allColsOff();

}

void sequentialColOnDown(int fadeSpeed){

  for (int c=0; c < 7; c++){
    digitalWrite(col1[c], HIGH);
    digitalWrite(col2[c], HIGH);
    digitalWrite(col3[c], HIGH);
    digitalWrite(col4[c], HIGH);
    digitalWrite(col5[c], HIGH);
    digitalWrite(col6[c], HIGH);
    digitalWrite(col7[c], HIGH);

    for(int fadeValue = 0 ; fadeValue <= 255; fadeValue +=1) { 
      // sets the value (range from 0 to 255):
      analogWrite(layer1, fadeValue);  
      analogWrite(layer2, fadeValue);  
      analogWrite(layer3, fadeValue);  
      analogWrite(layer4, fadeValue);  
      analogWrite(layer5, fadeValue);  
      analogWrite(layer6, fadeValue);  
      analogWrite(layer7, fadeValue);  
      // wait for 30 milliseconds to see the dimming effect    
      delay(fadeSpeed);                            
    } 
    // fade out from max to min in increments of 5 points:
    for(int fadeValue = 255 ; fadeValue >= 0; fadeValue -=1) { 
      // sets the value (range from 0 to 255):
      analogWrite(layer1, fadeValue);  
      analogWrite(layer2, fadeValue);  
      analogWrite(layer3, fadeValue);  
      analogWrite(layer4, fadeValue);  
      analogWrite(layer5, fadeValue);  
      analogWrite(layer6, fadeValue);  
      analogWrite(layer7, fadeValue);          
      // wait for 30 milliseconds to see the dimming effect    
      delay(fadeSpeed);                            
    }

    digitalWrite(col1[c], LOW);
    digitalWrite(col2[c], LOW);
    digitalWrite(col3[c], LOW);
    digitalWrite(col4[c], LOW);
    digitalWrite(col5[c], LOW);
    digitalWrite(col6[c], LOW);
    digitalWrite(col7[c], LOW);    
  }  
}

void sequentialColOnUp(int fadeSpeed){

  for (int c=6; c >=0; c-- ){
    digitalWrite(col1[c], HIGH);
    digitalWrite(col2[c], HIGH);
    digitalWrite(col3[c], HIGH);
    digitalWrite(col4[c], HIGH);
    digitalWrite(col5[c], HIGH);
    digitalWrite(col6[c], HIGH);
    digitalWrite(col7[c], HIGH);

    for(int fadeValue = 0 ; fadeValue <= 255; fadeValue +=1) { 
      // sets the value (range from 0 to 255):
      analogWrite(layer1, fadeValue);  
      analogWrite(layer2, fadeValue);  
      analogWrite(layer3, fadeValue);  
      analogWrite(layer4, fadeValue);  
      analogWrite(layer5, fadeValue);  
      analogWrite(layer6, fadeValue);  
      analogWrite(layer7, fadeValue);  
      // wait for 30 milliseconds to see the dimming effect    
      delay(fadeSpeed);                            
    } 
    // fade out from max to min in increments of 5 points:
    for(int fadeValue = 255 ; fadeValue >= 0; fadeValue -=1) { 
      // sets the value (range from 0 to 255):
      analogWrite(layer1, fadeValue);  
      analogWrite(layer2, fadeValue);  
      analogWrite(layer3, fadeValue);  
      analogWrite(layer4, fadeValue);  
      analogWrite(layer5, fadeValue);  
      analogWrite(layer6, fadeValue);  
      analogWrite(layer7, fadeValue);          
      // wait for 30 milliseconds to see the dimming effect    
      delay(fadeSpeed);                            
    }

    digitalWrite(col1[c], LOW);
    digitalWrite(col2[c], LOW);
    digitalWrite(col3[c], LOW);
    digitalWrite(col4[c], LOW);
    digitalWrite(col5[c], LOW);
    digitalWrite(col6[c], LOW);
    digitalWrite(col7[c], LOW);
  }  
}

void sequentialColOnUpFill(int fadeSpeed){

  for (int c=6; c >=0; c-- ){
    digitalWrite(col1[c], HIGH);
    digitalWrite(col2[c], HIGH);
    digitalWrite(col3[c], HIGH);
    digitalWrite(col4[c], HIGH);
    digitalWrite(col5[c], HIGH);
    digitalWrite(col6[c], HIGH);
    digitalWrite(col7[c], HIGH);

    for(int fadeValue = 0 ; fadeValue <= 255; fadeValue +=1) { 
      // sets the value (range from 0 to 255):
      analogWrite(layer1, fadeValue);  
      analogWrite(layer2, fadeValue);  
      analogWrite(layer3, fadeValue);  
      analogWrite(layer4, fadeValue);  
      analogWrite(layer5, fadeValue);  
      analogWrite(layer6, fadeValue);  
      analogWrite(layer7, fadeValue);  
      // wait for 30 milliseconds to see the dimming effect    
      delay(fadeSpeed);                            
    } 

  }  
}

void sequentialColOnDownFast(int fadeSpeed){

  for (int c=0; c < 7; c++){
    digitalWrite(col1[c], HIGH);
    digitalWrite(col2[c], HIGH);
    digitalWrite(col3[c], HIGH);
    digitalWrite(col4[c], HIGH);
    digitalWrite(col5[c], HIGH);
    digitalWrite(col6[c], HIGH);
    digitalWrite(col7[c], HIGH);

    for(int fadeValue = 0 ; fadeValue <= 255; fadeValue +=1) { 
      // sets the value (range from 0 to 255):
      analogWrite(layer1, fadeValue);  
      analogWrite(layer2, fadeValue);  
      analogWrite(layer3, fadeValue);  
      analogWrite(layer4, fadeValue);  
      analogWrite(layer5, fadeValue);  
      analogWrite(layer6, fadeValue);  
      analogWrite(layer7, fadeValue);  
      // wait for 30 milliseconds to see the dimming effect    
      delayMicroseconds(fadeSpeed);                            
    } 
    // fade out from max to min in increments of 5 points:
    for(int fadeValue = 255 ; fadeValue >= 0; fadeValue -=1) { 
      // sets the value (range from 0 to 255):
      analogWrite(layer1, fadeValue);  
      analogWrite(layer2, fadeValue);  
      analogWrite(layer3, fadeValue);  
      analogWrite(layer4, fadeValue);  
      analogWrite(layer5, fadeValue);  
      analogWrite(layer6, fadeValue);  
      analogWrite(layer7, fadeValue);          
      // wait for 30 milliseconds to see the dimming effect    
      delayMicroseconds(fadeSpeed);                            
    }

    digitalWrite(col1[c], LOW);
    digitalWrite(col2[c], LOW);
    digitalWrite(col3[c], LOW);
    digitalWrite(col4[c], LOW);
    digitalWrite(col5[c], LOW);
    digitalWrite(col6[c], LOW);
    digitalWrite(col7[c], LOW);    
  }  
}

void sequentialColOnUpFast(int fadeSpeed){

  for (int c=6; c >=0; c-- ){
    digitalWrite(col1[c], HIGH);
    digitalWrite(col2[c], HIGH);
    digitalWrite(col3[c], HIGH);
    digitalWrite(col4[c], HIGH);
    digitalWrite(col5[c], HIGH);
    digitalWrite(col6[c], HIGH);
    digitalWrite(col7[c], HIGH);

    for(int fadeValue = 0 ; fadeValue <= 255; fadeValue +=1) { 
      // sets the value (range from 0 to 255):
      analogWrite(layer1, fadeValue);  
      analogWrite(layer2, fadeValue);  
      analogWrite(layer3, fadeValue);  
      analogWrite(layer4, fadeValue);  
      analogWrite(layer5, fadeValue);  
      analogWrite(layer6, fadeValue);  
      analogWrite(layer7, fadeValue);  
      // wait for 30 milliseconds to see the dimming effect    
      delayMicroseconds(fadeSpeed);                            
    } 
    // fade out from max to min in increments of 5 points:
    for(int fadeValue = 255 ; fadeValue >= 0; fadeValue -=1) { 
      // sets the value (range from 0 to 255):
      analogWrite(layer1, fadeValue);  
      analogWrite(layer2, fadeValue);  
      analogWrite(layer3, fadeValue);  
      analogWrite(layer4, fadeValue);  
      analogWrite(layer5, fadeValue);  
      analogWrite(layer6, fadeValue);  
      analogWrite(layer7, fadeValue);          
      // wait for 30 milliseconds to see the dimming effect    
      delayMicroseconds(fadeSpeed);                            
    }

    digitalWrite(col1[c], LOW);
    digitalWrite(col2[c], LOW);
    digitalWrite(col3[c], LOW);
    digitalWrite(col4[c], LOW);
    digitalWrite(col5[c], LOW);
    digitalWrite(col6[c], LOW);
    digitalWrite(col7[c], LOW);
  }  
}

void sequentialLayerOnForward(int fadeSpeed){ 

  allColsOn();

  for (int i = 5; i < 12; i++){
    for(int fadeValue = 0 ; fadeValue <= 255; fadeValue +=1) { 
      // sets the value (range from 0 to 255):
      analogWrite(i, fadeValue);   
      // wait for 30 milliseconds to see the dimming effect    
      delay(fadeSpeed);                            
    } 

    // fade out from max to min in increments of 5 points:
    for(int fadeValue = 255 ; fadeValue >= 0; fadeValue -=1) { 
      // sets the value (range from 0 to 255):
      analogWrite(i, fadeValue);         
      // wait for 30 milliseconds to see the dimming effect    
      delay(fadeSpeed);                            
    }
  }

  allColsOff();

}

void sequentialLayerOnBackword(int fadeSpeed){ 

  allColsOn();

  for (int i = 11; i > 4; i--){
    for(int fadeValue = 0 ; fadeValue <= 255; fadeValue +=1) { 
      // sets the value (range from 0 to 255):
      analogWrite(i, fadeValue);   
      // wait for 30 milliseconds to see the dimming effect    
      delay(fadeSpeed);                            
    } 
    // fade out from max to min in increments of 5 points:
    for(int fadeValue = 255 ; fadeValue >= 0; fadeValue -=1) { 
      // sets the value (range from 0 to 255):
      analogWrite(i, fadeValue);         
      // wait for 30 milliseconds to see the dimming effect    
      delay(fadeSpeed);                            
    }
  }

  allColsOff();
}

void sequentialLayerForwardBack(int fadeSpeed){
  for (int i = 5; i < 12; i){
    for(int fadeValue = 0 ; fadeValue <= 255; fadeValue +=1) { 
      // sets the value (range from 0 to 255):
      analogWrite(i, fadeValue);   
      // wait for 30 milliseconds to see the dimming effect    
      delay(fadeSpeed);                            
    } 
    // fade out from max to min in increments of 5 points:
    for(int fadeValue = 255 ; fadeValue >= 0; fadeValue -=1) { 
      // sets the value (range from 0 to 255):
      analogWrite(i, fadeValue);         
      // wait for 30 milliseconds to see the dimming effect    
      delay(fadeSpeed);                            
    }
  }

  for (int i = 11; i > 4; i--){
    for(int fadeValue = 0 ; fadeValue <= 255; fadeValue +=1) { 
      // sets the value (range from 0 to 255):
      analogWrite(i, fadeValue);   
      // wait for 30 milliseconds to see the dimming effect    
      delay(fadeSpeed);                            
    } 
    // fade out from max to min in increments of 5 points:
    for(int fadeValue = 255 ; fadeValue >= 0; fadeValue -=1) { 
      // sets the value (range from 0 to 255):
      analogWrite(i, fadeValue);         
      // wait for 30 milliseconds to see the dimming effect    
      delay(fadeSpeed);                            
    }
  }
}

void sequentialLayerForwardBackFast(int fadeSpeed){
  allColsOn();
  for (int i = 5; i < 12; i++){
    for(int fadeValue = 0 ; fadeValue <= 255; fadeValue +=1) { 
      // sets the value (range from 0 to 255):
      analogWrite(i, fadeValue);   
      // wait for 30 milliseconds to see the dimming effect    
      delayMicroseconds(fadeSpeed);                            
    } 
    // fade out from max to min in increments of 5 points:
    for(int fadeValue = 255 ; fadeValue >= 0; fadeValue -=1) { 
      // sets the value (range from 0 to 255):
      analogWrite(i, fadeValue);         
      // wait for 30 milliseconds to see the dimming effect    
      delayMicroseconds(fadeSpeed);    
    }
  }

  for (int i = 11; i > 4; i--){
    for(int fadeValue = 0 ; fadeValue <= 255; fadeValue +=1) { 
      // sets the value (range from 0 to 255):
      analogWrite(i, fadeValue);   
      // wait for 30 milliseconds to see the dimming effect    
      delayMicroseconds(fadeSpeed);    
    } 
    // fade out from max to min in increments of 5 points:
    for(int fadeValue = 255 ; fadeValue >= 0; fadeValue -=1) { 
      // sets the value (range from 0 to 255):
      analogWrite(i, fadeValue);         
      // wait for 30 milliseconds to see the dimming effect    
      delayMicroseconds(fadeSpeed);    
    }
  }
  allColsOff();
}

void setPorts(){

  for(int i=0; i < 7; i++){
    pinMode(col1[i], OUTPUT);
    pinMode(col2[i], OUTPUT);
    pinMode(col3[i], OUTPUT);
    pinMode(col4[i], OUTPUT);
    pinMode(col5[i], OUTPUT);
    pinMode(col6[i], OUTPUT);
    pinMode(col7[i], OUTPUT);
  }

  for(int i=0; i < 7; i++){
    pinMode(layers[i], OUTPUT);
  }

  for(int i=0; i < 7; i++){
    digitalWrite(col1[i], LOW);
    digitalWrite(col2[i], LOW);
    digitalWrite(col3[i], LOW);
    digitalWrite(col4[i], LOW);
    digitalWrite(col5[i], LOW);
    digitalWrite(col6[i], LOW);
    digitalWrite(col7[i], LOW);
  }

  for(int i=0; i < 7; i++){
    digitalWrite(layers[i], LOW);
  }
}

void allColsOn(){
  for (int c=0; c < 7; c++){
    digitalWrite(col1[c], HIGH);
    digitalWrite(col2[c], HIGH);
    digitalWrite(col3[c], HIGH);
    digitalWrite(col4[c], HIGH);
    digitalWrite(col5[c], HIGH);
    digitalWrite(col6[c], HIGH);
    digitalWrite(col7[c], HIGH);
  }
}

void allColsOff(){
  for (int c=0; c < 7; c++){
    digitalWrite(col1[c], LOW);
    digitalWrite(col2[c], LOW);
    digitalWrite(col3[c], LOW);
    digitalWrite(col4[c], LOW);
    digitalWrite(col5[c], LOW);
    digitalWrite(col6[c], LOW);
    digitalWrite(col7[c], LOW);
  }
}  

void centerEgg(){
  digitalWrite(col4[4], HIGH);
  for(int fadeValue = 0 ; fadeValue <= 255; fadeValue +=1) {
    analogWrite(layers[4], fadeValue);
    delay(50); 
  }
}

