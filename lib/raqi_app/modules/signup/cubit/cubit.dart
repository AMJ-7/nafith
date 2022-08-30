import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raqi/raqi_app/models/raqi_user_model.dart';
import 'package:raqi/raqi_app/modules/signup/cubit/states.dart';
import 'package:raqi/raqi_app/shared/components/constants.dart';

class RaqiSignupCubit extends Cubit<RaqiSignupStates>{
  RaqiSignupCubit() : super(RaqiSignupInitialState());

  static RaqiSignupCubit get(context) => BlocProvider.of(context);

  void signupSuccess(){
    emit(RaqiSignupSuccessState());
  }

  void changeCountry(){
    emit(RaqiChangeCountrySuccessState());
  }

  changeCheckBox(){
    emit(RaqiChangeCheckBoxSignupState());
  }
  changeRadio(){
    emit(RaqiChangeRadioSignupState());
  }



//   void userSignup({
//     required String email ,
//     required String name ,
//     required String phone ,
//     required String password
// }){
//     emit(RaqiSignupLoadingState());
//     FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: email,
//         password: password
//     ).then((value) {
//       print(value.user!.email);
//       print(value.user!.uid);
//       userCreate(
//           email: email,
//           name: name,
//           phone: phone,
//           uId: value.user!.uid);
//       // uId = value.user!.uid;
//     }).catchError((error){
//       emit(RaqiSignupErrorState(error));
//     });
//   }

  void userCreate({
    required String email ,
    required String name ,
    required String phone ,
    required String uId ,
    required String gender ,
    required String type
}){
    UserModel model = UserModel(
      name: name ,
      email: email ,
      phone: phone ,
      uId: uId ,
      gender: gender,
      type: type
    );
      if(type == 'student'){
        FirebaseFirestore.instance
            .collection('students')
            .doc(uId)
            .set(model.toMap())
            .then((value) {
          emit(RaqiCreateUserSuccessState());
        }).catchError((error){
          emit(RaqiCreateUserErrorState(error.toString()));
        });
      }
      if(type == 'teacher'){
        FirebaseFirestore.instance
            .collection('teachers')
            .doc(uId)
            .set(model.toMap())
            .then((value) {
          emit(RaqiCreateUserSuccessState());
        }).catchError((error){
          emit(RaqiCreateUserErrorState(error.toString()));
        });
      }

  }

  IconData suffix = Icons.visibility_outlined ;
  bool isPassword = true ;

  void changePasswordVisibility(){
    isPassword = !isPassword ;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined ;
   emit(RaqiChangePasswordVisibilitySignupState());
  }

  dynamic verificationCode ;
  verifyPhone(
      String phone,
      String email,
      String name,
      String gender,
      String type,
      context,

      )async{
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential)async{
        await FirebaseAuth.instance.signInWithCredential(credential)
            .then((value) {
          if(value.user != null){
            print('Logged in Doooooooone');
            print(verificationCode);
            print(value.user!.uid);
            RaqiSignupCubit.get(context).userCreate(
                email: email,
                name: name,
                phone: phone,
                uId: value.user!.uid,
                gender: gender,
                type: type
            );
            uId = value.user!.uid;
            RaqiSignupCubit.get(context).signupSuccess();
          }
        });
        emit(RaqiVerfiyPhoneSuccessState());
        },
        verificationFailed: (FirebaseAuthException e){
          print(e.message);
        },
        codeSent: (String verificationID , int? resendToken){
          verificationCode = verificationID ;
        },
        codeAutoRetrievalTimeout: (String verificationID){
          verificationCode = verificationID ;
        },
      timeout: Duration(seconds: 90)
    );
  }


}