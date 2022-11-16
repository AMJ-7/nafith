import 'package:flutter/material.dart';
import 'package:raqi/raqi_app/app_cubit/app_cubit.dart';
import 'package:raqi/raqi_app/models/call_model.dart';
import 'package:raqi/raqi_app/modules/call/video/video_call.dart';
import 'package:raqi/raqi_app/shared/components/applocale.dart';
import 'package:raqi/raqi_app/shared/components/components.dart';

class PickupScreen extends StatelessWidget {
  final Call call ;
  PickupScreen({
    required this.call
});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
            "${getLang(context,"incoming")}",
              style: TextStyle(fontSize: 30),),
            SizedBox(
              height: 50,),
            Image.network(
              call.callerPic,
              height: 150,
              width: 150,),
            SizedBox(height: 15,),
            Text(
              call.callerName,
              style: TextStyle(fontWeight: FontWeight.bold ,
              fontSize: 20
              ),
            ),
            SizedBox(height: 75,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: ()async{
                    await RaqiCubit.get(context).endCall(call , context);
                  },
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.red,
                    child: Icon(Icons.call_end, color: Colors.white),
                  ),
                ),
                SizedBox(width: 15,),
                InkWell(
                  onTap: ()async{
                    navigateTo(context, CallPage(call: call , channelId: call.callerId,));

                  },
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.green,
                    child: Icon(Icons.call , color: Colors.white,),
                  ),
                )
              ],
            )

          ],
        ),
      ),
    );
  }
}
