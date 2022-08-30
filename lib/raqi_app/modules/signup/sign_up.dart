import 'package:conditional_builder/conditional_builder.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raqi/raqi_app/app_cubit/app_cubit.dart';
import 'package:raqi/raqi_app/modules/otp/otp_signup_screen.dart';
import 'package:raqi/raqi_app/modules/signup/cubit/cubit.dart';
import 'package:raqi/raqi_app/modules/signup/cubit/states.dart';
import 'package:raqi/raqi_app/shared/colors.dart';
import 'package:raqi/raqi_app/shared/components/components.dart';

class SignupScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var type = 'student';
  bool isChecked = false ;
  String gender = 'male';

  String? country ;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RaqiSignupCubit(),
      child: BlocConsumer<RaqiSignupCubit , RaqiSignupStates>(
        listener:(context , state) {
          // if(state is RaqiCreateUserSuccessState){
          //   RaqiCubit.get(context).getUserData();
          //   CacheHelper.saveData(
          //       key: 'uId',
          //       value: uId).then((value) {
          //     navigateAndFinish(context, RaqiLayout());
          //   });
          // }
        } ,
        builder:(context , state) {
          return Scaffold(
            appBar: AppBar(),
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
                          'Signup',
                          style: Theme.of(context).textTheme.headline3!.copyWith(
                              color: textColor
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Register to be with our family !',
                          style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: Colors.grey[500],
                          ),
                        ),
                        SizedBox(height: 30,),
                        defaultTxtForm(
                            controller: nameController,
                            type: TextInputType.name,
                            validate: (value){
                              if(value!.isEmpty){
                                return "What\'s your name !";
                              }

                            },
                            label: 'Name',
                            prefix: Icons.person
                        ),
                        SizedBox(height: 15,),
                        TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          validator: (value){
                            if(value!.isEmpty){
                              return "Your phone can't be empty !";
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Phone',
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
                        SizedBox(height: 15,),
                        defaultTxtForm(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (value){
                              if(value!.isEmpty){
                                return "Your email can't be empty !";
                              }

                            },
                            label: 'Email',
                            prefix: Icons.email_outlined
                        ),
                      Row(children: [
                        Expanded(
                          child: RadioListTile(
                            activeColor: buttonsColor,
                              title: Text("Male"),
                              value: "male",
                              groupValue: gender,
                              onChanged: (value){
                                gender = value.toString() ;
                                print(gender);
                                RaqiSignupCubit.get(context).changeRadio();
                              }
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            activeColor: buttonsColor,
                              title: Text("Female"),
                              value: "female",
                              groupValue: gender,
                              onChanged: (value){
                                gender = value.toString() ;
                                print(gender);
                                RaqiSignupCubit.get(context).changeRadio();
                              }
                          ),
                        ),
                      ],),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Row(
                            children: [
                              Checkbox(
                                activeColor: buttonsColor,
                                  value: isChecked,
                                  onChanged: (value){
                                    if(value!){
                                      type = 'teacher';
                                    }
                                    if(!value){
                                      type = 'student';
                                    }
                                    RaqiSignupCubit.get(context).changeCheckBox();
                                    print(type);
                                    isChecked = !isChecked ;
                                  }
                              ),
                              Text('Iam a Teacher')
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ConditionalBuilder(
                          condition: state is! RaqiSignupLoadingState,
                          builder: (context) => defaultButton(
                              function: (){
                                if(formKey.currentState!.validate()){
                                  navigateTo(context, OtpScreen(
                                    "+${country}${phoneController.text}",
                                    nameController.text,
                                    emailController.text,
                                    type,
                                    gender
                                ));
                                }
                              },
                              text: 'Signup'
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
                              "or signup with",
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } ,
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
        RaqiSignupCubit.get(context).changeCountry();
      },
    );
  }
}
