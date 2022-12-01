import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:raqi/raqi_app/shared/components/constants.dart';

class VisaCardScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse('https://accept.paymob.com/api/acceptance/iframes/683607?payment_token=$PaymobFinalToken')),
        initialOptions: InAppWebViewGroupOptions(
            android: AndroidInAppWebViewOptions(
                mixedContentMode: AndroidMixedContentMode.MIXED_CONTENT_ALWAYS_ALLOW
            )
        ),
      ),
    );
  }
}
