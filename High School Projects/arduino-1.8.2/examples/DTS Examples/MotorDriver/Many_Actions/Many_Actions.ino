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
  // do this for 2 seconds
  delay (2000);
  
  // stop both motors for 1 second
  motorLibrary.stopMotors();
  delay (1000);
  
  // set both motors to hard left (speed 100) for 1 second
  motorLibrary.hardLeft(100);
  delay (1000);
  
  // set both motors to hard right (speed 100) for 1 second
  motorLibrary.stopMotors();
  delay (1000);
  
  // set left motor to 255 and right motor to 125 for 2 seconds
  motorLibrary.motorsOn(255,125);
  delay (2000);
  
  // set left motor to 255 and turn right off for 2 seconds
  motorLibrary.leftMotor(255);
  delay (2000);
  
  // set right motor to 255 and turn right off for 2 seconds
  motorLibrary.rightMotor(255);
  delay(2000);
}
