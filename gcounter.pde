/*
    Required hardware:
      - Arduino
      - SparkFun's custom 7-Segment Serial Display
      - ADXL193 Accelerometer

    Gcounter can be used as a bullet counter to be mounted on a small 
    firearm of your choice.  You will need to change some variables to 
    customize it to your firearm.
    Copyright (C) 2011  Nathan Hardy

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

    Gcounter  Copyright (C) 2011  Nathan Hardy, nathanhardy@gmail.com
    This program comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
    This is free software, and you are welcome to redistribute it
    under certain conditions; type `show c' for details.
*/


/* Required hardware:
    - Arduino
    - SparkFun's custom 7-Segment Serial Display
    - ADXL193 Accelerometer
*/

#include <SoftwareSerial.h>
#include <stdio.h>

int i = 30;
// these constants describe the pins. They won't change:
// Power for the Serial 7
const int GND = 9;                    // input pin 9 -- ground
const int VCC = 8;                    // input pin 8 -- voltage
// Power for the ADXL193
const int groundpin = 16;             // analog input pin A2 -- ground
const int powerpin = 17;              // analog input pin A3 -- voltage
const int xpin = A0;                  // x-axis of the accelerometer

const int rxPin = 10; // Junk
const int txPin = 2; // Send
SoftwareSerial serialSeven = SoftwareSerial(rxPin, txPin);

void setup()
{
  // initialize the serial communications:
//  Serial.begin(9600);
 
  // Provide ground and power by using the analog inputs as normal
  // digital pins.  This makes it possible to directly connect the
  // breakout board to the Arduino.  If you use the normal 5V and
  // GND pins on the Arduino, you can remove these lines.
  pinMode(GND, OUTPUT);
  pinMode(VCC, OUTPUT);
  digitalWrite(GND, LOW);
  digitalWrite(VCC, HIGH);
  // TX Pin Setup
  pinMode(txPin, OUTPUT); // TX is output

  pinMode(groundpin, OUTPUT);
  pinMode(powerpin, OUTPUT);
  digitalWrite(groundpin, LOW);
  digitalWrite(powerpin, HIGH);

  // Serial Display Init
  Serial.begin(9600);
  serialSeven.begin(9600);
  // This should not really be here:
  serialSeven.print("  30");
}

//void setBrightness(int dataByte) {
//  delay(2000);
//  serialSeven.print("z");
//  serialSeven.print(dataByte);
//}

void loop()
{
  int gRead = analogRead(xpin);
  int gCount = map(gRead, 0, 1023, -245, 250);

  if (gCount > 5)
  {
    char out[4]; ;
    sprintf(out, "% 4d", i--);
    serialSeven.print(out);
    delay(50);
  }
}
