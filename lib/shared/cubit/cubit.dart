import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_pp/shared/cubit/states.dart';
import 'package:shop_pp/shared/network/local/cacheHelper.dart';


class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;
  bool is_eg=false;

  void changeAppMode({bool? fromshard }) {
    if(fromshard!=null){
      isDark=fromshard;
      emit(AppChangeModeState());
    }
    else{
      isDark = !isDark;
      CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }
}