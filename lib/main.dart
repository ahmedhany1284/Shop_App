import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_pp/modules/login/login_screen.dart';
import 'package:shop_pp/modules/on_boarding/on_boarding_screen.dart';
import 'package:shop_pp/shared/network/local/cacheHelper.dart';
import 'package:shop_pp/shared/network/remote/dio_helper.dart';
import 'package:shop_pp/shared/styles/themes.dart';

import 'shared/bloc_observer.dart';
import 'shared/cubit/cubit.dart';
import 'shared/cubit/states.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer= MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark=CacheHelper.getData(key: 'isDark')??false;
  bool? isEg=CacheHelper.getData(key: 'is_eg')??false;

  runApp( MyApp(isDark));
}
class MyApp extends StatelessWidget {
  const MyApp(this.isDark, {super.key});

  // This widget is the root of your application.
  @override
  final bool isDark;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:
      [
        BlocProvider(create: (BuildContext context) =>AppCubit()..changeAppMode(
          fromshard: isDark,
        ),),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          return  MaterialApp(
            title: 'Flutter Demo',
            theme: lightTheme,
            darkTheme:darkTheme,
            themeMode: AppCubit.get(context).isDark != true ? ThemeMode.light : ThemeMode.dark,
            home:  LoginScreen(),
          );
        },

      ),
    );
  }
}

