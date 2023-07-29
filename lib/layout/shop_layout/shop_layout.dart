
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_pp/layout/cubit/cubit.dart';
import 'package:shop_pp/layout/cubit/states.dart';

import 'package:shop_pp/modules/search/Search_screen.dart';
import 'package:shop_pp/shared/components/components.dart';
import 'package:shop_pp/shared/components/constants.dart';
import 'package:shop_pp/shared/cubit/cubit.dart';
import 'package:shop_pp/shared/cubit/states.dart';

import 'package:shop_pp/shared/styles/themes.dart';

class ShopLayout extends StatelessWidget {


  var _bottomNavigationKey = GlobalKey<CurvedNavigationBarState>();




  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        var cubit=ShopCubit.get(context);
        return  Scaffold(
          extendBody: true,
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/images/supermarket-icon-png-12.png',
                width: 30.0,
                height: 30.0,
              ),
            ),
            title: Align(
              alignment: Alignment(-1.2,0),
                child: const Text(
                    'Shop Hub'),
            ),
            actions:
            [
              IconButton(
                  onPressed: (){
                    navigateTo(context, SearchScreen());
                  },
                  icon: Icon(Icons.search),
              ),
            ],
          ),
          body: cubit.bottomScrens[cubit.cur_ind],
          bottomNavigationBar: BlocBuilder<AppCubit,AppStates>(
            builder: (context,state){
              return Theme(
                data: AppCubit.get(context).isDark?darkTheme:lightTheme,
                child: Container(
                  decoration: const BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black54,
                          blurRadius: 15.0,
                          spreadRadius: 5.0,
                          offset: Offset(0, 0.75)
                      )
                    ],
                  ),
                  child: CurvedNavigationBar(
                    key: _bottomNavigationKey,
                    backgroundColor:Colors.transparent, // Replace with your desired background color
                    color: AppCubit.get(context).isDark?Colors.grey:Colors.white, // Replace with your desired active item color
                    buttonBackgroundColor: default_color, // Replace with your desired button background color
                    height: 50.0,
                    index: cubit.cur_ind,
                    animationCurve: Curves.easeInOut,
                    animationDuration: Duration(milliseconds: 500),
                    onTap: (index) {
                      cubit.changeBottom(index);
                    },
                    items: const [
                      Icon(Icons.home, size: 30),
                      Icon(Icons.category_outlined, size: 30),
                      Icon(Icons.favorite, size: 30),
                      Icon(Icons.settings, size: 30),
                    ],


                  ),
                ),
              );
            },
          ),

        );
      },
    );
  }
}