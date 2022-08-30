import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raqi/raqi_app/app_cubit/app_cubit.dart';
import 'package:raqi/raqi_app/app_cubit/app_states.dart';
import 'package:raqi/raqi_app/models/raqi_user_model.dart';
import 'package:raqi/raqi_app/shared/colors.dart';
import 'package:raqi/raqi_app/shared/components/components.dart';

class TeachersScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RaqiCubit , RaqiStates>(
      listener: (context , state) {},
      builder: (context , state) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: defaultTxtForm(
                onChanged: (value){

                },
                validate: (String? value) {
                  if(value!.isEmpty){
                    return 'Who r u search for ?';
                  }
                  return null ;
                },
                controller: searchController,
                type: TextInputType.text,
                label: 'Find a Teacher !',
                prefix: Icons.search,
              ),
            ),

            Expanded(
              child: ConditionalBuilder(
                condition: RaqiCubit.get(context).teachers.length > 0,
                builder: (context) => ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context , index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: buildTeacherItem(RaqiCubit.get(context).teachers[index] , context),
                    ),
                    separatorBuilder: (context , index) => myDivider(),
                    itemCount: RaqiCubit.get(context).teachers.length
                ),
                fallback: (context) => Center(child: CircularProgressIndicator(color: buttonsColor,),),
              ),
            )
          ],
        );
      },
    );
  }
}

Widget buildTeacherItem(UserModel model , context) => InkWell(
  onTap: (){

  },
  child: Card(
    elevation: 10,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage('${model.image}'),
          ),
          SizedBox(width: 15,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${model.name}' , style: TextStyle(fontSize: 18),),
              SizedBox(height: 5,),
              Row(
                children: [
                  Icon(Icons.star,color: Colors.amber,),
                  Text('4.9',style: TextStyle(fontSize: 16),)
                ],
              )
            ],
          ),
          Spacer(),
          Column(
            children: [
              InkWell(child: CircleAvatar(
                backgroundColor: buttonsColor,
                child: Icon(Icons.video_camera_front_rounded , color: Colors.white,),)),
              SizedBox(height: 5,),
              InkWell(child: CircleAvatar(
                backgroundColor: buttonsColor,
                child: Icon(Icons.call , color: Colors.white,),))
            ],
          )
        ],
      ),
    ),
  ),
);

