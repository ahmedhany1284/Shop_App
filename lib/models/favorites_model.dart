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
      : currentPage = json['current_page'] ?? 0,
        data = List<FavoritesData>.from(
            (json['data'] ?? []).map((v) => FavoritesData.fromJson(v))),
        firstPageUrl = json['first_page_url'] ?? '',
        from = json['from'] ?? 0,
        lastPage = json['last_page'] ?? 0,
        lastPageUrl = json['last_page_url'] ?? '',
        path = json['path'] ?? '',
        perPage = json['per_page'] ?? 0,
        to = json['to'] ?? 0,
        total = json['total'] ?? 0;
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


}
