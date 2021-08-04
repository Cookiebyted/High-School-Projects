// include the library that controls the motors
#include <MotorLibrary.h>

// make a new instance of the library
MotorLibrary motorLibrary;

void setup() {
  // put your setup code here, to run once:
  
  // this lines makes it possible to print to the console,
  // remove if you are not foing to debug
  Serial.begin(9600);
  
  // turn on debugging
  motorLibrary.debugMotors(true);
}

void loop() {
  // put your main code here, to run repeatedly:

  // set both motors moving forward at full speed
  motorLibrary.forward(255);
  
}
