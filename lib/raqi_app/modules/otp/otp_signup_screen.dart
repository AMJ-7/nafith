import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:raqi/raqi_app/app_cubit/app_cubit.dart';
import 'package:raqi/raqi_app/layout/raqi_layout.dart';
import 'package:raqi/raqi_app/modules/signup/cubit/cubit.dart';
import 'package:raqi/raqi_app/modules/signup/cubit/states.dart';
import 'package:raqi/raqi_app/shared/colors.dart';
import 'package:raqi/raqi_app/shared/components/components.dart';
import 'package:raqi/raqi_app/shared/components/constants.dart';
import 'package:raqi/raqi_app/shared/network/local/cache_helper.dart';

class OtpScreen extends StatelessWidget {

  var pinController = TextEditingController();
  final String phone ;
  final String name ;
  final String email ;
  final String type ;
  final String gender ;
  OtpScreen(this.phone , this.name , this.email , this.type , this.gender);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RaqiSignupCubit(),
      child: BlocConsumer<RaqiSignupCubit , RaqiSignupStates>(
        listener:(context , state){
          if(state is RaqiSignupSuccessState){
            pinController.text = RaqiSignupCubit.get(context).verificationCode;
            RaqiCubit.get(context).getUserData();
            CacheHelper.saveData(
                key: 'uId',
                value: uId).then((value) {
              navigateAndFinish(context, RaqiLayout());
            });
          }
        } ,
        builder:(context , state){
          RaqiSignupCubit.get(context).verifyPhone(phone, email, name, gender, type, context);
          return Scaffold(
            appBar: AppBar(title: Text('OTP verification'),),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Column(
                  children: [
                    Image.asset('assets/images/otp.png',height: 250,),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Code sent to ' , style: TextStyle(fontSize: 20),),
                        Text('${phone}' , style: TextStyle(fontSize: 24,color: textColor),)
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0,vertical: 20),
                      child: Pinput(
                        length: 6,
                        keyboardType: TextInputType.number,
                        controller: pinController,
                        defaultPinTheme: defaultPinTheme,
                        focusedPinTheme: focusedPinTheme,
                        submittedPinTheme: submittedPinTheme,
                        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                        textInputAction: TextInputAction.next,
                        showCursor: true,
                        validator: (pin) {
                          try{FirebaseAuth.instance.signInWithCredential(
                              PhoneAuthProvider.credential(
                                  verificationId: RaqiSignupCubit.get(context).verificationCode,
                                  smsCode: pin!)
                          ).then((value) {
                            if(value.user != null){
                              print('pass to home');
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
                          }catch(e){
                            FocusScope.of(context).unfocus();
                            print('invalid otp');
                          }

                        },
                        onCompleted: (pin) => print(pin),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          );
        } ,
      ),
    );
  }
}
final defaultPinTheme = PinTheme(
  width: 56,
  height: 56,
  textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
  decoration: BoxDecoration(
    border: Border.all(color: Color.fromRGBO(11, 11, 69, 1),width: 2),
    borderRadius: BorderRadius.circular(20),
  ),
);

final focusedPinTheme = defaultPinTheme.copyDecorationWith(
  border: Border.all(color: buttonsColor,width: 2),
  borderRadius: BorderRadius.circular(8),
);

final submittedPinTheme = PinTheme(
  width: 56,
  height: 56,
  textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
  decoration: BoxDecoration(
    color: Color.fromRGBO(240, 228, 247, 1),
    border: Border.all(color: buttonsColor,width: 2),
    borderRadius: BorderRadius.circular(20),
  ),
);



