import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_pp/layout/cubit/states.dart';
import 'package:shop_pp/models/categories_model.dart';
import 'package:shop_pp/models/change_favorites_model.dart';
import 'package:shop_pp/models/favorites_model.dart';
import 'package:shop_pp/models/home_model.dart';
import 'package:shop_pp/models/login_model.dart';
import 'package:shop_pp/models/on_boarding_model.dart';
import 'package:shop_pp/modules/cateogries/cateogries_screen.dart';
import 'package:shop_pp/modules/favorites/favorites_screen.dart';
import 'package:shop_pp/modules/products/products_screen.dart';
import 'package:shop_pp/modules/settings/settings_screen.dart';
import 'package:shop_pp/shared/components/constants.dart';
import 'package:shop_pp/shared/network/endpoints.dart';
import 'package:shop_pp/shared/network/local/cacheHelper.dart';
import 'package:shop_pp/shared/network/remote/dio_helper.dart';
class ShopCubit extends Cubit<ShopStates>{
  ShopCubit():super(ShopInitialStates());

  static ShopCubit get(context)=>BlocProvider.of(context);

  int cur_ind=0;
  List<Widget>bottomScrens=[
    ProductScreen(),
    CateogriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];


  void changeBottom(int index){
    cur_ind=index;emit(ShopChangeBottomNavStates());
  }


  HomeModel? homeModel;
  Map<int,bool>fav={};
  void getHomeData() {
    emit(ShopLoadingHomeDataStates());

    DioHelper.getData(
        url: HOME,
      token:token,
    ).then((value) {
      homeModel = HomeModel.fromjson(value!.data);
      String? image = homeModel?.data?.banners[0].image;

      homeModel?.data?.products.forEach((element) {
        fav.addAll({
          element.id!:element.in_favorites!,
        });
      });


      emit(ShopSuccessHomeDataStates());
    }).catchError((error) {
      emit(ShopErrorHomeDataStates());
    });
  }



  CategoriesModel? categoriesModel;

  void getCategories() {
    DioHelper.getData(
      url: CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromjson(value!.data);

      emit(ShopSuccessCategoriesStates());
    }).catchError((error) {
      emit(ShopErrorCategoriesStates());
    });
  }



  ChangeFavModel ?changeFavModel;
    void change_fav(int product_id){


      fav[product_id]=!fav[product_id]!;
      emit(ShopChangeFavStates());
      DioHelper.postData(
          url: FAV,
          data: {
            'product_id':product_id,
          },
        token: token,
      ).then((value) => {

        changeFavModel=ChangeFavModel.fromjsom(value?.data),



        if (!changeFavModel!.status!){
          fav[product_id]=!fav[product_id]!
        }else{
          getFav()
        },
        emit(ShopSuccessChangeFavStates(changeFavModel!))

      }).catchError((error){

        fav[product_id]=!fav[product_id]!;
    emit(ShopErrorChangeFavStates());
      });
  }





  FavoritesModel? favModel;

  void getFav() {
    emit(ShopLoadingGetFavStates());
    DioHelper.getData(
      url: FAV,
      token: token,
    ).then((value) {
      favModel = FavoritesModel.fromJson(value!.data);

      emit(ShopSuccessGetFavStates());
    }).catchError((error) {
      emit(ShopErrorGetFavStates());
    });
  }


  LoginModel? usermodel;

  void getUserData() {
    emit(ShopLoadingUSerDataStates());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      usermodel = LoginModel.fromjson(value!.data);
      print('user model --->|    ${usermodel?.data?.name}');

      emit(ShopSuccessUSerDataStates(usermodel));
    }).catchError((error) {
      print(' the error is --> ${error.toString()}');
      emit(ShopErrorUSerDataStates());
    });
  }




  void updateUserData({
    required String? name,
    required String? email,
    required String? phone,
}) {
    emit(ShopLoadingUpdateUserStates());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data:{
        'name':name,
        'email':email,
        'phone':phone,
      }
    ).then((value) {
      usermodel = LoginModel.fromjson(value!.data);
      print('user model --->|    ${usermodel?.data?.name}');

      emit(ShopSuccessUpdateUserStates(usermodel));
    }).catchError((error) {
      print(' the error is --> ${error.toString()}');
      emit(ShopErrorUpdateUserStates());
    });
  }





}