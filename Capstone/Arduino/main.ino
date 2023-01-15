#include <WiFi.h>
#include <WebServer.h>
#include <Wire.h>
#include "MAX30100_PulseOximeter.h"

#define REPORTING_PERIOD_MS     1000

float BPM, SpO2;

const char* ssid = "ROYAL BACHELOR";  
const char* password = "00000000";

String serverName = "https://prosthetic-dasboard.onrender.com/";

PulseOximeter pox;
uint32_t tsLastReport = 0;

WebServer server(80);

void onBeatDetected()
{
  Serial.println("Beat Detected!");
}

void setup() {
  Serial.begin(115200);

  Serial.print("Connecting");
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.print(".");
  }
  Serial.println("");
  Serial.println("WiFi Connected");
  Serial.print("Got IP: ");  
  Serial.println(WiFi.localIP());
  
  server.on("/", handle_OnConnect);
  server.onNotFound(handle_NotFound);

  server.begin();
  Serial.println("HTTP server started");
  
  Serial.print("Initializing pulse oximeter..");

  if (!pox.begin()) {
    Serial.println("FAILED");
    for (;;);
  } else {
    Serial.println("SUCCESS");

    pox.setOnBeatDetectedCallback(onBeatDetected);
  }

  pox.setIRLedCurrent(MAX30100_LED_CURR_7_6MA);
}
void loop() {
  server.handleClient();
  pox.update();
  BPM = pox.getHeartRate();
  SpO2 = pox.getSpO2();

  if (millis() - tsLastReport > REPORTING_PERIOD_MS)
  {
    Serial.print("BPM: ");
    Serial.println(BPM);

    Serial.print("SpO2: ");
    Serial.print(SpO2);
    Serial.println("%");
    Serial.println();

    tsLastReport = millis();
  }


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

}

void handle_OnConnect() {

  server.send(200, "text/html", HTML(BPM, SpO2));
}

void handle_NotFound() {
  server.send(404, "text/plain", "Not found");
}

String HTML(float BPM, float SpO2) {
  String str = "<!DOCTYPE html>";
  str += "<html>";
  str += "<head>";
  str += "<title>ESP32 MAX30100 Web Server</title>";
  str += "<meta name='viewport' content='width=device-width, initial-scale=1.0'>";
  str += "<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.7.2/css/all.min.css'>";
  str += "<link rel='stylesheet' type='text/css' href='styles.css'>";
  str += "<style>";
  str += "body { background-color: #fff; font-family: sans-serif; color: #0f0d0d; font: 14px Helvetica, sans-serif box-sizing: border-box;}";
  str += "#page { margin: 20px; background-color: #fff;}";
  str += ".container { height: inherit; padding-bottom: 20px;}";
  str += ".header { padding: 20px;}";
  str += ".header h1 { padding-bottom: 0.3em; color: #0f0d0d; font-size: 40px; font-weight: bold; font-family: Garmond, 'sans-serif'; text-align: center;}";
  //str += "h2 { padding-bottom: 0.2em; border-bottom: 1px solid #eee; margin: 2px; text-align: left;}";
 // str += ".header h3 { font-weight: bold; font-family: Arial, 'sans-serif'; font-size: 17px; color: #b6b6b6; text-align: center;}";
  str += ".box-full { padding: 20px; border 1px solid #ddd; border-radius: 1em 1em 1em 1em; box-shadow: 1px 7px 7px 1px rgba(0,0,0,0.4); background: #fff; margin: 20px; width: 300px;}";
  str += "@media (max-width: 494px) { #page { width: inherit; margin: 5px auto; } #content { padding: 1px;} .box-full { margin: 8px 8px 12px 8px; padding: 10px; width: inherit;; float: none; } }";
  str += "@media (min-width: 494px) and (max-width: 980px) { #page { width: 465px; margin 0 auto; } .box-full { width: 380px; } }";
  str += "@media (min-width: 980px) { #page { width: 930px; margin: auto; } }";
  str += ".sensor { margin: 12px 0px; font-size: 2.5rem;}";
  str += ".sensor-labels { font-size: 1rem; vertical-align: middle; padding-bottom: 15px;}";
  str += ".units { font-size: 1.2rem;}";
  str += "hr { height: 1px; color: #eee; background-color: #eee; border: none;}";
  str += "</style>";

  //Ajax Code Start
  str += "<script>\n";
  str += "setInterval(loadDoc,1000);\n";
  str += "function loadDoc() {\n";
  str += "var xhttp = new XMLHttpRequest();\n";
  str += "xhttp.onreadystatechange = function() {\n";
  str += "if (this.readyState == 4 && this.status == 200) {\n";
  str += "document.body.innerHTML =this.responseText}\n";
  str += "};\n";
  str += "xhttp.open(\"GET\", \"/\", true);\n";
  str += "xhttp.send();\n";
  str += "}\n";
  str += "</script>\n";
  //Ajax Code END

  str += "</head>";
  str += "<body>";
  str += "<div id='page'>";
  str += "<div class='header'>";
  str += "<h3>Human Prosthetic with Sense</h3>";
  str += "<p>G-6, UIU";
  str += "</div>";
  str += "<div id='content' align='center'>";
  str += "<div class='box-full' align='left'>";
  str += "<div class='sensors-container'>";


  // For charge
  str += "<p class='sensor'>";
  str += "<i class='fas fa-battery-full' style='color:#dceffc'></i>";
  str += "<span class='sensor-labels'> Battery: </span>";
  str += "60";
  str += "<sup class='units'>%</sup>";
  str += "</p>";


  //For Heart Rate
  str += "<p class='sensor'>";
  str += "<i class='fas fa-heartbeat' style='color:#ff4000'></i>";
  str += "<span class='sensor-labels'> Heart Rate </span>";
  str += (int)BPM;
  str += "<sup class='units'>BPM</sup>";
  str += "</p>";
  str += "<hr>";

  //For Sp02
  str += "<p class='sensor'>";
  str += "<i class='fas fa-thermometer' style='color:#dceffc'></i>";
  str += "<span class='sensor-labels'> Temp: </span>";
  str += ((int)SpO2 <= 90) ? 0 : ((int)SpO2 - 57);
  str += "<sup class='units'>%</sup>";
  str += "</p>";

  // For temperature
  str += "<p class='sensor'>";
  str += "<i class='fas fa-tint' style='color:#dceffc'></i>";
  str += "<span class='sensor-labels'> SpO2 </span>";
  str += (int)SpO2;
  str += "<sup class='units'>%</sup>";
  str += "</p>";

  

  str += "</div>";
  str += "</div>";
  str += "</div>";
  str += "</div>";
  str += "</div>";
  str += "</body>";
  str += "</html>";
  return str;
}
