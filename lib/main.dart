import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:raqi/firebase_options.dart';
import 'package:raqi/raqi_app/app_cubit/app_cubit.dart';
import 'package:raqi/raqi_app/app_cubit/app_states.dart';
import 'package:raqi/raqi_app/layout/raqi_layout.dart';
import 'package:raqi/raqi_app/modules/chat/chat_details_screen.dart';
import 'package:raqi/raqi_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:raqi/raqi_app/modules/payment/cubit/cubit.dart';
import 'package:raqi/raqi_app/modules/signup/sign_up.dart';
import 'package:raqi/raqi_app/shared/bloc_observer.dart';
import 'package:raqi/raqi_app/shared/components/applocale.dart';
import 'package:raqi/raqi_app/shared/components/components.dart';
import 'package:raqi/raqi_app/shared/network/dio.dart';
import 'package:raqi/raqi_app/shared/network/firebase_messaging.dart';
import 'package:raqi/raqi_app/shared/network/notification_service.dart';
import 'package:raqi/raqi_app/styles/themes.dart';
import 'raqi_app/shared/components/constants.dart';
import 'raqi_app/shared/network/local/cache_helper.dart';


  // when app is in background
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  LocalNotificationService.display(message);
  print(message.data.toString());

}


Future<void> main() async{
  print('Main Starting');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  LocalNotificationService.initialize();
  await CacheHelper.init();
  await DioHelperPayment.init();

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  print('User granted permission: ${settings.authorizationStatus}');

  // when click on notification
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    LocalNotificationService.display(event);
    print(event.data.toString());
  });


  // when app is opened
  FirebaseMessaging.onMessage.listen((event) {
    LocalNotificationService.display(event);
    print(event.data.toString());
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  deviceToken = await FirebaseMessaging.instance.getToken();
  print(deviceToken);

  SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
  );




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
        BlocProvider(create: (BuildContext context) => PaymentCubit()),
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
            localizationsDelegates: const[
              AppLocale.delegate,
              GlobalMaterialLocalizations.delegate ,
              GlobalWidgetsLocalizations.delegate ,
              GlobalCupertinoLocalizations.delegate
            ],
            supportedLocales: const[
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
