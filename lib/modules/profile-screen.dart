import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartgreanhouse/shared/cach-helper.dart';

import '../layout/cubit/home-cubit.dart';
import '../layout/cubit/home-state.dart';
import '../shared/components/components.dart';
import '../shared/constant/constants.dart';
import 'login-screen.dart';

class ProfileScreen extends StatelessWidget {
var namecontroller=TextEditingController();
var emailcontroller=TextEditingController();
var phonecontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener:(context, state) {
      },
      builder: (context, state) {
        var model = HomeCubit.get(context).model;
        namecontroller.text =model!.Uid!;
        phonecontroller.text=model!.phone!;
        return  Scaffold(
          appBar: AppBar(
            title: Text('Profile Setting'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
             child:Center(
               child: Column(

                 children:[
                   defultbottom(
                       text: "Sign out",
                       width: 200,
                       raduis: 15,
                       function: (){
                         CachHelper.cleardata(key: 'Uid').then((value)
                         {
                           NavigateToAndReplace(context, LoginScreen());
                           print("uid removed");
                           print(Uid);
                         }
                         );
                         ;
                       }

                   ),
                   SizedBox(height: 50,),
                   TextFormField(
                       controller:namecontroller ,
                       decoration: InputDecoration(
                         prefixIcon: Icon(Icons.drive_file_rename_outline),
                         border:InputBorder.none
                         ),
                       ),
                   SizedBox(height: 20,),
                   TextFormField(
                     controller:emailcontroller ,
                     decoration: InputDecoration(
                         prefixIcon: Icon(Icons.email_outlined),
                         border:OutlineInputBorder(borderRadius: BorderRadius.circular(30))
                     ),
                   ),
                   SizedBox(height: 20,),
                   TextFormField(
                     controller:phonecontroller ,
                     decoration: InputDecoration(
                       prefixIcon: Icon(Icons.phone),
                       border:OutlineInputBorder(borderRadius: BorderRadius.circular(30)
                       ),
                     ),

                   ),
                   // TextButton(
                   //   onPressed: () {  },
                   //   child: Text('Save changes'),
                   // ),
                   SizedBox(height: 100,),
                   defultbottom(
                       text: "Sign out",
                       width: 200,
                       raduis: 15,
                       function: (){
                         CachHelper.cleardata(key: 'Uid');
                         NavigateToAndReplace(context, LoginScreen());
                       }
                   ),
                 ]
               ),
             )));
      },
    );
  }
}
