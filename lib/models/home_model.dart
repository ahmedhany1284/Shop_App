
class HomeModel{
  bool? status;
  HomeDataModel ?data;
  HomeModel.fromjson(Map<String,dynamic>json){
    status=json['status'];
    data=HomeDataModel.fromjson(json['data']);
  }

}

class HomeDataModel {
  List<BannerModel> banners = [];
  List<ProductModel> products = [];

  HomeDataModel.fromjson(Map<String, dynamic> json) {
    // Convert 'banners' from Map to List<BannerModel>
    if (json['banners'] != null) {
      banners = List<BannerModel>.from(json['banners'].map((element) => BannerModel.fromjson(element)));
    }

    // Convert 'products' from Map to List<ProductModel>
    if (json['products'] != null) {
      products = List<ProductModel>.from(json['products'].map((element) => ProductModel.fromjson(element)));
    }
  }
}


class BannerModel{
  int? id;
  String? image;
  BannerModel.fromjson(Map<String,dynamic>json){
    id=json['id'];
    image=json['image'];
  }
}
class ProductModel{
  int ?id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  String ?image;
  String ?name;
  bool? in_favorites;
  bool? in_cart;

  ProductModel.fromjson(Map<String,dynamic>json){
    id=json['id'];
    price=json['price'];
    old_price=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    in_favorites=json['in_favorites'];
    in_cart=json['in_cart'];

  }
}