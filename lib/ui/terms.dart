import 'dart:async';

import 'package:flutter/material.dart';
import 'package:insurancehero/utils/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsConditionsView extends StatelessWidget {
  TermsConditionsView();

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Terms & Conditions'),
          backgroundColor: lightGreenColor,
        ),
        body: Builder(builder: (BuildContext context) {
          return WebView(
            initialUrl:
                "https://www.freeprivacypolicy.com/live/b4758391-b804-479e-a9fb-2a5b9dee98eb",
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
