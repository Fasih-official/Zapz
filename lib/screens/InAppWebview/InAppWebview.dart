import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:listar_flutter/utils/translate.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyInAppWebView extends StatefulWidget {
  @override
  _InAppWebViewState createState() => new _InAppWebViewState();
}

class _InAppWebViewState extends State<MyInAppWebView> {
  WebViewController webView;
  String url = "";
  double progress = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translate.of(context).translate('zappy')),
        centerTitle: true,
      ),
      body: WebView(
        initialUrl: "https://webchat.snatchbot.me/b16ca1d304d30189b18d77f1148ec211b9fed9857dd634acfb6d0e410bc36b8c",
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController controller) {
          webView = controller;
        },
      ),
    );
  }
}
