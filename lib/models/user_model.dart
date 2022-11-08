class UserModel{
  String? name;
  String? phone;
  String? uId;
  String? email;
  String? image;

  UserModel({
    this.uId,
    this.email,
    this.phone,
    this.name,
    this.image,
  });

  UserModel.fromJson(Map<String,dynamic>json){
    email=json['email'];
    phone=json['phone'];
    uId=json['uId'];
    name=json['name'];
    image =json['image'];
  }
  Map<String,dynamic>toMap(){
    return{
      'name':name,
      'email':email,
      'phone':phone,
      'uId':uId,
      'image':image,
    };
  }
}