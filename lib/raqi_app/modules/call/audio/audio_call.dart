import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:raqi/raqi_app/models/raqi_user_model.dart';
import 'package:raqi/raqi_app/modules/call/agora_config.dart';
import 'package:raqi/raqi_app/shared/components/components.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;

class AudioCallScreen extends StatefulWidget {
  UserModel? model ;
   AudioCallScreen({
    Key? key,
    this.model
  }) : super(key: key);

  @override
  State<AudioCallScreen> createState() => _AudioCallScreenState();
}

class _AudioCallScreenState extends State<AudioCallScreen> {
  late int remoteUid = 0 ;
  late RtcEngine engine ;
  @override
  void initState() {
    initAgora();
    super.initState();
  }

  @override
  void dispose() {
    engine.leaveChannel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: remoteUid == 0 ? Text('Calling ${widget.model!.name} ...') :
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Container(
              color: Colors.white,
            height: 150,
            width: 150,
                child: Image.network('${widget.model!.image}'),
              ),

            ),
              SizedBox(height: 15,),
              Text('${widget.model!.name}',style: Theme.of(context).textTheme.headline6,)
              ],
            )
            ,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap:  (){
                      Navigator.of(context).pop(true);
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 30,
                      child: Icon(
                              Icons.call_end,
                            size: 30,
                            color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )

        ],
      ),
    );
  }


  //Functions
   Future<void> initAgora() async {
    await [Permission.microphone , Permission.camera].request();
    engine = await RtcEngine.create(AgoraConfig.appId);
    engine.enableVideo();
    engine.setEventHandler(
      RtcEngineEventHandler(
        joinChannelSuccess: (String channel , int uid , int elapsed){
          print('local user $uid joined successfully');
        },
        userJoined: (int uid , int elapsed){
          setState(() => remoteUid = uid);
        },
        userOffline: (int uid , UserOfflineReason reason){
          print('remote user $uid left call');
          setState(() => remoteUid = 0);
          Navigator.of(context).pop(true);
        }
      )
    );

    await engine.joinChannel(AgoraConfig.token, AgoraConfig.channelName, null, 0);

   }

}
