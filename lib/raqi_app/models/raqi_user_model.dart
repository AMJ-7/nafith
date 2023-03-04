class UserModel{
  dynamic name ;
  dynamic email ;
  dynamic phone ;
  dynamic  uId;
  dynamic  image;
  dynamic type ;
  dynamic gender ;
  dynamic bio ;
  dynamic rate ;
  dynamic ejazat ;
  dynamic language ;
  dynamic minutes ;
  dynamic deviceToken ;

  UserModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.image,
    this.type,
    this.gender,
    this.bio ,
    this.rate ,
    this.ejazat ,
    this.language ,
    this.minutes ,
    this.deviceToken ,
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
    rate = json['rate'];
    ejazat = json['ejazat'];
    language = json['language'];
    minutes = json['minutes'];
    deviceToken = json['deviceToken'];
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
      'rate' : rate,
       'ejazat' : ejazat,
      'language' : language,
      'minutes' : minutes,
      'deviceToken' : deviceToken,
    };
  }
}