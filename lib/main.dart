import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_pp/layout/cubit/cubit.dart';
import 'package:shop_pp/layout/shop_layout/shop_layout.dart';
import 'package:shop_pp/modules/login/login_screen.dart';
import 'package:shop_pp/modules/on_boarding/on_boarding_screen.dart';
import 'package:shop_pp/shared/components/constants.dart';
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

  Widget ?widget;

  bool? onBoarding=CacheHelper.getData(key: 'onBoarding');
  String?token=CacheHelper.getData(key: 'token');
  print(token);
  if (onBoarding!=null){
    if(token!=null){
      widget=ShopLayout();
    }
    else{
      widget=LoginScreen();
    }
  }else{
    widget=OnBoardingScreen();
  }
  runApp( MyApp(isDark:isDark!,startWidget:widget!));
}
class MyApp extends StatelessWidget {


  final bool isDark;
  final Widget startWidget;



  const MyApp({
    required this.isDark,
    required this.startWidget,
    Key? key,
  }) : super(key: key);

  // This widget is the root of your application.
  @override






  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:
      [
        BlocProvider(create: (BuildContext context) =>AppCubit()..changeAppMode(
          fromshard: isDark,
        ),),
        BlocProvider(create: (BuildContext context) =>ShopCubit()..getHomeData()..getCategories()..getFav()..getUserData()),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          return  MaterialApp(
            title: 'Flutter Demo',
            theme: lightTheme,
            darkTheme:darkTheme,
            themeMode: AppCubit.get(context).isDark != true ? ThemeMode.light : ThemeMode.dark,
            home: startWidget,
          );
        },

      ),
    );
  }
}

