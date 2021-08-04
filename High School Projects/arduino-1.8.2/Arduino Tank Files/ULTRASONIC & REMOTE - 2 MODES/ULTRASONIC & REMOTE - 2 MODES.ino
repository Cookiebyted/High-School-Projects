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

int maximumRange = 20; // Maximum range needed
int minimumRange = 5; // Minimum range needed
int PIEZOPin = 4; // Pin used for the PIEZO Speaker
bool modeRemote = true;

void setup()
{
  Serial.begin(9600);
  irrecv.enableIRIn(); // Start the receiver
  pinMode(9, OUTPUT); // LED = MODE 1
  pinMode(8, OUTPUT); // LED = MODE 2
}
void loop() {
  if (irrecv.decode(&results)) {
    Serial.println(results.actualKey); // desc of key
    if (results.actualKey == "OK" and modeRemote == true) {
       digitalWrite(9, LOW);   // turn the LED on (HIGH is the voltage level)
       digitalWrite(8, LOW);
       motorLibrary.stopMotors();
    }
    else if (results.actualKey == "num1") {
      delay (1000); 
      modeRemote = not modeRemote;
      Serial.println(modeRemote); // desc of key
    }
    else if (results.actualKey == "Up" and modeRemote == true) {
      digitalWrite(9, HIGH);
      digitalWrite(8, LOW);
      motorLibrary.forward(255);
    }
    else if (results.actualKey == "Left" and modeRemote == true) {
      digitalWrite(9, HIGH);
      digitalWrite(8, LOW);
      motorLibrary.leftMotor(255);
    }
    else if (results.actualKey == "Right" and modeRemote == true) {
      digitalWrite(9, HIGH);
      digitalWrite(8, LOW);
      motorLibrary.rightMotor(255);
    }
    else if (results.actualKey == "Down" and modeRemote == true) {
      digitalWrite(9, HIGH);
      digitalWrite(8, LOW);
      motorLibrary.reverse(255);
    }
    irrecv.resume(); // Receive the next value
  }

  else if (modeRemote == false) {
    long distance = ultrasonic.Ranging(CM); // CM or INC
    Serial.print("Object distance (in cm's) = ");
    Serial.println(distance);

    if (distance >= minimumRange && distance <= maximumRange) {
      motorLibrary.stopMotors();
      digitalWrite(8, HIGH);   // turn the LED on (HIGH is the voltage level)
      
    } else {
      motorLibrary.forward(255);   
      digitalWrite(8, HIGH);   // turn the LED on (HIGH is the voltage level)    
    }
  }
}
