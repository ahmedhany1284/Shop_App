import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_pp/layout/cubit/cubit.dart';
import 'package:shop_pp/layout/cubit/states.dart';
import 'package:shop_pp/modules/login/login_screen.dart';
import 'package:shop_pp/modules/search/Search_screen.dart';
import 'package:shop_pp/shared/components/components.dart';
import 'package:shop_pp/shared/network/local/cacheHelper.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        var cubit=ShopCubit.get(context);
        return  Scaffold(
          appBar: AppBar(
            title: const Text('Shop_App'),
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
          bottomNavigationBar: BottomNavigationBar(
            showUnselectedLabels: false,
            onTap: (index){
              cubit.changeBottom(index);
            },
            currentIndex: cubit.cur_ind,
            items:
            [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category_outlined),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}
