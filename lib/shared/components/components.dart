

import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:http/http.dart' as http;
import '../../main.dart';
import '../constant/colors.dart';

// Widget onboardItem()=>,

Widget defultfieldform({
  required TextEditingController controller,
  required TextInputType type,
  FormFieldValidator<String> ?validate,
  required String labletext,
  IconData? prefix,
  bool security =false,
  IconData ?suffex ,
  bool isSuffex=false,
  final Function() ? hideshow,
  final Function() ?onTap,
  Color ?color ,
  final Function ?onchange,
  final Function ?onsubmet,

  double borderRaduis=30,
})=>TextFormField(
  strutStyle: StrutStyle(height: 0.9),
  controller: controller,
  keyboardType:type,
  obscureText: security,
  validator: validate,
  onFieldSubmitted:(value)
  { onsubmet!(value);},
  //هنا بيطبع الايميل لما ادخل و اعمل submet
  // onChanged: (value) { onchange!(value);}, //هنابيطبع كل تغير يعني كل حرف بدخله بيطبعه + الي قبله
  decoration:  InputDecoration(
    labelText: labletext,
    labelStyle: TextStyle(color: color,),
    border:  OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRaduis),
    ),
    prefixIcon: Icon(prefix,color: color,),
    suffixIcon: isSuffex? IconButton(
        onPressed: hideshow!(),
        icon: security? Icon(suffex):Icon(Icons.visibility_off)): null),

  style: TextStyle(color: color),// (value) {
//   //   return validate();
//   // },
  onTap: onTap,
  // onChanged: ( value) {
  //    return onchange!(value);
  // },

);




Widget icona({required String text,})=>TextButton(onPressed: (){},
    child: Container
      (
        padding: EdgeInsetsDirectional.all(7),
        decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(19),
            border: Border.all(color: Colors.purple)
        ),
        child: Text("$text",style: TextStyle(
            color: Colors.white60,
            fontSize: 20
        ),))


);

Widget defultbottom({
  Color background= defaultcolor,
  double raduis = 5,
  double width= double.infinity,
  required String text ,
  final Function()? function,
  double size=20,
})=>Container(
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(raduis),
    ),
    width: width,
    child: MaterialButton(onPressed:()
    {
      function!();
    },
        child:  Text('$text',
          style: TextStyle(
            color: Colors.white,
            fontSize: size,
          ),
          textAlign: TextAlign.center,
        )));


Widget myseperated()=>Padding(
  padding: const EdgeInsets.all(8),

  child: Container(
    height: 1,
    width: double.infinity,
    color: Colors.grey,
  ),
);


void NavigateTo(context,Widget)=>
    Navigator.push(context,
        MaterialPageRoute(builder: (context)=>Widget,
        ));

void Navigateback(context,Widget)=>
    Navigator.pop(context,
        MaterialPageRoute(builder: (context)=>Widget,
        ));

void NavigateToAndReplace(context,Widget)=>
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context)=>Widget,
        ));

Widget SensorScreencomponant(
{
   String ?text1,
  required String readind,
   String? unit=' ',
}
    )=>Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
  children: [
      CircularPercentIndicator(
        radius:100,
         percent: (double.parse('$readind ') /100),
        center: Text('${readind}${unit}',style: TextStyle(
          fontSize: 25,
        ),),
        circularStrokeCap: CircularStrokeCap.round,
        // progressColor: Colors.green[700],
        startAngle: 270,
        restartAnimation: true,
        lineWidth: 12,
        header: Text('${text1}',style:TextStyle(
          fontSize: 25
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

      ),

      SizedBox(height: 70,),

  ],
),
    );

// Widget signout({String? key1, String? key2, context, Widget? widget})=>TextButton(
//     onPressed: (){
//       Cachehelper.cleardata(key: "key1");
//       Cachehelper.cleardata(key: "key2").then((value) {
//         NavigateToAndReplace(context, widget);
//       });
//     },
//     child:Text("Sign out",style: TextStyle(
//       fontSize: 20,
//     ), ));

void showflutterToast(
    {
      required String message,
      var backgroundColor,

    }
    ){
  Fluttertoast.showToast(
      msg:message ,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 16.0

  );

}
Future<void> notification({
  required String body,
  required String id,
})=> flutterLocalNotificationsPlugin.show(
      0,
      "Check your green house",
      body,
      NotificationDetails(
          android: AndroidNotificationDetails(channel.id, channel.name,
              channelDescription: channel.description,
              color: Colors.blue,
              playSound: true,

              priority: Priority.high,

              icon: '@mipmap/ic_launcher')));

var serverToken="AAAA3aWuCy8:APA91bGLM05c6Y1QoilwCPgyar6NgHPQuf8lk8WzcbPBYyE9pdsEnWyv2eFAzPuaaIbHZzfuW3SbRY1b5bQzunZoUYLZ44ruK3fX9gop_uPmaPNrWUmMIyDKW-8C_aS2COyxhXVssbtt";

SendNotification(String body,String id) async{
  await http.post( Uri.parse('https://fcm.googleapis.com/fcm/send')
    ,
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverToken',
    },
    body: jsonEncode(
      <String, dynamic>{
        'notification': <String, dynamic>{
          'body': body.toString(),
          'title': 'Check your greenhouse'
        },
         'priority': 'high',
        'data': <String, dynamic>{
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'id': id.toString(),
          'status': 'done'
        },
        'to': await FirebaseMessaging.instance.getToken(),

      },
    ),
  );

}

