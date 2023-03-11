import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raqi/raqi_app/app_cubit/app_cubit.dart';
import 'package:raqi/raqi_app/modules/payment/cubit/cubit.dart';
import 'package:raqi/raqi_app/modules/payment/cubit/states.dart';
import 'package:raqi/raqi_app/paytaps/presentation/payment/payment_states.dart';
import 'package:raqi/raqi_app/paytaps/presentation/payment/payment_viewmodel.dart';
import 'package:raqi/raqi_app/paytaps/presentation/styles/app_colors.dart';
import 'package:raqi/raqi_app/shared/colors.dart';
import 'package:raqi/raqi_app/shared/components/applocale.dart';
import 'package:raqi/raqi_app/shared/components/components.dart';
import '../resources/asset_images.dart';

class PaymentScreen extends StatefulWidget {

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final PaymentViewModel _viewModel = PaymentViewModel();
  var flag = 0;
  int pakka = 2 ;
  double amount = 35 ;
  var couponController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentCubit(),
      child: BlocConsumer<PaymentCubit, PaymobStates>(
        listener: (context, state){},
        builder: (context, state){
          return Scaffold(
            backgroundColor: AppColors.white,
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        print(flag);
                        if(flag == 0){
                          _viewModel.startCardPayment(PaymentCubit.get(context).dis == 0 ? amount : amount - (amount*(PaymentCubit.get(context).dis/100)), RaqiCubit.get(context).userModel!.uId,context);
                        }
                        if(flag == 1){
                          _viewModel.startApplePayment(PaymentCubit.get(context).dis == 0 ? amount : amount - (amount*(PaymentCubit.get(context).dis/100)), RaqiCubit.get(context).userModel!.uId,context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text(
                        "${getLang(context,"continue")}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        Row(
                          children: [
                            Text("${getLang(context,"hello")}" ,style: TextStyle(fontSize: 24),),
                            Spacer(),
                            Row(
                              children: [
                                Icon(Icons.timer,color: buttonsColor),
                                SizedBox(width: 5,),
                                Text("${RaqiCubit.get(context).userModel!.minutes}",style: TextStyle(fontSize: 20),),
                                Text("${getLang(context,"min")}",style: TextStyle(fontSize: 20 , color: Colors.grey),)
                              ],
                            )
                          ],
                        ),
                        Text("${RaqiCubit.get(context).userModel!.name}," ,style: TextStyle(fontSize: 24),),
                        SizedBox(height: 30,),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    pakka = 1 ;
                                    amount = 10 ;
                                    print(pakka);
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        if(pakka == 1)
                                          BoxShadow(color: Colors.grey,blurRadius: 20)
                                      ]
                                  ),
                                  height: pakka == 1 ? 125 : 110,
                                  child: Card(
                                    color: pakka == 1 ? buttonsColor : Colors.grey,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.asset('assets/images/bronze.png',width: 50,height: 50,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              PaymentCubit.get(context).dis == 0 ? Text("10 ${getLang(context,"cost")}",style: TextStyle(color: Colors.white, fontSize: 16 )) : Text("${10 - (10*(PaymentCubit.get(context).dis/100))} ${getLang(context,"cost")}",style: TextStyle(color: Colors.white, fontSize: 16 )),
                                              Text("420 ${getLang(context,"min")}",style: TextStyle(color: Colors.white, fontSize: 14 ))
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    pakka = 2 ;
                                    amount = 35 ;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        if(pakka == 2)
                                          BoxShadow(color: Colors.grey,blurRadius: 20)
                                      ]
                                  ),
                                  height: pakka == 2 ? 125 : 110,
                                  child: Card(
                                    color: pakka == 2 ? buttonsColor : Colors.grey,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.asset('assets/images/fadda.png',width: 50,height: 50,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              PaymentCubit.get(context).dis == 0 ? Text("35 ${getLang(context,"cost")}",style: TextStyle(color: Colors.white, fontSize: 16 )) : Text("${35 - (35*(PaymentCubit.get(context).dis/100))} ${getLang(context,"cost")}",style: TextStyle(color: Colors.white, fontSize: 16 )),
                                              Text("1680 ${getLang(context,"min")}",style: TextStyle(color: Colors.white, fontSize: 14 ))

                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    pakka = 3 ;
                                    amount = 70 ;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        if(pakka == 3)
                                          BoxShadow(color: Colors.grey,blurRadius: 20)
                                      ]
                                  ),
                                  height: pakka == 3 ? 125 : 110,
                                  child: Card(
                                    color: pakka == 3 ? buttonsColor : Colors.grey,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.asset('assets/images/gold.png',width: 50,height: 50,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              PaymentCubit.get(context).dis == 0 ? Text("70 ${getLang(context,"cost")}",style: TextStyle(color: Colors.white, fontSize: 16 )) : Text("${70 - (70*(PaymentCubit.get(context).dis/100))} ${getLang(context,"cost")}",style: TextStyle(color: Colors.white, fontSize: 16 )),
                                              Text("3360 ${getLang(context,"min")}",style: TextStyle(color: Colors.white, fontSize: 14 ))

                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30,),
                        Row(
                          children: [
                            Expanded(
                              child: defaultTxtForm(
                                  controller: couponController,
                                  type: TextInputType.text,
                                  validate: (val){},
                                  label: "${getLang(context,"coupon")}"
                              ),
                            ),
                            SizedBox(width: 10,),
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.green,
                              child: IconButton(icon : Icon(CupertinoIcons.check_mark_circled), color: Colors.white, onPressed: () {
                                PaymentCubit.get(context).getCoupon(couponController.text);
                                couponController.text = "";
                              },),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  PaymentOption(
                    height: 70,
                    index: 0,
                    name: 'Credit / Debit Card',
                    icon: Icon(Icons.credit_card, color: Colors.black54),
                    flag: flag,
                    onPress: () {
                      setState(() {
                        flag = 0;
                      });
                    },
                  ),
                  PaymentOption(
                    height: 70,
                    index: 1,
                    name: 'Apple Pay',
                    icon: SvgPicture.asset(
                      AssetImages.applePay,
                      height:  50,
                    ),
                    flag: flag,
                    onPress: () {
                      setState(() {
                        flag = 1;
                      });
                    },
                  ),
                  PaymentOption(
                    height: 70,
                    index: 2,
                    name: 'valU',
                    icon: SvgPicture.asset(
                      AssetImages.valU,
                      height: 50,
                    ),
                    flag: flag,
                    onPress: () {
                      setState(() {
                        showToast(text: "سيتوفر قريبا", state: ToastStates.WARNING);
                        flag = 2;
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class PaymentOption extends StatefulWidget {
  const PaymentOption({
    required this.index,
    required this.height,
    required this.name,
    required this.icon,
    required this.flag,
    required this.onPress,
    Key? key,
  }) : super(key: key);

  final double height;
  final int index;
  final String name;
  final Widget icon;
  final int flag;
  final Function onPress;

  @override
  State<PaymentOption> createState() => _PaymentOptionState();
}

class _PaymentOptionState extends State<PaymentOption> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16) - const EdgeInsets.only(bottom: 16),
      child: SizedBox(
        height: widget.height,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shadowColor: Colors.white38,
            backgroundColor: Colors.white,
            elevation: widget.flag == widget.index ? 12 : 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
          ),
          onPressed: () {
            widget.onPress();
          },
          child: Row(
            children: [
              Icon(
                widget.flag == widget.index
                    ? Icons.check_circle
                    : Icons.radio_button_off_outlined,
                color: widget.flag == widget.index
                    ? AppColors.red
                    : Colors.black54,
              ),
              const SizedBox(width: 8),
              Text(
                widget.name,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const Spacer(),
              widget.icon,
            ],
          ),
        ),
      ),
    );
  }
}
