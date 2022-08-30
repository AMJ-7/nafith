import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raqi/raqi_app/modules/login/cubit/states.dart';
import 'package:raqi/raqi_app/shared/components/constants.dart';


class RaqiLoginCubit extends Cubit<RaqiLoginStates>{
  RaqiLoginCubit() : super(RaqiLoginInitialState());

  static RaqiLoginCubit get(context) => BlocProvider.of(context);

  void loginSuccess(){
    emit(RaqiLoginSuccessState());
  }
  void changeCountry(){
    emit(RaqiChangeCountrySuccessState());
  }


//   void userLogin({
//     required String email ,
//     required String password
// }){
//     emit(RaqiLoginLoadingState());
//
//     FirebaseAuth.instance.signInWithEmailAndPassword(email: email,
//         password: password
//     ).then((value) {
//       print(value.user!.email);
//       print(value.user!.uid);
//       //uId = value.user!.uid;
//       emit(RaqiLoginSuccessState(value.user!.uid));
//     }).catchError((error){
//       emit(RaqiLoginErrorState(error.toString()));
//     });
//   }

  IconData suffix = Icons.visibility_outlined ;
  bool isPassword = true ;

  void changePasswordVisibility(){
    isPassword = !isPassword ;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined ;
    emit(RaqiChangePasswordVisibilityState());
  }

  dynamic verificationCode ;
  verifyPhone(
      String phone,
      context

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
              uId = value.user!.uid;
              RaqiLoginCubit.get(context).loginSuccess();
            }
          });
        },
        verificationFailed: (FirebaseAuthException e){
          print(e.message);
        },
        codeSent: (String? verificationID , int? resendToken){
          verificationCode = verificationID ;
        },
        codeAutoRetrievalTimeout: (String verificationID){
          verificationCode = verificationID ;
        },
        timeout: Duration(seconds: 120)
    );
  }
}