import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/shared/cubit/states.dart';
import 'package:newsapp/shared/network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates>{

  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  void changeAppMode({bool fromShared}){
    if(fromShared != null)
      {
        isDark = fromShared;
        emit(AppChangeModeState());
        print(fromShared);
      }
    else
      {
        isDark =! isDark;
        CacheHelper.putData(key: 'isDark', value: isDark).then((value){
          emit(AppChangeModeState());
          print(fromShared);
        });
      }
  }

}

