import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raqi/raqi_app/modules/login/cubit/cubit.dart';
import 'package:raqi/raqi_app/modules/login/cubit/states.dart';
import 'package:raqi/raqi_app/modules/otp/otp_login_screen.dart';
import 'package:raqi/raqi_app/modules/signup/sign_up.dart';
import 'package:raqi/raqi_app/shared/colors.dart';
import 'package:raqi/raqi_app/shared/components/applocale.dart';
import 'package:raqi/raqi_app/shared/components/components.dart';

class LoginScreen extends StatelessWidget {
  String? country ;

  var formKey = GlobalKey<FormState>();

  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>RaqiLoginCubit(),
      child: BlocConsumer<RaqiLoginCubit , RaqiLoginStates>(
        listener: (context , state) {
          if(state is RaqiLoginErrorState){
            // showToast(text: state.error,
            //     state: ToastStates.ERROR
            // );
          }
          if(state is RaqiLoginSuccessState){
            // RaqiCubit.get(context).getUserData();
            // CacheHelper.saveData(
            //     key: 'uId',
            //     value: state.uId).then((value) {
            //   navigateAndFinish(context, RaqiLayout());
            // });
          }
        },
        builder: (context , state) {
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${getLang(context,"login")}",
                          style: Theme.of(context).textTheme.headline3!.copyWith(
                              color: textColor
                          ),
                        ),
                        SizedBox(height: 10,),
                        Center(child: Container(
                            height: 300,
                            width: 300,
                            child: Image(image: AssetImage('assets/images/loginimg.png')))),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${getLang(context,"lets")}",
                          style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: Colors.grey[500],
                          ),
                        ),

                        SizedBox(height: 30,),
                        TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          validator: (value){
                            if(value!.isEmpty){
                              return "${getLang(context,"phoneQ")}";
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "${getLang(context,"phone")}",
                            prefixIcon: country == null ? GestureDetector(
                                child: Icon(Icons.arrow_drop_down_sharp), onTap: (){
                              pickCountry(context);
                            },) : GestureDetector(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('+${country}'),
                                  ],
                                ),onTap: (){
                                  pickCountry(context);
                            },),
                          ),

                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ConditionalBuilder(
                          condition: state is! RaqiLoginLoadingState,
                          builder: (context) => defaultButton(
                              function: (){
                                if(formKey.currentState!.validate()){
                                  navigateTo(context,country != null ? OtpLoginScreen("+${country}${phoneController.text}") : OtpLoginScreen("${phoneController.text}"));
                                }
                              },
                              text: "${getLang(context,"loginB")}"
                          ),
                          fallback: (context) => Center(child: CircularProgressIndicator(color: buttonsColor,)),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${getLang(context,"orLW")}",
                              style: TextStyle(fontSize: 16),
                            ),

                          ],
                        ),
                        SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              child: Card(
                                elevation: 8,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset('assets/images/Apple.png'),
                                ),),
                            ),
                            SizedBox(width: 20,),
                            Container(
                              height: 70,
                              width: 70,
                              child: Card(
                                elevation: 8,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset('assets/images/google.jpg'),
                                ),),
                            )
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${getLang(context,"dontHave")}",
                              style: TextStyle(fontSize: 16),
                            ),
                            defaultTextButton(function: (){
                               navigateTo(context , SignupScreen());
                            }, text: "${getLang(context,"signup")}"),

                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ) ;
        },
      ),
    );
  }
  pickCountry(context){
    showCountryPicker(
      context: context,
      showPhoneCode: true, // optional. Shows phone code before the country name.
      onSelect: (Country _country) {
        country = _country.phoneCode ;
        print('Select country: ${_country.phoneCode}');
        RaqiLoginCubit.get(context).changeCountry();
      },
    );
  }
}
