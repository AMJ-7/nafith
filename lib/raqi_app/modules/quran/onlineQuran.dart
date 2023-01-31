import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class OnlineQuranScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse('http://quran.ksu.edu.sa/m.php?l=ar#aya=1_1')),
          initialOptions: InAppWebViewGroupOptions(
              android: AndroidInAppWebViewOptions(
                  mixedContentMode: AndroidMixedContentMode.MIXED_CONTENT_ALWAYS_ALLOW
              )
          ),
        ),
      ),
    );
  }
}
