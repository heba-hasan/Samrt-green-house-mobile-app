import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartgreanhouse/shared/cubit/register-cubit/register-states.dart';

import '../../../models/user-model.dart';


class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(RegisterinitState());
  static RegisterCubit get(context)=> BlocProvider.of(context);
void postUserdata(
    String name ,
    String password ,
    String phone,
    String email
    ){
  emit(RegisterloadingState());
  FirebaseAuth.
  instance.
  createUserWithEmailAndPassword(email: email,
      password: password).
  then((value)
  {
    createUsermodel(
      Uid: value.user!.uid,
      email: email,
      name: name,
      phone: phone
    );
  }
  ).catchError((onError)
  {

    emit(RegistererrorState(onError.toString()));
  }
  );
}

  void createUsermodel(
  {
  required String name,
    required String phone,
    required String email,
    required String Uid,

  })
  {
    UserModel model =UserModel(
      phone: phone,
      name: name,
      email: email,
      Uid: Uid
    );
    FirebaseFirestore.instance.collection('users').doc(Uid).set(model.usermodelTomap()).then((value)
    {
      emit(CreatesucessState());
    }
    ).catchError((onError)
    {
      print("error is: ${onError.toString()}");
      emit(CreateerrorState(onError));
    }
    );

  }
}