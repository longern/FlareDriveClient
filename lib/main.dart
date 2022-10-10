import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

WebViewController? _controller;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WillPopScope(
        onWillPop: () async {
          if (await _controller!.canGoBack()) {
            _controller!.goBack();
            return Future.value(false);
          } else {
            return Future.value(true);
          }
        },
        child: SafeArea(
          child: WebView(
            initialUrl: "https://drive.longern.com/",
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController controller) {
              _controller = controller;
            },
            onPageFinished: (url) {
              _controller!.runJavascript(
                  "document.dispatchEvent(new Event('deviceready'));");
            },
          ),
        ),
      ),
    );
  }
}
