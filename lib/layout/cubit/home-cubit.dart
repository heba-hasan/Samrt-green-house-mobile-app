import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/user-model.dart';
import '../../modules/profile-screen.dart';
import '../../shared/cach-helper.dart';
import '../../shared/components/components.dart';
import '../../shared/constant/constants.dart';
import '../../shared/cubit/Appcubit/appstates.dart';
import 'home-state.dart';

class HomeCubit extends Cubit<HomeStates>{
  HomeCubit() : super(HomeInitState());
  static HomeCubit get(context)=> BlocProvider.of(context);

    UserModel ?model;

  void getuserdata(){
    Uid= CachHelper.getdata(key: 'Uid');
     emit(GetUserdataLoadState());
    FirebaseFirestore.instance.collection('users').doc(Uid).get().then((value) 
    {
      model=UserModel.fromjson(value.data()!);
      print(value.data());
      // print(model!.name!);

      emit(GetUserdatasucessState());
    }
    ).catchError((onError)
    {
      emit(GetUserdataErrorState());
    }
    );
  }

  bool isdarkmode = false;
  void appmode({
    bool ? fromshared,
  }) {
    if (fromshared != null) {
      isdarkmode = fromshared;
      emit(Appmodestate());
    }
    else {
      isdarkmode = !(isdarkmode);
      CachHelper.savedata(key: 'isdarkmode', value: isdarkmode).then((value) {
        emit(Appmodestate());
      }
      );
    }
  }



}

