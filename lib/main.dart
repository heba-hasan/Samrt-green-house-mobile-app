import 'dart:convert';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bloc/bloc.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:smartgreanhouse/shared/cach-helper.dart';
import 'package:smartgreanhouse/shared/components/components.dart';
import 'package:smartgreanhouse/shared/constant/colors.dart';
import 'package:smartgreanhouse/shared/cubit/theme/theme-cubit.dart';
import 'package:smartgreanhouse/shared/cubit/theme/theme-state.dart';
import 'package:smartgreanhouse/shared/styles/bloc_observer.dart';
import 'package:smartgreanhouse/shared/styles/fonts/font.dart';
import 'layout/home-layout.dart';
import 'modules/login-screen.dart';
import 'modules/start-page.dart';
import 'package:http/http.dart' as http;

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
    'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
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

void main()async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CachHelper.init();
  await AndroidAlarmManager.initialize();
  Bloc.observer = MyBlocObserver();
  bool ?onboarding= CachHelper.getdata(key: 'Onboarding');
  String ?Uid =CachHelper.getdata(key: 'Uid');
  var token = await FirebaseMessaging.instance.getToken();
  print(token);
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  // FirebaseMessaging.onMessage.listen((event)
  // {
  //   print('done onn');
  // });
  // FirebaseMessaging.onMessageOpenedApp.listen((event)
  // {
  //   print('done');
  // });


  Widget widget;
    if(onboarding !=null)
{
  print("yes");
  if(Uid !=null) {
      widget = Homelayout();

    } else  widget= LoginScreen();
}
    else {
  widget = StartPage();
    print("No");
  }
  runApp(MyApp(
    startwidget: widget,
  ));
}
// Future<void> handlePushNotofocation(RemoteMessage message) async{
//   var serverToken="AAAA3aWuCy8:APA91bGLM05c6Y1QoilwCPgyar6NgHPQuf8lk8WzcbPBYyE9pdsEnWyv2eFAzPuaaIbHZzfuW3SbRY1b5bQzunZoUYLZ44ruK3fX9gop_uPmaPNrWUmMIyDKW-8C_aS2COyxhXVssbtt";
//   SendNotification(String title,String body,String id) async{
//     await http.post( Uri.parse('https://fcm.googleapis.com/fcm/send')
//       ,
//       headers: <String, String>{
//         'Content-Type': 'application/json',
//         'Authorization': 'key=$serverToken',
//       },
//       body: jsonEncode(
//         <String, dynamic>{
//           'notification': <String, dynamic>{
//             'body': body.toString(),
//             'title': title.toString()
//           },
//           'priority': 'high',
//           'data': <String, dynamic>{
//             'click_action': 'FLUTTER_NOTIFICATION_CLICK',
//             'id': id.toString(),
//             'status': 'done'
//           },
//           'to': await FirebaseMessaging.instance.getToken(),
//         },
//       ),
//     );
//
//   }
// }

class MyApp extends StatelessWidget {
  Widget? startwidget;

  MyApp( {required this.startwidget});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme:
        ThemeData(
          fontFamily: textstyle,
          primarySwatch:defaultcolor,
          primaryColor:defaultcolor ,
          appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w500),
              iconTheme: IconThemeData(color: Colors.white)
          ),
        ),
        darkTheme: ThemeData(
          fontFamily: textstyle,
          primaryColor:defaultcolordarkmode ,
          appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w500),
              iconTheme: IconThemeData(color: Colors.white)
          ),
        ),


        home:startwidget,);
  }
}

