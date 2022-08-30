import 'package:raqi/raqi_app/modules/login/login_screen.dart';
import 'package:raqi/raqi_app/shared/components/components.dart';
import 'package:raqi/raqi_app/shared/network/local/cache_helper.dart';

void signOut(context){
  CacheHelper.removeData(key: 'uId').then((value) {
    if(value){
      navigateAndFinish(context, LoginScreen());
    }
  });
}

String uId = '' ;