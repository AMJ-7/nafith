import 'package:flutter/material.dart';
import 'package:raqi/raqi_app/app_cubit/app_cubit.dart';
import 'package:raqi/raqi_app/modules/buy_screen/register.dart';
import 'package:raqi/raqi_app/shared/colors.dart';
import 'package:raqi/raqi_app/shared/components/components.dart';

class BuyScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("Hello," ,style: TextStyle(fontSize: 24),),
              Spacer(),
              Row(
                children: [
                  Icon(Icons.timer,color: Colors.orange.shade600,),
                  SizedBox(width: 5,),
                  Text("1200",style: TextStyle(fontSize: 20),)
                ],
              )
            ],
          ),
          Text("${RaqiCubit.get(context).userModel!.name}," ,style: TextStyle(fontSize: 24),),
          Row(
            children: [
            Expanded(child: Image.asset("assets/images/card.png",height: 300,))
          ],),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              defaultButton(function: (){
                navigateTo(context, RegisterScreen());

              }, text: "Buy minutes",background: Colors.orange.shade600,width: 270),
            ],
          )
        ],
      ),
      
    );
  }
}
