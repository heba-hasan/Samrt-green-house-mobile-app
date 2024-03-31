import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../shared/constant/colors.dart';

class WaterLevelScreen extends StatefulWidget {
  const WaterLevelScreen({Key? key}) : super(key: key);

  @override
  State<WaterLevelScreen> createState() => _WaterLevelScreenState();
}

class _WaterLevelScreenState extends State<WaterLevelScreen> {
  @override
  bool status6 = false;
  String raeding="";
  final refwaterlevel=FirebaseDatabase.instance.ref('tank-level');
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        Image.asset('assets/images/4accea6bb0ecdde43c5730f33efbce46.jpg',height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white.withOpacity(0.77),
          colorBlendMode: BlendMode.colorDodge,
          fit: BoxFit.cover,),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('Water Level in tank',),
            backgroundColor: defaultcolor.withOpacity(0.3),
            elevation: 0.5,
          ),
          body: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 190,),
                    Container(
color: Colors.amber,
                      height: 300,
                      child: FirebaseAnimatedList(query: refwaterlevel,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context,snapshot,animation,index){

                            return
                              Text(snapshot.child('tank').value.toString(),style: TextStyle(color: Colors.black,),);
                      }),
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
