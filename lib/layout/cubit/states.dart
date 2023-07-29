import 'package:shop_pp/models/change_favorites_model.dart';
import 'package:shop_pp/models/login_model.dart';
import 'package:shop_pp/models/on_boarding_model.dart';

abstract class ShopStates{}
class ShopInitialStates extends ShopStates{}
class ShopChangeBottomNavStates extends ShopStates{}
class ShopLoadingHomeDataStates extends ShopStates{}
class ShopSuccessHomeDataStates extends ShopStates{}
class ShopErrorHomeDataStates extends ShopStates{}

class ShopSuccessCategoriesStates extends ShopStates{}
class ShopErrorCategoriesStates extends ShopStates{}


class ShopChangeFavStates extends ShopStates{}
class ShopSuccessChangeFavStates extends ShopStates
{
  final ChangeFavModel model;

  ShopSuccessChangeFavStates(this.model);
}
class ShopErrorChangeFavStates extends ShopStates{}



class ShopLoadingGetFavStates extends ShopStates{}
class ShopSuccessGetFavStates extends ShopStates{}
class ShopErrorGetFavStates extends ShopStates{}

class ShopLoadingUSerDataStates extends ShopStates{}
class ShopSuccessUSerDataStates extends ShopStates{
  LoginModel ?loginModel;
  ShopSuccessUSerDataStates(this.loginModel);
}
class ShopErrorUSerDataStates extends ShopStates{}


class ShopLoadingUpdateUserStates extends ShopStates{}
class ShopSuccessUpdateUserStates extends ShopStates{
  LoginModel ?loginModel;
  ShopSuccessUpdateUserStates(this.loginModel);
}
class ShopErrorUpdateUserStates extends ShopStates{}


