import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartgreanhouse/shared/components/components.dart';

import '../../../layout/home-layout.dart';
import 'loginstates.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(LogininitState());
  static LoginCubit get(context)=> BlocProvider.of(context);
  bool hideshow=true;

  void userLogin({required String email, required String password,context})
  {
    emit(LoginloadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) 
    {

      emit(LoginsucessState(value.user!.uid));

      print(value.user!.uid);
    }
    ).catchError((onError)
    {
      emit(LoginerrorState(onError.toString()));
      print(onError.toString());
    }
    );
  }

  void hidepass()
  {
    hideshow=!hideshow;
    emit(Hideshowpass());
  }
}