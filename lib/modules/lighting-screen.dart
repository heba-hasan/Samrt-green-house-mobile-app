import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../layout/cubit/home-cubit.dart';
import '../main.dart';
import '../shared/components/components.dart';
import '../shared/constant/colors.dart';

class LighingScreen extends StatefulWidget {

   late String? title;
  @override
  State<LighingScreen> createState() => _LighingScreenState();
}

class _LighingScreenState extends State<LighingScreen> {
  bool status4 = false;
  String raeding="";
  final ref4=FirebaseDatabase.instance.ref('led');
  final LDR=FirebaseDatabase.instance.ref('LDRsensor');
  @override
void initState() {
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





  Widget build(BuildContext context) {
    return Stack(
      children: [

        Image.asset('assets/images/26b0f4c4710f67a8a9121579b9f817fb (2).jpg',height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white.withOpacity(0.77),
          colorBlendMode: BlendMode.colorDodge,
          fit: BoxFit.cover,),
        Scaffold(
          backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('Lighting',),
          backgroundColor: defaultcolor.withOpacity(0.3),
          elevation: 0.5,
        ),
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 30,),
                  Row(
                    children: [
                      Image.asset('assets/images/creative.png',width: 30,height: 30,),
                      SizedBox(width: 10,),
                      Text('Led',style: TextStyle(fontSize: 25),),
                      Spacer(),
                      FlutterSwitch(
                        width: 55.0,
                        height: 25.0,
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
                  ),
                  SizedBox(height: 190,),
                  Container(
                  height: 300,
                  child: FirebaseAnimatedList(query: LDR,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context,snapshot,animation,index){
                        raeding=snapshot.child('value').value.toString();
                        // if(raeding=='38') showNotification();
                        return CircularPercentIndicator(

                          radius:100,
                          percent: (double.parse('$raeding ')/100),
                          center: Text('${raeding}%',style: TextStyle(
                            fontSize: 25,
                          ),),
                          circularStrokeCap: CircularStrokeCap.round,
                          // progressColor: Colors.green[700],
                          startAngle: 270,
                          restartAnimation: true,
                          lineWidth: 12,
                          header: Text('Light intensity',style:TextStyle(
                              fontSize: 25,
                          ) ,),
                          backgroundColor: Colors.grey.withOpacity(0.3),
                          animationDuration: 5,
                          curve: Curves.easeInToLinear,
                          rotateLinearGradient: true,
                          linearGradient: LinearGradient(colors: [
                            CupertinoColors.systemIndigo,

                            Colors.purple,
                            Colors.purple,
                            Colors.purpleAccent,
                            CupertinoColors.systemPurple,

                          ]),
                        );}),
                ),

                ],
              ),
            ),
          ),
        ),
      )],
    );
  }
}
