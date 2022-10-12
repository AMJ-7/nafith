import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raqi/raqi_app/app_cubit/app_cubit.dart';
import 'package:raqi/raqi_app/app_cubit/app_states.dart';
import 'package:raqi/raqi_app/modules/call/pickup/pickup_layout.dart';
import 'package:raqi/raqi_app/modules/edit_profile/edit_profile_screen.dart';
import 'package:raqi/raqi_app/shared/colors.dart';
import 'package:raqi/raqi_app/shared/components/applocale.dart';
import 'package:raqi/raqi_app/shared/components/components.dart';
import 'package:raqi/raqi_app/shared/components/constants.dart';

class RaqiLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    List<String> titles = [
      "${getLang(context,"Nafith")}" ,
      "${getLang(context,"teachers")}" ,
      "${getLang(context,"sessions")}" ,
      "${getLang(context,"dependents")}"
    ];

    RaqiCubit.get(context).getUserData();
    return BlocConsumer<RaqiCubit , RaqiStates>(
      listener: (context , state) {},
      builder: (context , state) {
        var cubit = RaqiCubit.get(context);
        return ConditionalBuilder(
          condition: RaqiCubit.get(context).userModel != null,
          builder: (context) => PickupLayout(
            scaffold: cubit.userModel!.type != 'teacher' ? Scaffold(
              drawer: Drawer(
                child: Column(
                  children: [
                    UserAccountsDrawerHeader(
                        currentAccountPicture: CircleAvatar(
                          child: cubit.userModel!.image == null ? Text('${cubit.userModel!.name[0]}',style: TextStyle(fontSize: 30),) : Image.network(cubit.userModel!.image),
                          backgroundColor: textColor,),
                        decoration: BoxDecoration(
                            color: buttonsColor
                        ),
                        accountName: Text(cubit.userModel!.name),
                        accountEmail: Text(cubit.userModel!.email)
                    ),
                    InkWell(
                      onTap: (){
                        navigateTo(context, EditProfileScreen());
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.settings,size: 28,),
                            SizedBox(width: 8,),
                            Text("${getLang(context,"settings")}",style: TextStyle(fontSize: 18),)
                          ],
                        ),
                      ),
                    ),
                    defaultTextButton(
                        function: (){
                          signOut(context);
                        },
                        text: "${getLang(context,"logout")}",
                        color: Colors.red
                    )

                  ],
                ),
              ),
              appBar: AppBar(
                actions: [
                  IconButton(onPressed: (){},
                      icon: Icon(Icons.notifications)),
                ],
                centerTitle: true,
                title: Text(titles[cubit.currentIndex]),
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.currentIndex,
                onTap: (index){
                  cubit.changeBottomNav(index);
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: "${getLang(context,"home")}"
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.business_center),
                      label: "${getLang(context,"teachers")}"),
                  BottomNavigationBarItem(icon: Icon(Icons.video_camera_front_rounded)
                      , label: "${getLang(context,"sessions")}"),
                  BottomNavigationBarItem(icon: Icon(Icons.timer)
                      ,label: "${getLang(context,"dependents")}"),
                ],

              ),
              body: cubit.screens[cubit.currentIndex],
            ) :
            buildTeacherLayout(context),
          ),
          fallback: (context) => Scaffold(body: Center(child: CircularProgressIndicator(color: buttonsColor,),)),
        );
      }
    );
  }
  Widget buildTeacherLayout(context){
    var cubit = RaqiCubit.get(context);
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  child: cubit.userModel!.image == null ? Text('${cubit.userModel!.name[0]}',style: TextStyle(fontSize: 30),) : Image.network(cubit.userModel!.image),
                  backgroundColor: textColor,),
                decoration: BoxDecoration(
                    color: buttonsColor
                ),
                accountName: Text(cubit.userModel!.name),
                accountEmail: Text(cubit.userModel!.email)
            ),
            InkWell(
              onTap: (){
                navigateTo(context, EditProfileScreen());
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.settings,size: 28,),
                    SizedBox(width: 8,),
                    Text("${getLang(context,"settings")}",style: TextStyle(fontSize: 18),)
                  ],
                ),
              ),
            ),
            defaultTextButton(
                function: (){
                  signOut(context);
                },
                text: "${getLang(context,"logout")}",
                color: Colors.red
            )

          ],
        ),
      ),
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){},
              icon: Icon(Icons.notifications)),
        ],
        centerTitle: true,
        title: Text(cubit.titlesTeacher[cubit.currentIndex]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: cubit.currentIndex,
        onTap: (index){
          cubit.changeBottomNavTeacher(index);
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "${getLang(context,"home")}"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: "${getLang(context,"messages")}"),
          BottomNavigationBarItem(icon: Icon(Icons.monetization_on)
              , label: "${getLang(context,"earning")}"),
        ],

      ),
      body: cubit.screensTeacher[cubit.currentIndex],
    );
  }
}


