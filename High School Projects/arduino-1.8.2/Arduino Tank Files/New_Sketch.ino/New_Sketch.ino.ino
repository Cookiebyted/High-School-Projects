#include <IRremote.h>
int RECV_PIN = 2; //define input pin on Arduino
IRrecv irrecv(RECV_PIN);
decode_results results;

// include the library that controls the motors
#include <MotorLibrary.h>
#include <Ultrasonic.h>

// make a new instance of the library
MotorLibrary motorLibrary;
Ultrasonic ultrasonic(5, 6); // (Trig PIN,Echo PIN)

int maximumRange = 45; // Maximum range needed
int minimumRange = 0; // Minimum range needed
int PIEZOPin = 4; // Pin used for the PIEZO Speaker

void setup()
{
  Serial.begin(9600);
  irrecv.enableIRIn(); // Start the receiver
  pinMode(13, OUTPUT);
}
void loop() {
  if (irrecv.decode(&results)) {
    Serial.println(results.actualKey); // desc of key
    if (results.actualKey == "OK") {
      motorLibrary.stopMotors();
    }
    else if (results.actualKey == "Up") {
      motorLibrary.forward(255);
    }
    else if (results.actualKey == "Left") {
      motorLibrary.leftMotor(255);
    }
    else if (results.actualKey == "Right") {
      motorLibrary.rightMotor(255);
    }
    else if (results.actualKey == "Down") {
      motorLibrary.reverse(255);
    }
    irrecv.resume(); // Receive the next value
  }
}
