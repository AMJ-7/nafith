class SessionsModel{
  dynamic teacherName ;
  dynamic teacherImage ;
  dynamic studentId ;
  dynamic studentImage ;
  dynamic studentName ;
  dynamic sessionId ;
  dynamic dateTime ;
  dynamic duration ;



  SessionsModel({
    this.teacherName,
    this.teacherImage,
    this.studentImage,
    this.studentName,
    this.studentId,
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
    studentImage = json['studentImage'];
    studentName = json['studentName'];
    studentId = json['studentId'];
  }

  Map<String , dynamic> toMap(){
    return {
      'teacherName' : teacherName,
      'teacherImage' : teacherImage ,
      'dateTime' : dateTime ,
      'sessionId' : sessionId ,
      'duration' : duration ,
      'studentImage' : studentImage ,
      'studentName' : studentName ,
      'studentId' : studentId ,
    };
  }
}