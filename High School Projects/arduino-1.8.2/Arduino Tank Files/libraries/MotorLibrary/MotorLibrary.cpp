/**
    L298 MotorLibrary - A simple library to control 2 DC Motors using a L298 
	Created by Craig Briggs 2016
	Released into the public domain.
*/

#include "MotorLibrary.h"
#include "Arduino.h"

/**
 * Constructor
 */
MotorLibrary::MotorLibrary() {
	setupMotors();
}

void MotorLibrary::setupMotors() {
	// Setup the pins for output
	pinMode(dirA, OUTPUT);
	pinMode(dirB, OUTPUT);
}

void MotorLibrary::debugMotors(bool debugOnTemp){
	// Sets device in debug mode
	// True =  debug ON
	// FALSE =  debug OFF
	debugOn = debugOnTemp;
	if (debugOn){
		Serial.println("Debug mode is on.");
	} else {
		Serial.println("Debug mode is off.");
	}
}



/**
 * Move forward
 */
void MotorLibrary::forward(int speed) {
  // Both tracks forward
  digitalWrite(dirA, HIGH);
  digitalWrite(dirB, HIGH);
  analogWrite(speedA, speed);   //PWM Speed Control
  analogWrite(speedB, speed);   //PWM Speed Control
  
  // Print a debug statement to the console
  if (debugOn){
		Serial.print("Moving Forward at speed ");
		Serial.println(speed);
  }
}

/**
 * Move backward
 */
void MotorLibrary::reverse(int speed) {
  // Both tracks in reverse
  digitalWrite(dirA, LOW);
  digitalWrite(dirB, LOW);
  analogWrite(speedA, speed);   //PWM Speed Control
  analogWrite(speedB, speed);   //PWM Speed Control
    // Print a debug statement to the console
  if (debugOn){
		Serial.print("Moving in reverse at speed ");
		Serial.println(speed);
  }
}

/**
 * Turn Left
 */
void MotorLibrary::hardLeft(int speed) {
  // Hard left - right track forward, left track reverse
  digitalWrite(dirA, LOW);
  digitalWrite(dirB, HIGH);
  analogWrite(speedA, speed);   //PWM Speed Control
  analogWrite(speedB, speed);   //PWM Speed Control
  
  // Print a debug statement to the console
  if (debugOn){
		Serial.print("Turning 'hard left' at speed ");
		Serial.println(speed);
  }
}

/**
 * Turn Right
 */
void MotorLibrary::hardRight(int speed) {
  // Hard right - left track forward, right track reverse
  digitalWrite(dirA, HIGH);
  digitalWrite(dirB, LOW);
  analogWrite(speedA, speed);   //PWM Speed Control
  analogWrite(speedB, speed);   //PWM Speed Control
  
  // Print a debug statement to the console
  if (debugOn){
		Serial.print("Turning 'hard right' at speed ");
		Serial.println(speed);
  }
}

/**
 * Stop Bot
 */
void MotorLibrary::stopMotors() {
  // Stop the motor dead
  digitalWrite(dirA, HIGH);
  digitalWrite(dirB, LOW);
  analogWrite(speedA, 0);   //PWM Speed Control
  analogWrite(speedB, 0);   //PWM Speed Control
  
    // Print a debug statement to the console
  if (debugOn){
		Serial.println("Stopping motors.");
  }
}

void MotorLibrary::leftMotor(int speed){
	bool direction = (speed > 0) ? HIGH : LOW;
	digitalWrite(dirA, direction);
	analogWrite(speedA, abs(speed));
	analogWrite(speedB, 0);
	 if (debugOn){
		Serial.print("Left motor at speed ");
		Serial.println(speed);

  }
}

void MotorLibrary::rightMotor(int speed){
	bool direction = (speed > 0) ? HIGH : LOW;
	digitalWrite(dirB, direction);
	analogWrite(speedB, abs(speed));
	analogWrite(speedA, 0);
	 if (debugOn){
		Serial.print("Right motor at speed ");
		Serial.println(speed);
  }
}

void MotorLibrary::motorsOn(int motorA, int motorB) {
  // Receives speed for motor A and B - positive number = forward, negative = reverse
  // Set the direction accordingly
  bool directionA = (motorA > 0) ? HIGH : LOW;
  bool directionB = (motorB > 0) ? HIGH : LOW;
  digitalWrite(dirA, directionA);
  digitalWrite(dirB, directionB);
  // Set the speed
  analogWrite(speedA, abs(motorA));   //PWM Speed Control
  analogWrite(speedB, abs(motorB));   //PWM Speed Control
  
    // Print a debug statement to the console
  if (debugOn){
		Serial.print("Motor A at speed ");
		Serial.println(motorA);
		Serial.print("Motor B at speed ");
		Serial.println(motorB);
  }
}