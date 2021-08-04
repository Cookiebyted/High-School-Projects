/**
    L298 MotorLibrary - A simple library to control 2 DC Motors using a L298 
	Created by Craig Briggs 2016
	Released into the public domain.
*/

#ifndef MotorLibrary_H
#define MotorLibrary_H

#include "Arduino.h"

class MotorLibrary {

public:

    // constructor
    MotorLibrary(); // empty constructor

    void setupMotors();

    // normal movement functions
    void forward(int speed);
    void reverse(int speed);
    void hardLeft(int speed);
    void hardRight(int speed);
	void leftMotor(int speed);
	void rightMotor(int speed);
    void stopMotors();

    // slightly more advanced functions
    void motorsOn(int motorA, int motorB);
	
	// helper functions
	void debugMotors(bool debugOnTemp);


private:

    int myDelay = 100; // delay while switching

    // speed pins
	int speedA = 10;  //A Speed
	int speedB = 11;  //B Speed
	// direction pins
	int dirA = 12; //A Direction - High or Low
	int dirB = 13; //B Direction - High or Low
	
	bool debugOn;
};

#endif
