// Include ultrasonic library
// This uses pins 5 and 6
// 5 = trigPin
// 6 = echoPin
#include <Ultrasonic.h>
int PIEZOPin = 9; // Pin used for the PIEZO Speaker

int maximumRange = 45; // Maximum range needed
int minimumRange = 0; // Minimum range needed

Ultrasonic ultrasonic(5, 6); // (Trig PIN,Echo PIN)

void setup() {
  // put your setup code here, to run once:
  pinMode(PIEZOPin, OUTPUT);     // Use Piezo (if required)
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
  long distance = ultrasonic.Ranging(CM); // CM or INC
  Serial.print("Object distance (in cm's) = ");
  Serial.println(distance);

  if (distance >= minimumRange && distance <= maximumRange) {
    int thePitch = map(distance, 0, 150, 2093, 22);  // remaps the distance so that it is in the correct range
    tone(PIEZOPin, thePitch); // output the remapped range to piezo speaker
  } else {
    noTone(PIEZOPin);
  }
}