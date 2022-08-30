import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raqi/raqi_app/app_cubit/app_cubit.dart';
import 'package:raqi/raqi_app/app_cubit/app_states.dart';
import 'package:raqi/raqi_app/shared/colors.dart';
import 'package:raqi/raqi_app/shared/components/components.dart';
import 'package:raqi/raqi_app/shared/components/constants.dart';

class RaqiLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RaqiCubit , RaqiStates>(
      listener: (context , state) {},
      builder: (context , state) {
        var cubit = RaqiCubit.get(context);
        return ConditionalBuilder(
          condition: RaqiCubit.get(context).userModel != null,
          builder: (context) => Scaffold(
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
                  defaultTextButton(
                      function: (){
                        signOut(context);
                      },
                      text: 'Logout',
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
              title: Text(cubit.titles[cubit.currentIndex]),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index){
                cubit.changeBottomNav(index);
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.business_center),
                    label: 'Teachers'),
                BottomNavigationBarItem(icon: Icon(Icons.video_camera_front_rounded)
                    , label: 'Sessions'),
                BottomNavigationBarItem(icon: Icon(Icons.people)
                    ,label: 'Dependents'),
              ],

            ),
            body: cubit.screens[cubit.currentIndex],
          ),
          fallback: (context) => Scaffold(body: Center(child: CircularProgressIndicator(color: buttonsColor,),)),
        );
      }
    );
  }
}
