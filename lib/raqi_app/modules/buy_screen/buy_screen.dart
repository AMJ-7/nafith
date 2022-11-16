import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raqi/raqi_app/app_cubit/app_cubit.dart';
import 'package:raqi/raqi_app/app_cubit/app_states.dart';
import 'package:raqi/raqi_app/modules/buy_screen/register.dart';
import 'package:raqi/raqi_app/shared/colors.dart';
import 'package:raqi/raqi_app/shared/components/applocale.dart';
import 'package:raqi/raqi_app/shared/components/components.dart';

class BuyScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RaqiCubit , RaqiStates>(
      listener: (context , state){} ,
      builder: (context , state){
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                    Expanded(child: Image.asset("assets/images/card.png",height: 180,))
                  ],),
                SizedBox(height: 15,),
                GestureDetector(
                  onTap: (){
                    RaqiCubit.get(context).emitPakka(1);
                  },
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    child: Card(
                      color: RaqiCubit.get(context).pakka == 1 ? buttonsColor : Colors.grey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Image.asset('assets/images/bronze.png'),
                            SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("80 L.E",style: TextStyle(color: Colors.white, fontSize: 20 )),
                                Text("3.3 \$",style: TextStyle(color: Colors.white, fontSize: 15 ),),

                              ],
                            ),
                            Spacer(),
                            Text("420 ${getLang(context,"min")}",style: TextStyle(color: Colors.white, fontSize: 20 ))
                          ],
                        ),
                      ),

                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    RaqiCubit.get(context).emitPakka(2);
                  },
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    child: Card(
                      color: RaqiCubit.get(context).pakka == 2 ? buttonsColor : Colors.grey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Image.asset('assets/images/fadda.png'),
                            SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("280 L.E",style: TextStyle(color: Colors.white, fontSize: 20 )),
                                Text("11.5 \$",style: TextStyle(color: Colors.white, fontSize: 15 ),),

                              ],
                            ),
                            Spacer(),
                            Text("1680 ${getLang(context,"min")}",style: TextStyle(color: Colors.white, fontSize: 20 ))
                          ],
                        ),
                      ),

                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    RaqiCubit.get(context).emitPakka(3);
                  },
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    child: Card(
                      color: RaqiCubit.get(context).pakka == 3 ? buttonsColor : Colors.grey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Image.asset('assets/images/gold.png'),
                            SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("500 L.E",style: TextStyle(color: Colors.white, fontSize: 20 )),
                                Text("20.6 \$",style: TextStyle(color: Colors.white, fontSize: 15 ),),

                              ],
                            ),
                            Spacer(),
                            Text("3360 ${getLang(context,"min")}",style: TextStyle(color: Colors.white, fontSize: 20 ))
                          ],
                        ),
                      ),

                    ),
                  ),
                ),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: defaultButton(function: (){
                        if(RaqiCubit.get(context).pakka == 1){
                          navigateTo(context, RegisterScreen(80));
                        }
                        if(RaqiCubit.get(context).pakka == 2){
                          navigateTo(context, RegisterScreen(280));
                        }
                        if(RaqiCubit.get(context).pakka == 3){
                          navigateTo(context, RegisterScreen(500));
                        }

                      }, text: "${getLang(context,"buy")}",background: buttonsColor,),
                    ),
                  ],
                )
              ],
            ),

          ),
        ) ;
      } ,
    );
  }
}
