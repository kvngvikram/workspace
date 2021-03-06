/*
 RC PulseIn Serial Read out
 By: Nick Poole
 SparkFun Electronics
 Date: 5
 License: CC-BY SA 3.0 - Creative commons share-alike 3.0
 use this code however you'd like, just keep this license and
 attribute. Let me know if you make hugely, awesome, great changes.
 */
 
int ch1; // Here's where we'll keep our channel values
int ch2;
int ch3;
int ch4;
int dp1;
int dp2;

void setup() {

  pinMode(A0, INPUT); // Set our input pins as such
  pinMode(12, INPUT);
  pinMode(13, INPUT);
  pinMode(7, INPUT);
  pinMode(8, INPUT);
  pinMode(4, INPUT);
  Serial.begin(9600); // Pour a bowl of Serial

}

void loop() {
  
  ch1 = pulseIn(A0, HIGH, 25000); // Read the pulse width of 
  ch2 = pulseIn(13, HIGH, 25000); // each channel
  ch3 = pulseIn(12, HIGH, 25000);
  ch4 = pulseIn(7, HIGH, 25000);
  dp1 = pulseIn(8,HIGH,25000);
  dp2 = pulseIn(4,HIGH,25000);

  Serial.print("    Channel 1:  "); // Print the value of 
  Serial.print(ch1);        // each channel

  Serial.print("    Channel 2:  ");
  Serial.print(ch2);

  Serial.print("    Channel 3:  ");
  Serial.print(ch3);

  Serial.print("    Channel 4:  ");
  Serial.print(ch4);

  Serial.print("   digitalpin 1:   ");
  Serial.print(dp1);

  Serial.print("   digitalpin 2:   ");
  Serial.print(dp2);

  Serial.println();Serial.println();
  
  delay(500); // I put this here just to make the terminal 
              // window happier
}
