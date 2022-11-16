import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:raqi/raqi_app/app_cubit/app_states.dart';
import 'package:raqi/raqi_app/models/call_model.dart';
import 'package:raqi/raqi_app/models/comment_model.dart';
import 'package:raqi/raqi_app/models/message_model.dart';
import 'package:raqi/raqi_app/models/raqi_user_model.dart';
import 'package:raqi/raqi_app/models/sessions_model.dart';
import 'package:raqi/raqi_app/modules/buy_screen/buy_screen.dart';
import 'package:raqi/raqi_app/modules/home/home_screen.dart';
import 'package:raqi/raqi_app/modules/sessions_screen/sessions_screen.dart';
import 'package:raqi/raqi_app/modules/teachersScreens/earning_teacher_screen.dart';
import 'package:raqi/raqi_app/modules/teachersScreens/home_teacher_screen.dart';
import 'package:raqi/raqi_app/modules/teachersScreens/messages_teacher_screen.dart';
import 'package:raqi/raqi_app/modules/teachers_screen/teachers_screen.dart';
import 'package:raqi/raqi_app/shared/components/applocale.dart';
import 'package:raqi/raqi_app/shared/components/components.dart';
import 'package:raqi/raqi_app/shared/components/constants.dart';
import 'package:raqi/utils/call_utils.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class RaqiCubit extends Cubit<RaqiStates>{
  RaqiCubit() : super(RaqiInitialStates());

  static RaqiCubit get(context) => BlocProvider.of(context);


  UserModel? userModel ;

  void getUserData(){
    emit(RaqiGetUserLoadingState());
    FirebaseFirestore.instance.collection('students')
        .doc(uId)
        .get()
        .then((value) {
          if(value.exists){
            print(value.data());
            userModel = UserModel.fromJson(value.data());
            getSessions();
            emit(RaqiGetUserSuccessState());
          }else{
            FirebaseFirestore.instance.collection('teachers')
                .doc(uId)
                .get()
                .then((value) {
                print(value.data());
                userModel = UserModel.fromJson(value.data());
                emit(RaqiGetUserSuccessState());
            });
          }

    }).catchError((error){
      print(error.toString());
      emit(RaqiGetUserErrorState(error.toString()));
    });
  }


  int currentIndex = 0 ;

  List<Widget> screens = [
    HomeScreen(),
    TeachersScreen(),
    SessionsScreen(),
    BuyScreen(),
  ] ;



  void changeBottomNav(int index){
    currentIndex = index ;
    if(currentIndex == 1){
      getTeachers();
    }
    if(currentIndex == 2){
      getSessions();
    }
    if(currentIndex == 3){
      getUserData();
    }
    emit(RaqiChangeBottomNavBarState());
  }

  List<Widget> screensTeacher = [
    HomeTeacherScreen(),
    MessagesScreen(),
    EarningScreen(),
  ] ;

  List<String> titlesTeacher = [
    'Nafith' ,
    'Messages' ,
    'Earning' ,
  ];

  void changeBottomNavTeacher(int index){
    currentIndex = index ;
    if(currentIndex == 1){
      getStudents();
    }
    emit(RaqiChangeBottomNavBarState());
  }

  List<UserModel> teachers = [] ;
  void getTeachers(){
    print(userModel!.name.toString().split(" ").first);
    print(userModel!.name.toString().split(" ").first);
    print("+++++++++++++++++++++++++++++++++++++++++++++");
    teachers = [];
    FirebaseFirestore.instance
        .collection('teachers')
        .get()
        .then((value) {
      value.docs.forEach((element) {

        if(element.data()['uId'] != userModel!.uId)
          teachers.add(UserModel.fromJson(element.data()));

      });
      emit(RaqiGetAllTeachersSuccessState());
    }).catchError((error){
      emit(RaqiGetAllTeachersErrorState(error.toString()));
    });
  }

  List<UserModel> students = [] ;
  void getStudents(){
    students = [];
    FirebaseFirestore.instance
        .collection('students')
        .get()
        .then((value) {
      value.docs.forEach((element) {

        if(element.data()['uId'] != userModel!.uId)
          students.add(UserModel.fromJson(element.data()));

      });
      emit(RaqiGetAllTeachersSuccessState());
    }).catchError((error){
      emit(RaqiGetAllTeachersErrorState(error.toString()));
    });
  }

  UserModel? teacherModel ;
  void getTeacher(
      String teacherId
      ){
    emit(RaqiGetTeacherLoadingState());
    FirebaseFirestore.instance.collection('teachers')
        .doc(teacherId)
        .get()
        .then((value) {
      print(value.data());
      teacherModel = UserModel.fromJson(value.data());
      emit(RaqiGetTeacherSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(RaqiGetTeacherErrorState());

    });
  }


  void getTeacherThenCall(
      String teacherId,
      context
      ){
    emit(RaqiGetTeacherLoadingState());
    FirebaseFirestore.instance.collection('teachers')
        .doc(teacherId)
        .get()
        .then((value) {
      print(value.data());
      teacherModel = UserModel.fromJson(value.data());
      if(int.parse(RaqiCubit.get(context).userModel!.minutes) > 0){
        CallUtils.dial(
            from: RaqiCubit.get(context).userModel,
            to: RaqiCubit.get(context).teacherModel ,
            context: context
        );
      }
      else{
        showToast(text: "You do not have minutes, please recharge and try again", state: ToastStates.ERROR);
      }
      emit(RaqiGetTeacherSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(RaqiGetTeacherErrorState());

    });
  }


  void studentSendMessage({
    required String receiverId,
    required String dateTime,
    required String text ,
  }){
    MessageModel model = MessageModel(
        text: text ,
        senderId: userModel!.uId ,
        receiverId: receiverId ,
        dateTime: dateTime
    );

    FirebaseFirestore
        .instance
        .collection('students')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(RaqiSendMessageSuccessState());
    }).catchError((error){
      emit(RaqiSendMessageErrorState());
    });

    FirebaseFirestore
        .instance
        .collection('teachers')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(RaqiSendMessageSuccessState());
    }).catchError((error){
      emit(RaqiSendMessageErrorState());
    });

  }

  void teacherSendMessage({
    required String receiverId,
    required String dateTime,
    required String text ,
  }){
    MessageModel model = MessageModel(
        text: text ,
        senderId: userModel!.uId ,
        receiverId: receiverId ,
        dateTime: dateTime
    );

    FirebaseFirestore
        .instance
        .collection('teachers')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(RaqiSendMessageSuccessState());
    }).catchError((error){
      emit(RaqiSendMessageErrorState());
    });

    FirebaseFirestore
        .instance
        .collection('students')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(RaqiSendMessageSuccessState());
    }).catchError((error){
      emit(RaqiSendMessageErrorState());
    });

  }

  List<MessageModel> messages =[];

  void getStudentMessages({
    required String receiverId
  }){

    FirebaseFirestore
        .instance
        .collection('students')
        .doc(userModel!.uId)
        .collection("chats")
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(RaqiGetMessagesSuccessState());
    });
  }

  void getTeacherMessages({
    required String receiverId
  }){

    FirebaseFirestore
        .instance
        .collection('teachers')
        .doc(userModel!.uId)
        .collection("chats")
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(RaqiGetMessagesSuccessState());
    });
  }

  void updateUser({
    required String name ,
    required String email ,
    required String bio ,
    String? image ,
    String? cover

  }){
    emit(RaqiUserUpdateLoadingState());
    UserModel model = UserModel(
        name: name ,
        email: email,
        phone: userModel!.phone ,
        image: image??userModel!.image ,
        uId: userModel!.uId,
        bio: bio ,
        minutes: userModel!.minutes
    );
    FirebaseFirestore.instance
        .collection('students')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    })
        .catchError((error){
      emit(RaqiUserUpdateErrorState());
    });
  }

  final CollectionReference callCollection = FirebaseFirestore.instance.collection('call');

  Future<bool> makecall(Call call) async {
    try{
      call.hasDialled = true ;
      Map<String , dynamic> hasDialledMap = call.toMap(call);
      call.hasDialled = false ;
      Map<String , dynamic> hasNotDialledMap = call.toMap(call);

      await callCollection.doc(call.callerId).set(hasDialledMap);
      await callCollection.doc(call.receiverId).set(hasNotDialledMap);
      return true ;
    }catch(e){
      print(e);
      return false ;
    }
  }

  Future<bool> endCall(Call call , context) async {
    try{
      await callCollection.doc(call.callerId).delete();
      await callCollection.doc(call.receiverId).delete();
      RaqiCubit.get(context).endCallTime();
      emit(RaqiEndCallSuccess());
      return true ;
    }
    catch(e){
      print(e);
      return false ;
    }
  }
  Stream<DocumentSnapshot> callStream({String? uid}) => callCollection.doc(uid).snapshots();


  void commentOnTeacher({
    required String teacherId,
    required String dateTime,
    required String text ,
    required int rate ,
  }){
    CommentModel model = CommentModel(
        text: text ,
        senderId: userModel!.uId ,
        postId: teacherId ,
        dateTime: dateTime,
        senderName: userModel!.name,
        senderImage: userModel!.image,
        rate: rate,
    );
    emit(RaqiCommentLoadingState());
    FirebaseFirestore
        .instance
        .collection('teachers')
        .doc(teacherId)
        .collection('comments')
        .add(model.toMap())
        .then((value) {
      emit(RaqiCommentSuccessState());
    }).catchError((error){
      emit(RaqiCommentErrorState());
    });

  }

  List<CommentModel> comments =[];
  void getComments(teacherId){
    emit(RaqiGetCommentsLoadingState());
    FirebaseFirestore
        .instance
        .collection('teachers')
        .doc(teacherId)
        .collection("comments")
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      comments = [];
      event.docs.forEach((element) {
        comments.add(CommentModel.fromJson(element.data()));
      });
      emit(RaqiGetCommentsSuccessState());
    });
  }
  
  void emitRate(){
    emit(RaqiEmitRate());
  }
  
  List<int> ratesTeacher = [];
  int sumRates = 0 ;
  double totalRate = 0 ;
  void getRates(teacherId){
    ratesTeacher = [];
    sumRates = 0;
    totalRate = 0;
    FirebaseFirestore.instance.collection('teachers').doc(teacherId).collection('comments').get().then((value) {
      value.docs.forEach((element) {
       ratesTeacher.add(element.data()['rate']);
      });
      print(ratesTeacher);
      print("-------------------------------");
      for(int i = 0 ; i < ratesTeacher.length ; i++){
        sumRates = sumRates + ratesTeacher[i];
      }
      print(sumRates);
      print("-------------------------------");
      totalRate = sumRates / ratesTeacher.length ;
      print(totalRate);

    });

  }

  int pakka = 2 ;
  void emitPakka(int myPakka){
    pakka = myPakka ;
    if(pakka == 1){
      emit(RaqiFirstPakka());
    }
    if(pakka == 2){
      emit(RaqiSecPakka());
    }
    if(pakka == 3){
      emit(RaqiThirdPakka());
    }
  }


  //Calculate Minutes for student
  dynamic startCallDate ;
  dynamic dt1 ;
  void startCallTime(){
    startCallDate = DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now());
    dt1 = DateTime.parse(startCallDate);
    print(dt1);
  }
  dynamic endCallDate ;
  dynamic dt2 ;
  dynamic callDuration ;
  dynamic diffInMinutes ;
  void endCallTime(){
    endCallDate = DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now());
    DateTime dt2 = DateTime.parse(endCallDate);
    Duration diff = dt2.difference(dt1);
    print(dt2);
    diffInMinutes = diff.inMinutes;
    print(diff.inMinutes);
    print("==========================================");
    var oldMin = int.parse(userModel!.minutes);
    var totalMin = oldMin - diff.inMinutes;
    FirebaseFirestore.instance.collection("students").doc(userModel!.uId).update({'minutes' : '$totalMin'});
  }

  void saveSession({
    required String teacherName,
    required String teacherImage,
    required String dateTime,
    required String duration,
    required String teacherId,
  }){
    SessionsModel model = SessionsModel(
      teacherName: teacherName,
      teacherImage: teacherImage,
      sessionId: teacherId,
      dateTime: dateTime,
      duration: duration
    );
    emit(RaqiSaveSessionLoadingState());
    if(int.parse(duration) > 0){
      FirebaseFirestore
          .instance
          .collection('students')
          .doc(userModel!.uId)
          .collection('sessions')
          .add(model.toMap())
          .then((value) {
        emit(RaqiEndCallSuccess());
      }).catchError((error){
        emit(RaqiSaveSessionErrorState());
      });
    }


  }

  List<SessionsModel> sessions =[];
  List<SessionsModel> reversedSessions =[];
  void getSessions(){
    emit(RaqiGetSessionsLoadingState());
    FirebaseFirestore
        .instance
        .collection('students')
        .doc(userModel!.uId)
        .collection("sessions")
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      sessions = [];
      reversedSessions = [];
      event.docs.forEach((element) {
        sessions.add(SessionsModel.fromJson(element.data()));
      });
      reversedSessions = sessions.reversed.toList();
      emit(RaqiGetSessionsSuccessState());
    });
  }

  List<UserModel> searchedTeacher = [];
  void searchTeacher(String search){
    searchedTeacher = [];
    for(int i = 0 ; i < teachers.length ; i++){
      if(teachers[i].name.contains(search)){
        searchedTeacher.add(teachers[i]);
      }
    }
    emit(RaqiGetSearchSuccessState());
  }

  bool isLoading = false ;
  void loadBook(){
    isLoading = true ;
    emit(RaqiLoadBook());
  }

  dynamic profileImage ;
  var picker = ImagePicker() ;

  Future<void> getProfileImage()async{
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if(pickedFile != null){
      profileImage = File(pickedFile.path);
      uploadProfileImage();
      //emit(SocialProfileImagePickedSuccessState());
    }else{
      print('No image selected');
      emit(RaqiProfileImagePickedErrorState());
    }
  }

  void uploadProfileImage(){
    var changedImage = userModel!.image;
    emit(RaqiUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateUser(name: userModel!.name,
            bio: userModel!.bio ,
            image: value,
            email: userModel!.email
        );
        firebase_storage.FirebaseStorage.instance.refFromURL(changedImage).delete();
      }).catchError((error){
        emit(RaqiUploadProfileImageErrorState());
      });
    }).catchError((error){
      emit(RaqiUploadProfileImageErrorState());
    });
  }


}