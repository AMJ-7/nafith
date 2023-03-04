class ReservationModel{
  dynamic FTS ;
  dynamic LTS ;
  dynamic to ;
  dynamic from ;
  dynamic studentImage ;
  dynamic studentName ;
  dynamic studentId ;
  dynamic teacherImage ;
  dynamic teacherName ;
  dynamic teacherId ;
  dynamic duration ;



  ReservationModel({
    this.FTS,
    this.LTS,
    this.to,
    this.from,
    this.studentImage,
    this.studentName,
    this.studentId,
    this.teacherImage,
    this.teacherName,
    this.teacherId,
    this.duration,
});

  ReservationModel.fromJson(Map<String , dynamic>? json){
    FTS = json!['FTS'];
    LTS = json['LTS'];
    to = json['to'];
    from = json['from'];
    studentImage = json['studentImage'];
    studentName = json['studentName'];
    studentId = json['studentId'];
    teacherImage = json['teacherImage'];
    teacherName = json['teacherName'];
    teacherId = json['teacherId'];
    duration = json['duration'];
  }

  Map<String , dynamic> toMap(){
    return {
      'FTS' : FTS,
      'LTS' : LTS ,
      'to' : to ,
      'from' : from ,
      'studentImage' : studentImage ,
      'studentName' : studentName ,
      'studentId' : studentId ,
      'teacherImage' : teacherImage ,
      'teacherName' : teacherName ,
      'teacherId' : teacherId ,
      'duration' : duration ,
    };
  }
}