import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raqi/raqi_app/app_cubit/app_states.dart';
import 'package:raqi/raqi_app/models/raqi_user_model.dart';
import 'package:raqi/raqi_app/modules/dependents_screen/dependents_screen.dart';
import 'package:raqi/raqi_app/modules/home/home_screen.dart';
import 'package:raqi/raqi_app/modules/sessions_screen/sessions_screen.dart';
import 'package:raqi/raqi_app/modules/teachers_screen/teachers_screen.dart';
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
    DependentsScreen(),
  ] ;

  List<String> titles = [
    'Raqi' ,
    'Teachers' ,
    'Sessions' ,
    'Dependents'
  ];

  void changeBottomNav(int index){
    currentIndex = index ;
    if(currentIndex == 1){
      getTeachers();
    }
    emit(RaqiChangeBottomNavBarState());
  }

  List<UserModel> teachers = [] ;
  void getTeachers(){
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
}