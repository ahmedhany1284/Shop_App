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