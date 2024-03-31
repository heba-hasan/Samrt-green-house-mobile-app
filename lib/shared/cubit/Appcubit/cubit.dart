import 'package:bloc/bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';


import 'appstates.dart';

class Appcubit extends Cubit<AppStates>{
  Appcubit() :super (Appinitialstate());
  static Appcubit get(context)=> BlocProvider.of(context);

  // void appmode(
  //     {
  //       bool ? fromshared,
  //     }) {
  //   if (fromshared != null) {
  //     isdarkmode = fromshared;
  //     emit(Appmodestates());
  //   }
  //   else {
  //     isdarkmode = !(isdarkmode);
  //     Cachehelper.setbool(key: 'isdarkmode', value: isdarkmode).then((value) {
  //       emit(Appmodestates());
  //     }
  //     );
  //   }
  // }
}




