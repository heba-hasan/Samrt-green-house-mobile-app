import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartgreanhouse/shared/cubit/theme/theme-state.dart';

class ThemeCubit extends Cubit<ThemeStates>{
  ThemeCubit(): super(Initthememode());
  static ThemeCubit get(contex)=>BlocProvider.of(contex);

  bool isdark=false;
  void changemode(){
    isdark=!isdark;
    emit(Changethememode());
  }
}
