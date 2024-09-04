class UserModel{

  String id;
  UserModel({this.id=""});

  UserModel.fromJson(Map<String,dynamic>json):this(
    id:json['id']
  );

  Map<String,dynamic> toJson(){
    return {
      'id':id
    };
  }
}