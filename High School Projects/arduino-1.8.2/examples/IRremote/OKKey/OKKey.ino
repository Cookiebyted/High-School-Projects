#include <IRremote.h>
int RECV_PIN = 2; //define input pin on Arduino
IRrecv irrecv(RECV_PIN);
decode_results results;

void setup()
{
Serial.begin(9600);
irrecv.enableIRIn(); // Start the receiver
}
void loop() {
  if (irrecv.decode(&results)) {
    Serial.println(results.actualKey); // desc of key
    if (results.actualKey == "OK"){
       Serial.println("OK Key Was Pressed");
    }
    irrecv.resume(); // Receive the next value
  }
}
