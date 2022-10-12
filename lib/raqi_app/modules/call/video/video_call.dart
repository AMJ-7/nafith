import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:raqi/raqi_app/app_cubit/app_cubit.dart';
import 'package:raqi/raqi_app/models/call_model.dart';
import 'package:raqi/raqi_app/modules/call/agora_config.dart';

class CallPage extends StatefulWidget {
  final String channelId;
  final Call call;
  const CallPage({
    Key? key,
    required this.channelId,
    required this.call,
  }) : super(key: key);

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  AgoraClient? client;
  String baseUrl = 'https://nafith-app.herokuapp.com';
  @override
  void initState() {
    super.initState();
    client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: AgoraConfig.appId,
        channelName: widget.channelId,
        tokenUrl: baseUrl,
      ),
    );
    initAgora();
  }
  void initAgora() async {
    await client!.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: client == null
          ? const CircularProgressIndicator()
          : SafeArea(
        child: Stack(
          children: [
            AgoraVideoViewer(client: client!),
            AgoraVideoButtons(
              client: client!,
              disconnectButtonChild: InkWell(
                onTap: ()async{
                  await client!.engine.leaveChannel();
                  RaqiCubit.get(context).endCall(widget.call);
                  Navigator.pop(context);
                },
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Icon(
                      Icons.call_end,
                    color: Colors.white,
                  ),
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
