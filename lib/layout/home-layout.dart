import 'dart:collection';
import 'dart:convert';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:weather_icons/weather_icons.dart';
import '../main.dart';
import '../modules/fertilizers-screen.dart';
import '../modules/lighting-screen.dart';
import '../modules/login-screen.dart';
import '../modules/moisture-screen.dart';
import '../modules/profile-screen.dart';
import '../modules/temp-screen.dart';
import '../shared/cach-helper.dart';
import '../shared/components/components.dart';
import '../shared/constant/colors.dart';
import 'cubit/home-cubit.dart';
import 'cubit/home-state.dart';
import 'home-component.dart';
import 'package:http/http.dart' as http;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null) {
    flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,

        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            color: Colors.blue,
            playSound: true,
            icon: '@mipmap/ic_launcher',
            priority: Priority.max,
            importance: Importance.high,
            visibility: NotificationVisibility.public,

          ),
        ));
  }
  print("Handling a background message: ${message.messageId}");
}
class Homelayout extends StatefulWidget
{
  @override
  State<Homelayout> createState() => _HomelayoutState();
}

class _HomelayoutState extends State<Homelayout> {

  var serverToken="AAAA3aWuCy8:APA91bGLM05c6Y1QoilwCPgyar6NgHPQuf8lk8WzcbPBYyE9pdsEnWyv2eFAzPuaaIbHZzfuW3SbRY1b5bQzunZoUYLZ44ruK3fX9gop_uPmaPNrWUmMIyDKW-8C_aS2COyxhXVssbtt";



  SendNotification(String title,String id) async{
    await http.post( Uri.parse('https://fcm.googleapis.com/fcm/send')
      ,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': 'Check your greenhouse',
            'title': title.toString()

          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': id.toString(),
            'status': 'done',
          },
          'to': await FirebaseMessaging.instance.getToken(),
          "android": {
            "priority": "HIGH",
            "notification":
            {
              "notification_priority": "PRIORITY_MAX",
              "sound": "default",
              "default_sound": true,
              "default_vibrate_timings":true,
              "default_light_settings":true
            }
          },
        },
      ),
    );

  }

  getmessage(){
    FirebaseMessaging.onMessage.listen((event) {
      print('--------------');
      print(event.notification!.body);
      print('--------------');
    });


  }



  @override
  void initState(){
    getmessage();
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,

            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
                priority: Priority.max,
                importance: Importance.high,
                visibility: NotificationVisibility.public,

              ),
            ));
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });
      }
    });
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

}
  // void showNotification() {
  //   flutterLocalNotificationsPlugin.show(
  //       0,
  //       "Check your green house",
  //       "please turn on the led now",
  //       NotificationDetails(
  //           android: AndroidNotificationDetails(channel.id, channel.name,
  //               channelDescription: channel.description,
  //               importance: Importance.high,
  //               color: Colors.blue,
  //               playSound: true,
  //               icon: '@mipmap/ic_launcher')));
  // }
  final refwaterlevel=FirebaseDatabase.instance.ref('tank-level');
  String ? waterlevel;
  String ? raindetect;
  String ? raining;
  Color? color;
  Color? colors;

  bool status4 = false;
  String ?result;
  String raeding="";
  double ?moisture1;
  double ?temp1;
  double ?hum1;
  final ref4=FirebaseDatabase.instance.ref('led');
  final LDR=FirebaseDatabase.instance.ref('ldrdensor');
  final detection= FirebaseDatabase.instance.ref('h/plants');
  final ref3=FirebaseDatabase.instance.ref('moisture-sensor');
  final n=FirebaseDatabase.instance.ref('Nitrogen');
  final p=FirebaseDatabase.instance.ref('Potassium');
  final k=FirebaseDatabase.instance.ref('Phosphorous');
  final mois=FirebaseDatabase.instance.ref('moisture-sensor');
  final temp=FirebaseDatabase.instance.ref('Temp');
  final rain=FirebaseDatabase.instance.ref('rain');
  bool stepper1=false;
  bool stepper2=false;

  final humidity=FirebaseDatabase.instance.ref('Humidity');
  var disease;

  Widget build(BuildContext context) {

    print('_________________');
    FirebaseAnimatedList(
        query: FirebaseDatabase.instance.ref('h/plants'),
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, snapshot, animation, index)
        {
          disease=snapshot.child('0').value.toString();
          print('__________de_______');

          print(disease);
          print('__________de_______');
          return Text(' ');
        });
    print(disease);
    // FirebaseAnimatedList(query: mois, itemBuilder: (context,snapshot,animation,index){
    //   moisture1=snapshot.child('value').value as double?;
    //   if( moisture1!<60){
    //     SendNotification('Open the pump','3');
    //   }
    //   else{
    //     SendNotification('Close the pump','4');
    //   }
    //   return  Text('');
    // });
    // FirebaseAnimatedList(query: temp, itemBuilder: (context,snapshot,animation,index){
    //   temp1 =snapshot.child('value').value as double?;
    //   if( temp1!<18){
    //     SendNotification('turn on the heater','5');
    //   }
    //   else{
    //     SendNotification('turn off the heater','6');
    //   }
    //   return  Text('');
    // });
    // FirebaseAnimatedList(query: humidity, itemBuilder: (context,snapshot,animation,index){
    //   hum1=snapshot.child('value').value as double?;
    //   if(hum1 !<60){
    //     SendNotification('turn off the fan','7');
    //   }
    //   else{
    //     SendNotification('turn on the fan','8');
    //   }
    //   return  Text('');
    // });
    // print('__________de_______');
    // print(disease);
    // print('__________de_______');

    // FirebaseAnimatedList(query: ref3, itemBuilder: (context,snapshot,animation,index){
    //   moisture=snapshot.child('value').value.toString();
    //   print('_________________-');
    //   print(snapshot.child('value').value.toString());
    //   print('_________________-');
    //   return  Text('');
    // });

    return BlocProvider(
      create: (context) => HomeCubit()..getuserdata(),
      child: BlocConsumer<HomeCubit,HomeStates>(
        builder:(context, state) {
          print(disease);
          print('yees');
          // print(moisture);

          if(disease!=null) {
            SendNotification('Your crops have ${disease}','14');
            print('noooooooooooo');

          };

           return Stack(
             children:
             [
            Image.asset('assets/images/b9f3f2c2ce853acbdcbf4cd0dd7d1b8c.jpg',height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.white.withOpacity(0.7),
              colorBlendMode: BlendMode.colorDodge,
              fit: BoxFit.cover,),
            Scaffold(
              backgroundColor:Colors.transparent,
              appBar: AppBar(
                foregroundColor: Colors.transparent,
// backgroundColor: Colors.transparent,
//                 shadowColor: Colors.transparent,
                title: Text('Greenhouse'),

                // centerTitle: true,
                actions: [
                  IconButton(
                      icon: Icon(Icons.logout_sharp,color: Colors.white), onPressed: (){
                    CachHelper.cleardata(key: 'Uid');
                    NavigateToAndReplace(context, LoginScreen());
                  }
                  )
                ],
              ),
              body:
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.transparent,
                      child: CarouselSlider(

                        items: [
                          Container(
                              width: double.infinity,
                              child: Image(image: AssetImage('assets/images/farmer-using-remote-sensors-to-collect-farm-data-4254636-3535125 (1).jpg'),fit: BoxFit.cover,)),
                          Container(
                              width: double.infinity,
                              child: Image(image: AssetImage('assets/images/neeewimage.png'),fit: BoxFit.cover,)),
                          Container(
                              width: double.infinity,
                              child: Image(image: AssetImage('assets/images/mob.png'),fit: BoxFit.cover,)),
                          Container(
                              width: double.infinity,
                              child: Image(image: AssetImage('assets/images/reg.png'),fit: BoxFit.cover)),
                          Container(
                              width: double.infinity,
                              child: Image(image: AssetImage('assets/images/farmers-using-modern-farming-technology-4254627-3535116.png'),fit: BoxFit.cover)),
                        ],
                        options: CarouselOptions(
                            height: 150,
                            viewportFraction: 1,
                            autoPlay: true,
                            initialPage: 0,
                            scrollPhysics: BouncingScrollPhysics(),
                            autoPlayAnimationDuration: Duration(seconds: 1 ),
                            autoPlayInterval: Duration(seconds: 3),
                            reverse: false,
                            enableInfiniteScroll: true,
                            enlargeCenterPage: true

                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    ConditionalBuilder(
                      condition: state is GetUserdatasucessState,
                      builder:(context) =>Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Hello ${HomeCubit.get(context).model?.name!}..!',style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500
                                ),),
                                Text('monitor your greenhouse easily now.',style:Theme.of(context).textTheme.caption ,),
                                // SizedBox(height: 30,),
                                //                               // Text('Basic characteristic',style: TextStyle(
                                //                               //     fontSize: 30
                                //                               // ),),
                                SizedBox(height: 10,),
                                Container(
                                  child: GridView.count(

                                      crossAxisCount: 2,
                                      childAspectRatio: 2/2,
                                      mainAxisSpacing:10.0 ,
                                      crossAxisSpacing:10.0 ,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      children:
                                      [

                                        SensorsgridItems( 'Temperature and humidity','assets/images/humidity.png', TempScreen(),context,),
                                        SensorsgridItems( 'Soil moisture', 'assets/images/soil-analysis (1).png',  MoistureScreen(),context,),
                                        SensorsgridItems( 'Fertilizers','assets/images/npk.png',  FirtilizerScreen(),context,),

                                        // SensorsgridItems('fertilizers', 'assets/images/npk.png', FirtilizerScreen(),context,),
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.grey.withOpacity(0.6),
                                              ),
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(17)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child:  Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Image.asset('assets/images/water-tank.png',width: 40,height: 40,),
                                                SizedBox(height: 20,),
                                                const Expanded(
                                                  child: Text('Water level',style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.w500
                                                  ),),
                                                ),
                                                Expanded(
                                                    child: Center(
                                                      child: FirebaseAnimatedList(query: refwaterlevel,
                                                          physics: NeverScrollableScrollPhysics(),
                                                          itemBuilder: (context,snapshot,animation,index){
                                                            waterlevel=snapshot.child('tank').value.toString();
                                                            if (waterlevel == 'empty!') {
                                                              color = Colors.redAccent;
                                                              //SendNotification('It is time to fill the tank','1');
                                                               notification(body:'It is time to fill the tank', id: '11' );

                                                              //SendNotification('It is time to fill the tank','2');
                                                              //  SendNotification('It is time to fill','2');
                                                              //  notification(body: 'It is time to fill the tank');

                                                            }
                                                            else color=Colors.lightGreen;

                                                            return Center(
                                                              child: Text(waterlevel!,style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight: FontWeight.w500,
                                                                  color: color
                                                              )),
                                                            );
                                                          }),
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.grey.withOpacity(0.6),
                                              ),
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(17)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child:  Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Image.asset('assets/images/rainy (4).png',height: 40,width: 40,),
                                                SizedBox(height: 20,),
                                                // const Expanded(
                                                //   child: Text('Rain',style: TextStyle(
                                                //       fontSize: 20,
                                                //       fontWeight: FontWeight.w500,
                                                //       overflow: TextOverflow.ellipsis
                                                //   ),),
                                                // ),
                                                Expanded(
                                                    child: Center(
                                                      child: FirebaseAnimatedList(query: rain,
                                                          physics: NeverScrollableScrollPhysics(),
                                                          itemBuilder: (context,snapshot,animation,index){
                                                            raindetect=snapshot.child('value').value.toString();
                                                            if (raindetect == "Rain Detected") {
                                                              raining="Raining";
                                                              color = Colors.lightGreen;
                                                              // SendNotification('Open the window','10');
                                                               notification(body:'It is raining open the window', id: '10' );

                                                              //SendNotification('It is time to fill the tank','2');
                                                              //  SendNotification('It is time to fill','2');
                                                              //  notification(body: 'It is time to fill the tank');

                                                            }
                                                            else {
                                                            color = Colors
                                                                .redAccent;
                                                            raining= "No rain";
                                                          }

                                                          return Center(
                                                            child: Column(
                                                              children: [
                                                                Text(raining!,style: TextStyle(
                                                                    fontSize: 20,
                                                                    fontWeight: FontWeight.w500,
                                                                    color: color
                                                                )),

                                                                // SizedBox(height: 5,),
                                                                // Row(
                                                                //   children: [
                                                                //
                                                                //     Text("ccw",style: TextStyle(fontSize: 15),),
                                                                //     Spacer(),
                                                                //     FlutterSwitch(
                                                                //       width: 52.0,
                                                                //       height: 20.0,
                                                                //       activeColor: defaultcolor,
                                                                //       inactiveColor: Colors.blueGrey.shade400,
                                                                //       padding: 4,
                                                                //       showOnOff: true,
                                                                //       valueFontSize: 12.0,
                                                                //       toggleSize: 18.0,
                                                                //       value: stepper2,
                                                                //       onToggle: (val) {
                                                                //
                                                                //         setState(() {
                                                                //           stepper2 = val;
                                                                //           print(stepper2);
                                                                //           FirebaseDatabase.instance.ref().child('close-window').set({
                                                                //             'switch':stepper2
                                                                //           });
                                                                //         });
                                                                //       },
                                                                //
                                                                //
                                                                //
                                                                //     )
                                                                //
                                                                //   ],
                                                                // )
                                                              ],
                                                            ),
                                                          );
                                                          }),
                                                    )),
                                                Spacer(),
                                                Expanded(
                                                  child: Row(
                                                    children: [

                                                      Text("Window",style: TextStyle(fontSize: 15),),
                                                      Spacer(),
                                                      FlutterSwitch(
                                                        width: 52.0,
                                                        height: 20.0,
                                                        activeColor: defaultcolor,
                                                        inactiveColor: Colors.blueGrey.shade400,
                                                        padding: 4,
                                                        showOnOff: true,
                                                        valueFontSize: 12.0,
                                                        toggleSize: 18.0,
                                                        value: stepper1,
                                                        onToggle: (val) {

                                                          setState(() {
                                                            stepper1 = val;
                                                            print(stepper1);
                                                            FirebaseDatabase.instance.ref().child('open-window').set({
                                                              'on':stepper1
                                                            });
                                                          });
                                                        },



                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.grey.withOpacity(0.6),
                                              ),
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(17)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child:  Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Image.asset('assets/images/creative.png',width: 40,height: 40,),
                                                SizedBox(height: 20,),
                                                Expanded(
                                                  child: Text("${result}",style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.w500,
                                                    color: colors
                                                  ),),
                                                ),
                                                Spacer(),
                                                Expanded(
                                                    child: Center(
                                                      child: FirebaseAnimatedList(query: LDR,
                                                          physics: NeverScrollableScrollPhysics(),
                                                          itemBuilder: (context,snapshot,animation,index){

                                                            print(snapshot.child('value').value.toString());

                                                            if (snapshot.child('value').value.toString() == '1') {
                                                              result = 'No light';
                                                              colors=Colors.redAccent;
                                                              AndroidAlarmManager.oneShot(Duration(seconds: 3), 1,Timer );
                                                            } else {
                                                              result = 'Lighting';
                                                              colors=Colors.lightGreen;
                                                              // notification(body: 'please turn on the led now', id: '4');

                                                            }

                                                            return Center(
                                                              child:Row(
                                                                children: [

                                                                  Text("Led",style: TextStyle(fontSize: 15),),
                                                                  Spacer(),
                                                                  FlutterSwitch(
                                                                    width: 52.0,
                                                                    height: 20.0,
                                                                    activeColor: defaultcolor,
                                                                    inactiveColor: Colors.blueGrey.shade400,
                                                                    padding: 4,
                                                                    showOnOff: true,
                                                                    valueFontSize: 12.0,
                                                                    toggleSize: 18.0,
                                                                    value: status4,
                                                                    onToggle: (val) {

                                                                      setState(() {
                                                                        status4 = val;
                                                                        print(status4);
                                                                        FirebaseDatabase.instance.ref().child('light').set({
                                                                          'switch':status4
                                                                        });
                                                                      });
                                                                    },



                                                                  )],
                                                              )
                                                              ,
                                                            );
                                                          }),
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                        // Container(
                                        //   decoration: BoxDecoration(
                                        //       border: Border.all(color: Colors.grey.withOpacity(0.6),
                                        //       ),
                                        //       color: Colors.white,
                                        //       borderRadius: BorderRadius.circular(17)
                                        //   ),
                                        //   child: Padding(
                                        //     padding: const EdgeInsets.all(15.0),
                                        //     child:  Column(
                                        //       mainAxisAlignment: MainAxisAlignment.center,
                                        //       children: [
                                        //         Image.asset('assets/images/npk.png',width: 40,height: 40,),
                                        //         SizedBox(height: 20,),
                                        //         Expanded(
                                        //           child: Text('Fertilizers',style: TextStyle(
                                        //               fontSize: 20,
                                        //               fontWeight: FontWeight.w500
                                        //           ),),
                                        //         ),
                                        //         Spacer(),
                                        //         // Expanded(
                                        //         //   child: FirebaseAnimatedList(query: n,
                                        //         //       physics: NeverScrollableScrollPhysics(),
                                        //         //       itemBuilder: (context,snapshot,animation,index){
                                        //         //
                                        //         //         print(snapshot.child('value').value.toString());
                                        //         //
                                        //         //         return Center(
                                        //         //           child:Row(
                                        //         //             children: [
                                        //         //               Text("Nitrogen:",style: TextStyle(fontSize: 11,overflow: TextOverflow.ellipsis),),
                                        //         //
                                        //         //               Text(" ${snapshot.child('value').value.toString()} ",style: TextStyle(fontSize: 11,overflow: TextOverflow.ellipsis,color: Colors.red),),
                                        //         //               Text("mg/kg",style: TextStyle(fontSize: 11,overflow: TextOverflow.ellipsis),),]
                                        //         //
                                        //         //
                                        //         //           )
                                        //         //           ,
                                        //         //         );
                                        //         //       }),
                                        //         // ),
                                        //         // Expanded(
                                        //         //   child: FirebaseAnimatedList(query: p,
                                        //         //       physics: NeverScrollableScrollPhysics(),
                                        //         //       itemBuilder: (context,snapshot,animation,index){
                                        //         //
                                        //         //         print(snapshot.child('value').value.toString());
                                        //         //
                                        //         //         return Center(
                                        //         //           child:Row(
                                        //         //             children: [
                                        //         //               Text("Potassium:",style: TextStyle(fontSize: 11,overflow: TextOverflow.ellipsis),),
                                        //         //
                                        //         //               Text(" ${snapshot.child('value').value.toString()} ",style: TextStyle(fontSize: 11,overflow: TextOverflow.ellipsis,color: Colors.red),),
                                        //         //               Text("mg/kg",style: TextStyle(fontSize: 11,overflow: TextOverflow.ellipsis),)
                                        //         //          ])
                                        //         //           ,
                                        //         //         );
                                        //         //       }),
                                        //         // ),
                                        //         // Expanded(
                                        //         //   child: FirebaseAnimatedList(query: k,
                                        //         //       physics: NeverScrollableScrollPhysics(),
                                        //         //       itemBuilder: (context,snapshot,animation,index){
                                        //         //
                                        //         //         print(snapshot.child('value').value.toString());
                                        //         //
                                        //         //         return Center(
                                        //         //           child:Row(
                                        //         //             children: [
                                        //         //               Text("Phosphorous:",style: TextStyle(fontSize: 11,overflow: TextOverflow.ellipsis),),
                                        //         //
                                        //         //               Text(" ${snapshot.child('value').value.toString()} ",style: TextStyle(fontSize: 11,overflow: TextOverflow.ellipsis,color: Colors.red),),
                                        //         //               Text("mg/kg",style: TextStyle(fontSize: 11,overflow: TextOverflow.ellipsis),)
                                        //         //
                                        //         //           ])
                                        //         //           ,
                                        //         //         );
                                        //         //       }),
                                        //         // ),
                                        //       ],
                                        //     ),
                                        //   ),
                                        // ),

                                      ]),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      fallback: (context) => Center(child: CircularProgressIndicator()),


                    ),
                  ],
                ),
              ),

            ),
          ],);
        },

        listener: (context, state) {},),
    );
  }
}
 void Timer(){
notification(body: 'please turn on the led now', id: '4');
print('timer done');
}