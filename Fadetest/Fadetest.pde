int layer1 = 6;    
int layer2 = 7;    
int layer3 = 8;    
int layer4 = 9;    
int layer5 = 10;    
int layer6 = 11;    
int layer7 = 12;    

void setup()  { 
  // nothing happens in setup 
} 

void loop()  { 
  //for(int j=5; j >=0; j--){
    //sequentialLayerOnForward(j);
    //sequentialLayerOnBackword(j);
  //}
  
  //sequentialLayerForwardBack(1);
  int tempSpeed=200;
  for(int k=10; k>0;k--){
    //sequentialLayerForwardBackFast(tempSpeed);
    //tempSpeed-=15;
    layerSequentialEchoForward(100); 
    layerSequentialEchoBack(100); 
  }
 allFade(30); 
}

void layerSequentialEchoForward(int fadeSpeed){
  int fadeValue = 255;
  for (int i = 6; i < 18; i++){
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
  int fadeValue = 255;
  for (int i = 12; i > 1; i--){
    analogWrite(i, fadeValue);
    analogWrite(i+1, fadeValue-50);
    analogWrite(i+2, fadeValue-100);
    analogWrite(i+3, fadeValue-150);
    analogWrite(i+4, fadeValue-200);
    analogWrite(i+5, fadeValue-250);
    // wait for 30 milliseconds to see the dimming effect    
    delay(fadeSpeed);                            
  } 
}

void allFade(int fadeSpeed){
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
}

void sequentialLayerOnForward(int fadeSpeed){ 
  for (int i = 6; i < 13; i++){
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

void sequentialLayerOnBackword(int fadeSpeed){ 
  
  for (int i = 6; i < 13; i++){
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
  
  for (int i = 12; i > 5; i--){
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

void sequentialLayerForwardBack(int fadeSpeed){
  for (int i = 6; i < 13; i++){
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
  
  for (int i = 11; i > 5; i--){
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
  for (int i = 6; i < 13; i++){
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
  
  for (int i = 11; i > 5; i--){
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
}
