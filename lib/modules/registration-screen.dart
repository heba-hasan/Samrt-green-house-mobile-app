
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartgreanhouse/shared/constant/colors.dart';
import '../layout/home-layout.dart';
import '../shared/components/components.dart';
import '../shared/cubit/register-cubit/register-cubit.dart';
import '../shared/cubit/register-cubit/register-states.dart';
import 'login-screen.dart';
class RegisterScreen extends StatelessWidget {
  var emailcontroller=TextEditingController();
  var passwordcontroller=TextEditingController();
  var phonecontroller=TextEditingController();
  var namecontroller=TextEditingController();
  var formkey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>RegisterCubit() ,
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context, state) {
          if(state is   RegistererrorState) {
            showflutterToast(message: state.error.toString(),
                backgroundColor: Colors.redAccent);
          }
          if(state is CreatesucessState){
            showflutterToast(message: 'successfully registered, you can login now!',
                backgroundColor: defaultcolor);
            // NavigateToAndReplace(context, LoginScreen());
          }
        },
        builder: (context, state) => Stack(
          children: [
            Image.asset('assets/images/b9f3f2c2ce853acbdcbf4cd0dd7d1b8c.jpg',height: MediaQuery.of(context).size.height,
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
                          child: Image(image:
                          AssetImage('assets/images/reg.png'),
                              fit: BoxFit.cover),
                        ),

                      ),
                      // Image(image:
                      // AssetImage('assets/images/reg.png'),
                      //     fit: BoxFit.cover,height: 250,width: double.infinity,),
                      SizedBox(
                        height: 30,
                      ),
                      Text("Create your account to join us!",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          children: [
                            defultfieldform(
                              controller:namecontroller,
                              type: TextInputType.text,
                              labletext: "name",
                              prefix: Icons.lock_open,
                              validate: ( value){
                                if(value!.isEmpty)
                                {
                                  return "please enter your name";
                                }

                                return null ;
                              },
                            ),
                            SizedBox(
                              height: 30,),
                            defultfieldform(
                                controller: emailcontroller,
                                type: TextInputType.text,
                                labletext: "Email",
                                prefix: Icons.email_outlined,
                                validate: ( value){
                                  if(value!.isEmpty){
                                    return "please enter your email";
                                  }

                                }
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            defultfieldform(
                                controller:phonecontroller,
                                type: TextInputType.phone,
                                labletext: "phone",
                                prefix: Icons.phone_android,
                                validate: ( value){
                                  if(value!.isEmpty){
                                    return "please enter your phone number";
                                  }

                                }
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            defultfieldform(
                              controller:passwordcontroller,
                              type: TextInputType.text,
                              labletext: "Password",
                              prefix: Icons.lock_open,
                              validate: ( value){
                                if(value!.isEmpty)
                                {
                                  return "please enter your password";
                                }

                                return null ;
                              },
                              security: true,
                              color: Colors.grey,
                              suffex :Icons.remove_red_eye_rounded,
                            ),
                            SizedBox(
                              height: 20,
                            ),

                            ConditionalBuilder(
                              condition: state is ! RegisterloadingState,
                              builder:(context) =>   defultbottom(
                                  text: "Register",
                                  width: 200,
                                  raduis: 15,
                                  function: () {
                                    if (formkey.currentState!.validate()) {
                                      RegisterCubit.get(context).postUserdata(namecontroller.text, passwordcontroller.text, phonecontroller.text, emailcontroller.text);
                                    };
                                  }
                              ) ,
                              fallback:(context) =>Center(child: CircularProgressIndicator()) ,

                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Have an acocunt?"),
                                SizedBox(
                                  width: 5,
                                ),
                                TextButton(onPressed: (){
                                  NavigateToAndReplace(context, LoginScreen());
                                }, child:Text("Login now!"))
                              ],
                            ),
                          ],
                        ),
                      ),


                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

