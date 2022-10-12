class UserModel{
  dynamic name ;
  dynamic email ;
  dynamic phone ;
  dynamic  uId;
  dynamic  image;
  dynamic type ;
  dynamic gender ;
  dynamic bio ;
  dynamic degree ;
  dynamic ejazat ;
  dynamic language ;

  UserModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.image,
    this.type,
    this.gender,
    this.bio ,
    this.degree ,
    this.ejazat ,
    this.language ,
});

  UserModel.fromJson(Map<String , dynamic>? json){
    name = json!['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    type = json['type'];
    gender = json['gender'];
    bio = json['bio'];
    degree = json['degree'];
    ejazat = json['ejazat'];
    language = json['language'];
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
      'bio' : bio,
      'degree' : degree,
      'ejazat' : ejazat,
      'language' : language,

    };
  }
}