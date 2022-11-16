class CommentModel{
  dynamic senderId ;
  dynamic senderName ;
  dynamic senderImage ;
  dynamic postId ;
  dynamic dateTime ;
  dynamic text ;
  dynamic rate ;



  CommentModel({
    this.senderId,
    this.postId,
    this.dateTime,
    this.text,
    this.senderName,
    this.senderImage,
    this.rate
});

  CommentModel.fromJson(Map<String , dynamic>? json){
    senderId = json!['senderId'];
    postId = json['postId'];
    dateTime = json['dateTime'];
    text = json['text'];
    senderName = json['senderName'];
    senderImage = json['senderImage'];
    rate = json['rate'];
  }

  Map<String , dynamic> toMap(){
    return {
      'senderId' : senderId,
      'postId' : postId ,
      'dateTime' : dateTime ,
      'text' : text ,
      'senderName' : senderName ,
      'senderImage' : senderImage ,
      'rate' : rate ,
    };
  }
}