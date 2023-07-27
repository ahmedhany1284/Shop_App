class BoardingModel{
  late final String image;
  late final String title;
  late final String body;


  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
});
}




class LoginModel{
  bool? status;
  String? message;
  UserData? data;


  LoginModel.fromjson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
    data=json['data']!=null? UserData.fromjson(json['data']):null;

  }
}


class UserData{
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  UserData({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.points,
    this.credit,
    this.token,
});


  UserData.fromjson(Map<String,dynamic>json){
   id=json['id'];
   name=json['name'];
   email=json['email'];
   phone=json['phone'];
   image=json['image'];
   points=json['points'];
   credit=json['credit'];
   token=json['token'];
  }

}



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



class CategoriesModel{
  bool ?status;
  CatedoriesDataModel ?data;
  CategoriesModel.fromjson(Map<String,dynamic>json){
    status=json['status'];
    data=CatedoriesDataModel.fromjson(json['data']) ;
  }
}
class CatedoriesDataModel {
  int? current_page;
  List<DataModel> data = [];

  CatedoriesDataModel.fromjson(Map<String, dynamic> json) {
    current_page = json['current_page'];
    if (json['data'] != null) {
      json['data'].forEach((element) {
        data.add(DataModel.fromjson(element));
      });
    }
  }
}

class DataModel{
  int ?id;
  String ?name;
  String ?image;
  DataModel.fromjson(Map<String,dynamic>json){
    id=json['id'];
    name=json['name'];
    image=json['image'];

  }
}



class ChangeFavModel{
  bool ?status;
  String ?message;
  ChangeFavModel.fromjsom(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
  }
}


class FavoritesModel {
  bool ?status;
  String? message;
  Data? data;

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int currentPage;
  List<FavoritesData> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  String path;
  int perPage;
  int to;
  int total;

  Data.fromJson(Map<String, dynamic> json)
      : currentPage = json['current_page'],
        data = List<FavoritesData>.from(
            (json['data'] ?? []).map((v) => FavoritesData.fromJson(v))),
        firstPageUrl = json['first_page_url'],
        from = json['from'],
        lastPage = json['last_page'],
        lastPageUrl = json['last_page_url'],
        path = json['path'],
        perPage = json['per_page'],
        to = json['to'],
        total = json['total'];
}

class FavoritesData {
  int id;
  Product? product;

  FavoritesData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
}

class Product {
  int id;
  dynamic price;
  dynamic oldPrice;
  int discount;
  String image;
  String name;
  String description;

  Product({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    required this.description,
  });

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        price = json['price'],
        oldPrice = json['old_price'],
        discount = json['discount'],
        image = json['image'],
        name = json['name'],
        description = json['description'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['price'] = price;
    data['old_price'] = oldPrice;
    data['discount'] = discount;
    data['image'] = image;
    data['name'] = name;
    data['description'] = description;
    return data;
  }
}
