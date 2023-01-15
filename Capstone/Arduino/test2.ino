#include <HTTPClient.h>
#include <Wire.h>
#include <WiFi.h>
#include <ArduinoJson.h>
#include "HttpClient.h"

#include "MAX30100_PulseOximeter.h"


MAX30100 maxim;
//#define DHTPIN 4
//#define DHTTYPE DHT11   // DHT 11


const char* ssid     = "ROYAL BACHELOR";
const char* password = "00000000";
String serverName = "https://prosthetic-dasboard.onrender.com/";



String systolic_pressure;
String diastolic_pressure;
String pulse_rate;
String temperature_body;
String BPM;
String SpO2;
   


String sensor_data;
bool Sr;
String machineid = "MR1";
String room_number= "A1";
String bed_number= "1";

unsigned long lastTime = 0;
// Timer set to 10 minutes (600000)
//unsigned long timerDelay = 600000;
// Set timer to 5 seconds (5000)
unsigned long timerDelay = 5000;



//DHT dht(DHTPIN, DHTTYPE);

#define REPORTING_PERIOD_MS 500
PulseOximeter pox;
uint32_t tsLastReport = 0;


void onBeatDetected()
{
 // Serial.println("Beat!");
}

void setup()
{


   WiFi.begin(ssid, password);
  Serial.println("Connecting");
 
  while(WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.print("Connected to WiFi network with IP Address: ");
  Serial.println(WiFi.localIP());
 
  Serial.println("Timer set to 5 seconds (timerDelay variable), it will take 5 seconds before publishing the first reading.");



 
   Serial.begin(115200);
//  dht.begin();
  Serial.print("Initializing pulse oximeter..");
  if (!pox.begin()) {
    Serial.println("FAILED");
    for (;;);
  } else {
    Serial.println("SUCCESS");
  }
    pox.setOnBeatDetectedCallback(onBeatDetected);
 

 

 
 
}

void loop()
{

  pox.update();
  if (millis() - tsLastReport > REPORTING_PERIOD_MS) {
    Serial.print("Heart rate:");
    Serial.println(pox.getHeartRate());
    Serial.print("bpm / SpO2:");
    Serial.print(pox.getSpO2());
    Serial.println("%");

    tsLastReport = millis();
  }




  while (Serial.available())
    {
      sensor_data = Serial.readString();
      Sr = true;
      Serial.println('data testing x:');
      Serial.println(sensor_data);
   
      int firstcommaindex = sensor_data.indexOf(",");
      int secondcommaindex = sensor_data.indexOf(",", firstcommaindex + 1);
      int thirdcommaindex = sensor_data.indexOf(",", secondcommaindex + 1);
      int fourthcommaindex = sensor_data.indexOf(",", thirdcommaindex + 1);

      systolic_pressure = sensor_data.substring(0, firstcommaindex);
      diastolic_pressure = sensor_data.substring(firstcommaindex + 1, secondcommaindex);
      pulse_rate = sensor_data.substring(secondcommaindex + 1, thirdcommaindex);
      temperature_body = sensor_data.substring(thirdcommaindex + 1);

      StaticJsonDocument<200> doc;
    doc["charge"] = "23";
    doc["temperature"] = "43";
    doc["pulse"] = "75";
    doc["oxygen"] = "95";


    char out[128];
    int b =serializeJson(doc, out);


    if(WiFi.status()== WL_CONNECTED){   //Check WiFi connection status
        HTTPClient http;    //Declare object of class HTTPClient
     
        http.begin(serverName);      //Specify request destination
        http.addHeader("Content-Type", "Content-Type: application/json");
        int httpCode = http.POST(out); //Send the request
        Serial.println("Response");
        Serial.println(httpCode);   //Print HTTP return code
        http.writeToStream(&Serial);  // Print the response body
    }

      maxim.resetFifo();
    }

   
   
   
}
