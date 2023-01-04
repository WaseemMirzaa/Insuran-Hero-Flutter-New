import 'dart:async';

import 'package:flutter/material.dart';
import 'package:insurancehero/utils/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyView extends StatelessWidget {
  PrivacyPolicyView();

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: lightGreenColor,
          title: const Text('Privacy Policy'),
        ),
        body: Builder(builder: (BuildContext context) {
          return WebView(
            initialUrl:
                "https://htmlpreview.github.io/?https://github.com/codetivelab/privacy-policy/blob/main/insurancehero_privacy-policy.html",
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            navigationDelegate: (NavigationRequest request) {
              if (request.url.startsWith('https://www.youtube.com/')) {
                print('blocking navigation to $request}');
                return NavigationDecision.prevent;
              }
              print('allowing navigation to $request');
              return NavigationDecision.navigate;
            },
            onPageStarted: (String url) {
              print('Page started loading: $url');
            },
            onPageFinished: (String url) {
              print('Page finished loading: $url');
            },
            gestureNavigationEnabled: true,
          );
        }));
  }
}
