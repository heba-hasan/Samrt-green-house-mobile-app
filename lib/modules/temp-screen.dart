import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../shared/components/components.dart';
import '../shared/constant/colors.dart';

class TempScreen extends StatefulWidget {
  @override
  State<TempScreen> createState() => _TempScreenState();
}

class _TempScreenState extends State<TempScreen> {
final ref=FirebaseDatabase.instance.ref('Temp');

final ref2=FirebaseDatabase.instance.ref('Humidity');

bool status3 = false;
bool heaterstatus = false;

  @override
  Widget build(BuildContext context) {
    return
      Stack(
        children:[
          Image.asset('assets/images/22ace3af7544e96b5251901b4c661029.jpg',height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white.withOpacity(0.73),
            colorBlendMode: BlendMode.colorDodge,
            fit: BoxFit.cover,),
          Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                title: Text('Temperature'),
                backgroundColor: defaultcolor.withOpacity(0.3),
                elevation: 0.5,
              ),
              body: Padding(
                padding: const EdgeInsets.all(40.0),
                child:
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 16,),
                      Row(
                        children: [
                          Image.asset('assets/images/fan.png',width: 30,height: 30,),
                          SizedBox(width: 10,),
                          Text('Fan',style: TextStyle(fontSize: 25),),
                          Spacer(),
                          FlutterSwitch(
                            width: 57.0,
                            height: 27.0,
                            activeColor: defaultcolor,
                            valueFontSize: 12.0,
                            toggleSize: 18.0,
                            showOnOff: true,
                            inactiveColor: Colors.blueGrey.shade400,
                            value: status3,
                            onToggle: (val) {
                              setState(() {
                                status3 = val;
                                print(status3);
                                FirebaseDatabase.instance.ref().child('fan').set({
                                  'on':status3
                                });
                              });
                            },



                          )],
                      ),
                      SizedBox(height: 50,),
                      Row(
                        children: [
                          Image.asset('assets/images/heating.png',width: 30,height: 30,),
                          SizedBox(width: 10,),
                          Text('Heater',style: TextStyle(fontSize: 25),),
                          Spacer(),
                          FlutterSwitch(
                            width: 57.0,
                            height: 27.0,
                            activeColor: defaultcolor,
                            valueFontSize: 12.0,
                            toggleSize: 18.0,
                            showOnOff: true,
                            inactiveColor: Colors.blueGrey.shade400,
                            value: heaterstatus,
                            onToggle: (val) {
                              setState(() {
                                heaterstatus = val;
                                print(heaterstatus);
                                FirebaseDatabase.instance.ref().child('Heater').set({
                                  'on':heaterstatus
                                });
                              });
                            },



                          )],
                      ),
                      SizedBox(height: 50,),
                      Container(
                        height: 300,

                        child: FirebaseAnimatedList(query: ref,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context,snapshot,animation,index){

                              return  SensorScreencomponant(
                                  text1: 'Temperature',
                                  readind:snapshot.child('value').value.toString(),
                                  unit: "°c"
                              );
                            }),
                      ),
                      Container(
                        height: 300,
                        child: FirebaseAnimatedList(query: ref2,
                            physics: NeverScrollableScrollPhysics(),

                            itemBuilder: (context,snapshot,animation,index)

                            {
                              return  SensorScreencomponant(
                                  text1: 'humidity',
                                  readind: snapshot.child('value').value.toString(),
                                  unit: "%"
                              );
                            }),
                      ),

                      // Row(
                      //   children: [
                      //     Icon(Icons.ac_unit,size: 30,color: defaultcolor,),
                      //     SizedBox(width: 15,),
                      //     Text('gh',style:TextStyle(
                      //       fontSize: 20,
                      //
                      //     ) ),
                      //     Spacer(),
                      //     Text('On',style: TextStyle(fontSize: 25),),
                      //   ],
                      // ),




                    ],
                  ),
                ),
              )


          ),
        ]

      );
    }
}