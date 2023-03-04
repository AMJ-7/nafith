class NotificationModel{
  dynamic senderName ;
  dynamic senderImage ;
  dynamic notificationType ;
  dynamic title ;
  dynamic body ;
  dynamic dateTime ;


  NotificationModel({
    this.senderName,
    this.senderImage,
    this.notificationType,
    this.title,
    this.body,
    this.dateTime,
});

  NotificationModel.fromJson(Map<String , dynamic>? json){
    senderName = json!['senderName'];
    senderImage = json['senderImage'];
    notificationType = json['notificationType'];
    title = json['title'];
    body = json['body'];
    dateTime = json['dateTime'];
  }

  Map<String , dynamic> toMap(){
    return {
      'senderName' : senderName,
      'senderImage' : senderImage ,
      'notificationType' : notificationType ,
      'title' : title ,
      'body' : body ,
      'dateTime' : dateTime ,
    };
  }
}