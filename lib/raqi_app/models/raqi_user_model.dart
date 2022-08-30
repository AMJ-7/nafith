class UserModel{
  dynamic name ;
  dynamic email ;
  dynamic phone ;
  dynamic  uId;
  dynamic  image;
  dynamic type ;
  dynamic gender ;

  UserModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.image,
    this.type,
    this.gender
});

  UserModel.fromJson(Map<String , dynamic>? json){
    name = json!['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    type = json['type'];
    gender = json['gender'];
  }

  Map<String , dynamic> toMap(){
    return {
      'name' : name,
      'email' : email ,
      'phone' : phone ,
      'uId' : uId ,
      'image' : image ,
      'type' : type ,
      'gender' : gender,

    };
  }
}