import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartgreanhouse/layout/cubit/home-cubit.dart';
import 'package:smartgreanhouse/modules/registration-screen.dart';
import 'package:smartgreanhouse/shared/constant/colors.dart';

import '../layout/home-layout.dart';
import '../shared/cach-helper.dart';
import '../shared/components/components.dart';
import '../shared/constant/constants.dart';
import '../shared/cubit/login-cubit/logincubit.dart';
import '../shared/cubit/login-cubit/loginstates.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailcontroller=TextEditingController();

  var passwordcontroller=TextEditingController();

  var formkey= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return  BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener:  (context, state) {
      if(state is LoginerrorState) {
        showflutterToast(message: state.error.toString(),
            backgroundColor: Colors.redAccent);
      }
          if(state is LoginsucessState)
          {
            showflutterToast(message:'Logged in successfully',backgroundColor: defaultcolor);
            CachHelper.savedata(key: 'Uid', value: state.uid).then((value)
            {
              NavigateToAndReplace(context, Homelayout());
              print(Uid);
            }

            );
          }
        } ,
        builder: (context, state) {
          return
            Stack(
              children:
             [ Image.asset('assets/images/b9f3f2c2ce853acbdcbf4cd0dd7d1b8c.jpg',height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
               color: Colors.white.withOpacity(0.9),
               colorBlendMode: BlendMode.colorDodge,
                fit: BoxFit.cover,),
               Scaffold(

              backgroundColor: Colors.transparent,
                body: SingleChildScrollView(
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 200,
                          child: ClipRRect(
                              borderRadius: BorderRadius.only(bottomLeft:Radius.elliptical(70, 30) ,bottomRight:Radius.elliptical(70, 30) ),
                              child: Image(image: AssetImage('assets/images/mob.png',),fit: BoxFit.cover,)),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Text("please sign in to continue",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Column(
                            children: [
                              defultfieldform(
                                  controller: emailcontroller,
                                  type: TextInputType.text,
                                  labletext: "Email",
                                  prefix: Icons.email_outlined,
                                  validate: ( value) {
                                    if(value!.isEmpty){
                                      return "please enter your email";
                                    }}),
                              SizedBox(
                                height: 30,
                              ),
                              defultfieldform(
                                controller: passwordcontroller,
                                type: TextInputType.text,
                                labletext: "Password",
                                prefix: Icons.lock_open,
                                // isSuffex: true,
                                // hideshow: (){
                                //    LoginCubit.get(context).hidepass();
                                // },
                                validate: ( value){
                                  if(value!.isEmpty)
                                  {
                                    return "please enter your password";
                                  }

                                  return null ;
                                },
                                security: LoginCubit.get(context).hideshow,
                                color: Colors.grey,
                                // suffex :Icons.remove_red_eye_rounded,


                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is !LoginloadingState,
                          builder:(context) =>  defultbottom(
                              text: "Login",
                              width: 200,
                              raduis: 15,
                              function: (){
                                if(formkey.currentState!.validate()){
                                  LoginCubit.get(context).userLogin(
                                      email: emailcontroller.text,
                                      password: passwordcontroller.text
                                  );
                                };
                              }
                          ),
                          fallback: (context) => Center(child: CircularProgressIndicator()),

                        ),
                        // defultbottom(
                        //   text: "Login",
                        //   width: 200,
                        //   raduis: 15,
                        //   function: (){
                        //     if(formkey.currentState!.validate()) {
                        //       LoginCubit.get(context).userLogin(email: emailcontroller.text, password: passwordcontroller.text);
                        //
                        //
                        //     }
                        //   },
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Have not an acocunt?"),
                            SizedBox(
                              width: 5,
                            ),
                            TextButton(onPressed: (){
                              NavigateTo(context, RegisterScreen());
                            }, child:Text("Register now!"))
                          ],
                        )

                      ],
                    ),
                  ),
                )),]
            );
        },
      ),
    );

  }
}
