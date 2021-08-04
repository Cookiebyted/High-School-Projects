// Include ultrasonic library
// This uses pins 5 and 6
// 5 = trigPin
// 6 = echoPin
#include <Ultrasonic.h>

Ultrasonic ultrasonic(5,6); // (Trig PIN,Echo PIN)

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
  // use the ultraSonic library to get the distance of the object
  // and store it in "distance"
  long distance = ultrasonic.Ranging(CM); // CM or INC
  
  // check the serial monitor to see the output
  Serial.print("Object distance (in cm's) = ");
  Serial.println(distance);
}