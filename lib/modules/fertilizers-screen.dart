import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../shared/components/components.dart';
import '../shared/constant/colors.dart';

class FirtilizerScreen extends StatelessWidget {
  @override
  final n=FirebaseDatabase.instance.ref('Nitrogen');
  final p=FirebaseDatabase.instance.ref('Potassium');
  final k=FirebaseDatabase.instance.ref('Phosphorous');

  Widget build(BuildContext context) {
    return
      Stack(
        children:[
          Image.asset('assets/images/b9f3f2c2ce853acbdcbf4cd0dd7d1b8c.jpg',height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white.withOpacity(0.74),
            colorBlendMode: BlendMode.srcATop,
            fit: BoxFit.cover,),
          Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                title: Text('Fertilizers',),
                backgroundColor: defaultcolor.withOpacity(0.3),
                elevation: 0.5,
              ),
              body: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    // Expanded(
                    //   child: FirebaseAnimatedList(query: n,
                    //       physics: NeverScrollableScrollPhysics(),
                    //       itemBuilder: (context,snapshot,animation,index){
                    //
                    //         print(snapshot.child('value').value.toString());
                    //
                    //         return Center(
                    //           child:Row(
                    //             children: [
                    //
                    //               Text("Nitrogen: ${snapshot.child('value').value.toString()} mg/kg",style: TextStyle(fontSize: 20,),),],
                    //           )
                    //           ,
                    //         );
                    //       }),
                    // ),
                    // Expanded(
                    //   child: FirebaseAnimatedList(query: p,
                    //       physics: NeverScrollableScrollPhysics(),
                    //       itemBuilder: (context,snapshot,animation,index){
                    //
                    //         print(snapshot.child('value').value.toString());
                    //
                    //         return Center(
                    //           child:Row(
                    //             children: [
                    //
                    //               Text("Potassium: ${snapshot.child('value').value.toString()} mg/kg",style: TextStyle(fontSize: 20),),],
                    //           )
                    //           ,
                    //         );
                    //       }),
                    // ),
                    // Expanded(
                    //   child: FirebaseAnimatedList(query: k,
                    //       physics: NeverScrollableScrollPhysics(),
                    //       itemBuilder: (context,snapshot,animation,index){
                    //
                    //         print(snapshot.child('value').value.toString());
                    //
                    //         return Center(
                    //           child:Row(
                    //             children: [
                    //
                    //               Text("Phosphorous: ${snapshot.child('value').value.toString()} mg/kg",style: TextStyle(fontSize: 20),),],
                    //           )
                    //           ,
                    //         );
                    //       }),
                    // ),

                     Text('The current values of the fertilizers present in the soil...',style: TextStyle(fontSize: 20,color: Colors.teal.shade700),),
                    SizedBox(height: 50,),
                   
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: FirebaseAnimatedList(query: n,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context,snapshot,animation,index){

                                  print(snapshot.child('value').value.toString());

                                  return Center(
                                    child:Row(
                                      children: [
                                        Text("Nitrogen:",style: TextStyle(fontSize: 20,overflow: TextOverflow.ellipsis),),

                                        Text(" ${snapshot.child('value').value.toString()} ",style: TextStyle(fontSize:20,overflow: TextOverflow.ellipsis,color: Colors.red),),
                                        Text(" mg/kg",style: TextStyle(fontSize: 15,overflow: TextOverflow.ellipsis),),]


                                    )
                                    ,
                                  );
                                }),
                          ),
                          Expanded(
                            child: FirebaseAnimatedList(query: p,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context,snapshot,animation,index){

                                  print(snapshot.child('value').value.toString());

                                  return Center(
                                    child:Row(
                                      children: [
                                        Text("Potassium:",style: TextStyle(fontSize: 20,overflow: TextOverflow.ellipsis),),

                                        Text(" ${snapshot.child('value').value.toString()} ",style: TextStyle(fontSize: 20,overflow: TextOverflow.ellipsis,color: Colors.red),),
                                        Text(" mg/kg",style: TextStyle(fontSize: 15,overflow: TextOverflow.ellipsis),)
                                   ])
                                    ,
                                  );
                                }),
                          ),
                          Expanded(
                            child: FirebaseAnimatedList(query: k,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context,snapshot,animation,index){

                                  print(snapshot.child('value').value.toString());

                                  return Center(
                                    child:Row(
                                      children: [
                                        Text("Phosphorous:",style: TextStyle(fontSize: 20,overflow: TextOverflow.ellipsis),),

                                        Text(" ${snapshot.child('value').value.toString()} ",style: TextStyle(fontSize: 20,overflow: TextOverflow.ellipsis,color: Colors.red),),
                                        Text("mg/kg",style: TextStyle(fontSize: 15,overflow: TextOverflow.ellipsis),)

                                    ])
                                    ,
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 300,),
                  ],
                ),
              )
          ),
        ]

      );}
}
