

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartgreanhouse/shared/cubit/profile/profilestates.dart';

import '../../cach-helper.dart';

class ProfileCubit extends Cubit<profileStates> {
  ProfileCubit() : super(themeInitState());

  static ProfileCubit get(context) => BlocProvider.of(context);
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