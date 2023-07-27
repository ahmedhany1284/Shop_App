import 'package:shop_pp/models/models.dart';

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