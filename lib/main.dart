import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

InAppWebViewController? _controller;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WillPopScope(
        onWillPop: () async {
          var history = await _controller!.getCopyBackForwardList();
          var canGoBack = (history!.currentIndex ?? 0) >= 1;
          if (canGoBack) _controller!.goBack();
          return !canGoBack;
        },
        child: SafeArea(
          child: InAppWebView(
            initialUrlRequest:
                URLRequest(url: Uri.parse("https://drive.longern.com/")),
            onWebViewCreated: (InAppWebViewController controller) {
              _controller = controller;
            },
            onLoadStop: (controller, url) {
              controller.evaluateJavascript(
                  source: "document.dispatchEvent(new Event('deviceready'));");
            },
          ),
        ),
      ),
    );
  }
}
