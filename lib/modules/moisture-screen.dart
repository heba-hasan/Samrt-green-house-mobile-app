import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:http/http.dart' as http;

import '../shared/components/components.dart';
import '../shared/constant/colors.dart';
// double ?moisture;
class MoistureScreen extends StatefulWidget {

  @override
  State<MoistureScreen> createState() => _MoistureScreenState();
}

class _MoistureScreenState extends State<MoistureScreen> {
  var serverToken="AAAA3aWuCy8:APA91bGLM05c6Y1QoilwCPgyar6NgHPQuf8lk8WzcbPBYyE9pdsEnWyv2eFAzPuaaIbHZzfuW3SbRY1b5bQzunZoUYLZ44ruK3fX9gop_uPmaPNrWUmMIyDKW-8C_aS2COyxhXVssbtt";

  getmessage(){
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print('--------------');
      print(event.notification!.body);
      print('--------------');
    });

  }
  final ref3=FirebaseDatabase.instance.ref('moisture-sensor');

  bool status5 = false;

  @override
  void initState(){
    getmessage();
    super.initState();

  }
  Widget build(BuildContext context) {
    return Stack(
      children:[
        Image.asset('assets/images/4accea6bb0ecdde43c5730f33efbce46.jpg',height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white.withOpacity(0.77),
          colorBlendMode: BlendMode.colorDodge,
          fit: BoxFit.cover,),
        Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text('Soil moisture',),
              backgroundColor: defaultcolor.withOpacity(0.3),
              elevation: 0.5,
            ),
            body: Padding(
              padding: const EdgeInsets.all(40.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 30,),
                    Row(
                      children: [
                        Image.asset('assets/images/water-pump.png',width: 30,height: 30,),
                        SizedBox(width: 10,),
                        Text('Pump',style: TextStyle(fontSize: 25),),
                        Spacer(),
                        FlutterSwitch(
                          width: 57.0,
                          height: 27.0,
                          activeColor: defaultcolor,
                          showOnOff: true,
                          inactiveColor: Colors.blueGrey.shade400,
                          valueFontSize: 12.0,
                          toggleSize: 18.0,
                          value: status5,
                          onToggle: (val) {
                            setState(() {
                              status5 = val;
                              print(status5);
                              FirebaseDatabase.instance.ref().child('pump').set({
                                'on':status5
                              });
                            });
                          },



                        )],
                    ),
                    SizedBox(height: 110,),
                    Container(
                      height: 300,
                      child: FirebaseAnimatedList(query: ref3, itemBuilder: (context,snapshot,animation,index){
                        // moisture=snapshot.child('value').value as double?;
                        print('_________________-');
                        print(snapshot.child('value').value.toString());
                        print('_________________-');
                        return  SensorScreencomponant(
                            text1: 'Soil moisture',
                            readind: snapshot.child('value').value.toString() ,
                            unit: "%"
                        );
                      }),
                    ),


                  ],
                ),
              ),
            )
        ),
      ]

    );}
}
