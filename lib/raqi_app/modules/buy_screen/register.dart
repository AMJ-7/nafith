import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raqi/raqi_app/modules/payment/cubit/cubit.dart';
import 'package:raqi/raqi_app/modules/payment/cubit/states.dart';
import 'package:raqi/raqi_app/modules/payment/visacard.dart';
import 'package:raqi/raqi_app/shared/components/components.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var firstnameController = TextEditingController();
  var lastnameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentCubit(),
      child: BlocConsumer<PaymentCubit , PaymentStates>(
        listener: (context , state){
          if(state is PaymentRequestTokenSuccessState){
            navigateTo(context, VisaCardScreen());
          }
        },
        builder: (context , state){
          return Scaffold(
            appBar: AppBar(title: Text("Payment"),),
            body: Padding(
              padding: const EdgeInsets.all(18.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(child: Image.asset("assets/images/payments.png",height: 200,))
                        ],),
                      SizedBox(height: 25,),
                      defaultTxtForm(
                          controller: firstnameController,
                          type: TextInputType.name,
                          validate: (value){
                            if(value!.isEmpty){
                              return "your name must be entered";
                            }

                          },
                          label: "first name",
                          prefix: Icons.person
                      ),
                      SizedBox(height: 25,),
                      defaultTxtForm(
                          controller: lastnameController,
                          type: TextInputType.name,
                          validate: (value){
                            if(value!.isEmpty){
                              return "your name must be entered";
                            }

                          },
                          label: "last name",
                          prefix: Icons.person
                      ),
                      SizedBox(height: 15,),
                      defaultTxtForm(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (value){
                            if(value!.isEmpty){
                              return "your phone number must be entered";
                            }

                          },
                          label: "Phone",
                          prefix: Icons.phone
                      ),
                      SizedBox(height: 15,),
                      defaultTxtForm(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value){
                            if(value!.isEmpty){
                              return "your email must be entered";
                            }

                          },
                          label: "email",
                          prefix: Icons.email
                      ),
                      SizedBox(height: 15,),
                      defaultTxtForm(
                          controller: priceController,
                          type: TextInputType.number,
                          validate: (value){
                            if(value!.isEmpty){
                              return "what is the price ?";
                            }

                          },
                          label: "Price",
                          prefix: Icons.monetization_on
                      ),
                      SizedBox(height: 15,),
                      defaultButton(function: (){
                        if(formKey.currentState!.validate()){

                        }
                        PaymentCubit.get(context).getFirstToken(priceController.text, firstnameController.text, lastnameController.text, emailController.text, phoneController.text);

                      }, text: "Pay"),
                    ],
                  ),
                ),
              ),
            ),
          ) ;
        },
      ),
    );
  }
}
