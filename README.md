# smartgreanhouse
MOBILE APPLICATION FEATURES
1) On Boarding Page: to welcome users when they install the application at the first time.
   
2) Register / Login Page: feature to sign up for the app to make our users uniquely join and easily manage their greenhouse . Firebase automatically saves the user with unique ID when he signed in at the first time and also saved in (SharedPreference) that is the way in which one can store and retrieve small amounts of primitive data as key/value pairs to a file on the device storage also firebase store user's data after registering to the app.
   
3) Home Page: This page with CarouselSlider widget which is a slideshow for cycling through a series of images and a welcome sentence for the user containing his/her which is stored in Firestore database that. In this page user can choose which greenhouse's condition he wants to check. 
 
4) Display Sensors Reading Page: In this page user can monitor the greenhouse conditions such as lighting, temperature, soil moisture, fertilizers amount, water level in tank and weather condition. These values are sensors readings that stored in Realtime Database.

5) Control Actuators Easily:
The user can easily control the actuators such as fan, water pump and LED At the push of a button. When the user switches the button ON or OFF this value is sent to Realtime database which ESP8266 can get this value and hence change its output.

 6)Push Notification:
User can receive notification when it necessary to make an action like turning on the led or filling the tank.

