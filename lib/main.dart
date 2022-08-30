import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raqi/raqi_app/app_cubit/app_cubit.dart';
import 'package:raqi/raqi_app/app_cubit/app_states.dart';
import 'package:raqi/raqi_app/layout/raqi_layout.dart';
import 'package:raqi/raqi_app/modules/login/login_screen.dart';
import 'package:raqi/raqi_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:raqi/raqi_app/shared/bloc_observer.dart';
import 'package:raqi/raqi_app/styles/themes.dart';
import 'raqi_app/shared/components/constants.dart';
import 'raqi_app/shared/network/local/cache_helper.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();


  Bloc.observer = MyBlocObserver();

  uId = CacheHelper.getData(key: 'uId');
  Widget widget ;
  if(uId != null){
    widget = RaqiLayout();
  }else {
    widget = LoginScreen() ;
  }


  runApp(MyApp(
    startWidget : widget,
  ));
}

class MyApp extends StatelessWidget{
  final Widget? startWidget ;
  MyApp({this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => RaqiCubit()..getUserData(),),
      ],
      child: BlocConsumer<RaqiCubit , RaqiStates>(
        listener: (context , state){},
        builder: (context , state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light ,
            home: startWidget,
          );
        },
      ),
    );
  }

}
