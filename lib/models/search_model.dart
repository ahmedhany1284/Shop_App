class SearchModel {
  bool? status;
  String? message;
  Data? data;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int ?currentPage;
  List<Product> data;
  String firstPageUrl;
  int? from; // Make 'from' nullable
  int? lastPage; // Make 'lastPage' nullable
  String ?lastPageUrl;
  String ?path;
  int ?perPage;
  int? to; // Make 'to' nullable
  int ?total;

  Data.fromJson(Map<String, dynamic> json)
      : currentPage = json['current_page'] ?? 0,
        data = List<Product>.from((json['data'] ?? []).map((v) => Product.fromJson(v))),
        firstPageUrl = json['first_page_url'] ?? '',
        from = json['from'], // No need to provide a default value for nullable integers
        lastPage = json['last_page'], // No need to provide a default value for nullable integers
        lastPageUrl = json['last_page_url'] ?? '',
        path = json['path'] ?? '',
        perPage = json['per_page'] ?? 0,
        to = json['to'], // No need to provide a default value for nullable integers
        total = json['total'] ?? 0;
}




class Product {
  int ?id;
  dynamic price;
  dynamic oldPrice;
  int ?discount;
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
