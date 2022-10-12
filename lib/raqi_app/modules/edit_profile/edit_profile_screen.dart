import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raqi/raqi_app/app_cubit/app_cubit.dart';
import 'package:raqi/raqi_app/app_cubit/app_states.dart';
import 'package:raqi/raqi_app/shared/colors.dart';
import 'package:raqi/raqi_app/shared/components/applocale.dart';
import 'package:raqi/raqi_app/shared/components/components.dart';


class EditProfileScreen extends StatelessWidget {

  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RaqiCubit , RaqiStates>(
      listener: (context , state) {},
      builder: (context , state) {
        var userModel = RaqiCubit.get(context).userModel;
        nameController.text = userModel!.name ;
        bioController.text = userModel.bio ;
        phoneController.text = userModel.phone ;
        return Container(
          decoration: BoxDecoration(image: DecorationImage(
            image: NetworkImage('https://i.pinimg.com/564x/d4/36/a3/d436a3a87ed95767504cbf66f85b13a5.jpg'),
            fit: BoxFit.cover
          ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: defaultAppBar(
                context: context,
                title: "${getLang(context,"editProfile")}",
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: defaultTextButton(function: (){
                      RaqiCubit.get(context).updateUser(name: nameController.text,
                          phone: phoneController.text,
                          bio: bioController.text);

                    }, text: "${getLang(context,"submit")}" , color: Colors.white),
                  )
                ]
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  if(state is RaqiUserUpdateLoadingState)
                    LinearProgressIndicator(
                    color: lightColor,
                  ),
                  SizedBox(height: 10,),
                  Container(
                    height: 150,
                    child: Align(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: CircleAvatar(
                        radius: 65,
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        backgroundImage: RaqiCubit.get(context).userModel!.image == null ?
                        NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/User-avatar.svg/1024px-User-avatar.svg.png',) :
                        NetworkImage(RaqiCubit.get(context).userModel!.image),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    height: 800,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(35) , topRight: Radius.circular(35)),
                      child: Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40.0 , horizontal: 30),
                          child: Column(
                            children: [
                              defaultTxtForm(
                                  controller: nameController,
                                  type: TextInputType.name,
                                  validate: (value){
                                    if(value!.isEmpty){
                                      return "Whats your name !";
                                    }
                                    return null ;
                                  },
                                  label: "${getLang(context,"name")}",
                                prefix: Icons.person,

                              ),
                              SizedBox(height: 15,),
                              defaultTxtForm(
                                controller: bioController,
                                type: TextInputType.text,
                                validate: (value){},
                                label: "${getLang(context,"bio")}",
                                prefix: Icons.info_outline,

                              ),
                              SizedBox(height: 15,),
                              defaultTxtForm(
                                controller: phoneController,
                                type: TextInputType.phone,
                                validate: (value){},
                                label: "${getLang(context,"phone")}",
                                prefix: Icons.call,

                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                  )

                ],
              ),
            ) ,
          ),
        ) ;
      },
    );
  }

}
