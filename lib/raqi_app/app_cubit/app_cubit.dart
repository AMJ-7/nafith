import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raqi/raqi_app/app_cubit/app_states.dart';
import 'package:raqi/raqi_app/models/call_model.dart';
import 'package:raqi/raqi_app/models/message_model.dart';
import 'package:raqi/raqi_app/models/raqi_user_model.dart';
import 'package:raqi/raqi_app/modules/buy_screen/buy_screen.dart';
import 'package:raqi/raqi_app/modules/home/home_screen.dart';
import 'package:raqi/raqi_app/modules/sessions_screen/sessions_screen.dart';
import 'package:raqi/raqi_app/modules/teachersScreens/earning_teacher_screen.dart';
import 'package:raqi/raqi_app/modules/teachersScreens/home_teacher_screen.dart';
import 'package:raqi/raqi_app/modules/teachersScreens/messages_teacher_screen.dart';
import 'package:raqi/raqi_app/modules/teachers_screen/teachers_screen.dart';
import 'package:raqi/raqi_app/shared/components/applocale.dart';
import 'package:raqi/raqi_app/shared/components/constants.dart';

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
    required String phone ,
    required String bio ,
    String? image ,
    String? cover

  }){
    emit(RaqiUserUpdateLoadingState());
    UserModel model = UserModel(
        name: name ,
        phone: phone ,
        image: image??userModel!.image ,
        email: userModel!.email,
        uId: userModel!.uId,
        bio: bio ,
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

  Future<bool> endCall(Call call) async {
    try{
      await callCollection.doc(call.callerId).delete();
      await callCollection.doc(call.receiverId).delete();
      return true ;
    }
    catch(e){
      print(e);
      return false ;
    }
  }
  Stream<DocumentSnapshot> callStream({String? uid}) => callCollection.doc(uid).snapshots();
}