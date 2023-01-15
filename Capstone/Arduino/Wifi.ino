#include <HTTPClient.h>
#include <Wire.h>
#include <WiFi.h>
#include <ArduinoJson.h>
#include "HttpClient.h"

#include "MAX30100_PulseOximeter.h"

//#define DHTPIN 4
//#define DHTTYPE DHT11   // DHT 11


const char* ssid     = "UIU-STUDENT";
const char* password = "12345678";
String serverName = "http://10.10.252.183:3000/";


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

    /*
    StaticJsonDocument<200> doc;
    doc["charge"] = String(pox.getHeartRate());
    doc["temperature"] = String(pox.getSpO2());
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

   

    delay(10000);
    */



//  float h = dht.readHumidity();
//  float t = dht.readTemperature();
//  float f = dht.readTemperature(true);
//
//  Serial.print(F("%  Temperature: "));
//  Serial.print(t);
//  Serial.print(F("°C "));
//  Serial.print(f);
//  Serial.println(F("°F"));
}
