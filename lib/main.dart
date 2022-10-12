import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:raqi/raqi_app/app_cubit/app_cubit.dart';
import 'package:raqi/raqi_app/app_cubit/app_states.dart';
import 'package:raqi/raqi_app/layout/raqi_layout.dart';
import 'package:raqi/raqi_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:raqi/raqi_app/shared/bloc_observer.dart';
import 'package:raqi/raqi_app/shared/components/applocale.dart';
import 'package:raqi/raqi_app/shared/network/dio.dart';
import 'package:raqi/raqi_app/styles/themes.dart';
import 'raqi_app/shared/components/constants.dart';
import 'raqi_app/shared/network/local/cache_helper.dart';



void main() async{
  print('Main Starting');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  await DioHelperPayment.init();


  Bloc.observer = MyBlocObserver();

  uId = CacheHelper.getData(key: 'uId');
  Widget widget ;
  if(uId != null){
    widget = RaqiLayout();
  }else {
    widget = OnBoardingScreen() ;
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
        BlocProvider(create: (BuildContext context) => RaqiCubit()),
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
            localizationsDelegates: [
              AppLocale.delegate,
              GlobalMaterialLocalizations.delegate ,
              GlobalWidgetsLocalizations.delegate ,
            ],
            supportedLocales: [
              Locale("ar" , "") ,
              Locale("en" , "") ,
              Locale("tr" , "") ,
            ],
            localeResolutionCallback: (currentLang , supportLang){
              if (currentLang != null){
                for(Locale locale in supportLang){
                  if(locale.languageCode == currentLang.languageCode){
                    return currentLang ;
                  }

                }

              }
              return supportLang.first ;
            },
          );
        },
      ),
    );
  }

}
