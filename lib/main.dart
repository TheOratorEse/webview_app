import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MaterialApp(
    home: WebViewApp(url: 'https://m.facebook.com'), //api or url of webapp
  ));
}

class WebViewApp extends StatefulWidget {
  final String url;
  const WebViewApp({super.key, required this.url});

  @override
  WebViewAppState createState() => WebViewAppState();
}

class WebViewAppState extends State<WebViewApp> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Title"),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(),
        ],
      ),
    );
  }
}