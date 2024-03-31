
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../shared/components/components.dart';
import '../shared/constant/colors.dart';

Widget SensorsgridItems(
       String text,
       String ? icon,
     Widget widget,
      context,
    )=>InkWell(
  onTap: (){
    NavigateTo(context, widget);
  },
      child: Container(
       child: Padding(
         padding: const EdgeInsets.all(15.0),
         child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(icon!,width: 40,height: 40,),
          SizedBox(height: 20,),
          Expanded(
            child: Text(text,style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500
            ),),
          ),
      ],
  ),
       ),
  decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.6),
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(17)
  ),
),
    );