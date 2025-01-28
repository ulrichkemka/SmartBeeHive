#include <Adafruit_Sensor.h>
#include <Firebase_ESP_Client.h>
#include "time.h"
#include <WiFi.h>
#include <DHT.h>
#define DHTPIN 4     // Digital pin connected to the DHT sensor
#define DHTTYPE    DHT11     // boitier DHT 11 
const char* ssid = "IMIE";
const char* password = "Safwee@2022@7";
const int buttonPin = 32;
const int ledPin =  23;
const char* rucheId = "R0001"; 

/// data for date
const char* ntpServer = "pool.ntp.org";
const long  gmtOffset_sec = 3600;
const int   daylightOffset_sec = 3600;



//Provide the token generation process info.
#include "addons/TokenHelper.h"
//Provide the RTDB payload printing info and other helper functions.
#include "addons/RTDBHelper.h"
// Insert Firebase project API Key
#define API_KEY "AIzaSyCSATNP9YA346NouFnDTwWEfDjU8yTRDFQ"

// Insert RTDB URLefine the RTDB URL */
#define DATABASE_URL "https://smartbeehive-f67f1-default-rtdb.europe-west1.firebasedatabase.app/" 
//Define Firebase Data object
FirebaseData fbdo;

FirebaseAuth auth;
FirebaseConfig config;

unsigned long sendDataPrevMillis = 0;
int count = 0;
bool signupOK = false;
int intValue;
float floatValue;

// Etat du bouton poussoir
int buttonState = 0;

DHT dht(DHTPIN, DHTTYPE); // déclarer un objet dht11 data (ou OUT) est sur la broche 27

String readDHTTemperature() {
  // Sensor readings may also be up to 2 seconds 'old' (its a very slow sensor)
  // Read temperature as Celsius (the default)
  float t = dht.readTemperature();
  // Check if any reads failed and exit early (to try again).
  if (isnan(t)) {    
    Serial.println("Failed to read from DHT sensor!");
    return "--";
  }
  else {
    //Serial.println(t);
    return String(t);
  }
}

String readDHTHumidity() {
  // Sensor readings may also be up to 2 seconds 'old' (its a very slow sensor)
  float h = dht.readHumidity();
  if (isnan(h)) {
    Serial.println("Failed to read from DHT sensor!");
    return "--";
  }
  else {
    //Serial.println(h);
    return String(h);
  }
}



void setup() {
  Serial.begin(115200);
  pinMode(buttonPin, INPUT_PULLUP);
  pinMode(ledPin, OUTPUT);
  dht.begin();

  ////////////////////////  wifi /////////////////////////
  WiFi.begin(ssid, password);
  Serial.print("Tentative de connexion...");
   while(WiFi.status() != WL_CONNECTED)
  {
    Serial.print(".");
    delay(100);
  }
 
  Serial.println("\n");
  Serial.println("Connexion etablie!");
  Serial.print("Adresse IP: ");
  Serial.println(WiFi.localIP());

    //init and get the time
  configTime(gmtOffset_sec, daylightOffset_sec, ntpServer);

   /* Assign the api key (required) */
  config.api_key = API_KEY;

  /* Assign the RTDB URL (required) */
  config.database_url = DATABASE_URL;

  /* Sign up */
  if (Firebase.signUp(&config, &auth, "", "")){
    Serial.println("ok");
    signupOK = true;
  }
  else{
    Serial.printf("%s\n", config.signer.signupError.message.c_str());
  }

  /* Assign the callback function for the long running token generation task */
 // config.token_status_callback = tokenStatusCallback; //see addons/TokenHelper.h
  
  Firebase.begin(&config, &auth);
  Firebase.reconnectWiFi(true);

 
}
 

////////////////////// UPDATE FIRESTORE DATA /////////////

void firestoreDataUpdate(String temp, String humi, String lidState){
  if(WiFi.status() == WL_CONNECTED && Firebase.ready()){
      String documentPath = "sensor_data";
      FirebaseJson content;

     content.set("fields/temperature/doubleValue", String(temp).c_str());
     content.set("fields/humidite/doubleValue", String(humi).c_str());
     content.set("fields/couvercle/stringValue", String(lidState) == "1" ? "Ouverte" : "Fermée" );
     content.set("fields/date/stringValue", getCurrentDate().c_str());
     content.set("fields/heure/stringValue", getCurrentHour().c_str());
     content.set("fields/rucheId/stringValue", rucheId);
     
   
    if(Firebase.Firestore.createDocument(&fbdo, "smartbeehive-f67f1", "", documentPath.c_str(), content.raw())){
      Serial.printf("ok\n%s\n\n new add", fbdo.payload().c_str());
      return;
    }else{
      Serial.println(fbdo.errorReason());
    }
  }
}

//////////////////////////////////////

////////////// Get local date from npd //////////
String getCurrentDate()
{
  struct tm timeinfo;
  if (!getLocalTime(&timeinfo)) {
    Serial.println("Failed to obtain time");
    return "";
  }
  
  char date[20];
  strftime(date, sizeof(date), "%Y-%m-%d ", &timeinfo);
  Serial.println(String(date));
  return String(date);
}
////////////////////////////////////////////////

////////////// Get local hour from npd //////////
String getCurrentHour()
{
  struct tm timeinfo;
  if (!getLocalTime(&timeinfo)) {
    Serial.println("Failed to obtain time");
    return "";
  }
  
  char hour[20];
  strftime(hour, sizeof(hour), "%H:%M:%S", &timeinfo);
  Serial.println(String(hour));
  return String(hour);
}
////////////////////////////////////////////////

void loop() {

 buttonState = digitalRead(buttonPin);
 firestoreDataUpdate(readDHTTemperature(), readDHTHumidity(), String(buttonState));
  delay(10000);
}