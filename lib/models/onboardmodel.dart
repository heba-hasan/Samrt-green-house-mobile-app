

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../shared/styles/fonts/font.dart';

class OnBoardModel{

  String ?image;
  String ?text1;
  String ?text2;
  OnBoardModel({this.image,this.text1,this.text2});

}
 Widget OnBoardItems(OnBoardModel model)=>Column(
   children: [
     SizedBox(height: 130,),
     Image(image: AssetImage('${model.image}'),height: 300,width: double.infinity,),
     SizedBox(height: 40,),
     Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Text("${model.text2}",style: TextStyle(fontSize: 23,fontWeight: FontWeight.w700,fontFamily: textstyle),overflow: TextOverflow.ellipsis,maxLines: 2),
         SizedBox(height: 16,),
         Text("${model.text1}",style: TextStyle(fontSize: 13,color: Colors.grey),),
       ],
     )],


 );