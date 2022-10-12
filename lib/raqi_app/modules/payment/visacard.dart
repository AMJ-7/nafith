import 'package:flutter/material.dart';
import 'package:raqi/raqi_app/shared/components/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VisaCardScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: 'https://accept.paymob.com/api/acceptance/iframes/683607?payment_token=$PaymobFinalToken',
      ),
    );
  }
}
