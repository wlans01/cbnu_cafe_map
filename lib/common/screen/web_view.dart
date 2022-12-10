import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_template/common/screen/shimmer.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../layout/default_layout.dart';

class WebViewScreen extends StatefulWidget {
  static String get routeName => 'webView';

  const WebViewScreen({Key? key}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      bodyBehind: true,
      padding: 0,
      body: SafeArea(
        child: Stack(
          children: [
            WebView(
              initialUrl:
                  'https://abrasive-lamprey-19b.notion.site/05676f7bb9954891a7d53c25491290f5',
              javascriptMode: JavascriptMode.unrestricted,
              onPageFinished: (String string) {
                setState(() {
                  isLoading = false;
                });
              },
            ),
            isLoading ? const ShimmerScreen() : Container()
          ],
        ),
      ),
    );
  }
}
