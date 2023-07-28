class ChangeFavModel{
  bool ?status;
  String ?message;
  ChangeFavModel.fromjsom(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
  }
}
