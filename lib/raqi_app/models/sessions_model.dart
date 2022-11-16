class SessionsModel{
  dynamic teacherName ;
  dynamic teacherImage ;
  dynamic sessionId ;
  dynamic dateTime ;
  dynamic duration ;



  SessionsModel({
    this.teacherName,
    this.teacherImage,
    this.dateTime,
    this.sessionId,
    this.duration,
});

  SessionsModel.fromJson(Map<String , dynamic>? json){
    teacherName = json!['teacherName'];
    teacherImage = json['teacherImage'];
    dateTime = json['dateTime'];
    sessionId = json['sessionId'];
    duration = json['duration'];
  }

  Map<String , dynamic> toMap(){
    return {
      'teacherName' : teacherName,
      'teacherImage' : teacherImage ,
      'dateTime' : dateTime ,
      'sessionId' : sessionId ,
      'duration' : duration ,
    };
  }
}