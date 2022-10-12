import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raqi/raqi_app/app_cubit/app_cubit.dart';
import 'package:raqi/raqi_app/app_cubit/app_states.dart';
import 'package:raqi/raqi_app/modules/call/audio/audio_call.dart';
import 'package:raqi/raqi_app/modules/call/video/video_call.dart';
import 'package:raqi/raqi_app/modules/chat/chat_details_screen.dart';
import 'package:raqi/raqi_app/shared/colors.dart';
import 'package:raqi/raqi_app/shared/components/applocale.dart';
import 'package:raqi/raqi_app/shared/components/components.dart';
import 'package:raqi/utils/call_utils.dart';

class TeacherProfile extends StatelessWidget {

  dynamic teacherId ;
  TeacherProfile(this.teacherId);

  @override
  Widget build(BuildContext context) {
    RaqiCubit.get(context).getTeacher(teacherId);
    return BlocConsumer<RaqiCubit , RaqiStates>(
      listener: (context , state) {} ,
      builder: (context , state) {
        var model = RaqiCubit.get(context).teacherModel;
        return ConditionalBuilder(
          condition: RaqiCubit.get(context).teacherModel != null,
          builder: (context) => Scaffold(
            appBar: AppBar(title: Text(model!.name),),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 170,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          child: Container(
                            height: 140,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                    image:  NetworkImage('https://i.pinimg.com/564x/7b/f3/f7/7bf3f7be26518c10fd37cee2b77d0c83.jpg') ,
                                    fit: BoxFit.cover

                                )
                            ),
                          ),
                          alignment: AlignmentDirectional.topCenter,
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 46,
                                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                backgroundImage: model.image == null ? NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/User-avatar.svg/1024px-User-avatar.svg.png'): NetworkImage('${model.image}') ,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text(model.name,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 24
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star , color: Colors.amber,),
                      Text('4.9', style: TextStyle(fontSize: 18),)
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(child: CircleAvatar(
                        backgroundColor: buttonsColor,
                        child: Icon(Icons.message , color: Colors.white,),),
                        onTap: (){
                          navigateTo(context, ChatDetailsScreen(teacherModel: model));
                        },
                      ),
                      SizedBox(width: 15,),
                      InkWell(
                        onTap: (){
                          CallUtils.dial(
                            from: RaqiCubit.get(context).userModel,
                            to: model,
                            context: context
                          );
                        },
                          child: CircleAvatar(
                        backgroundColor: buttonsColor,
                        child: Icon(Icons.video_camera_front_rounded , color: Colors.white,),)),

                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: myDivider(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text("${getLang(context,"comments")}", style: TextStyle(fontSize: 20),),
                      ),
                    ],
                  ),
                  SizedBox(height: 15,),
                  buildCommentItem(context)


                ],
              ),
            ),
          ),
          fallback: (context) => Scaffold(body: Center(child: CircularProgressIndicator(color: buttonsColor,),)),
        );
      } ,
    );
  }

}

Widget buildCommentItem(context){
  return Card(
    color: Theme.of(context).scaffoldBackgroundColor,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 8,
    margin: EdgeInsets.symmetric(horizontal: 10),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                  child: Image.network(
                      'https://i.pinimg.com/564x/32/99/a8/3299a848fb55c90ca201163f9a6abad6.jpg'),
                radius: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Bassil Haroun',style: TextStyle(fontSize: 16),),
                  Text('16 Septemper 2022',style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 10),)
                ],
              )



            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('The Best Teacher Ever'),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

