import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WebView extends StatefulWidget {
  static const String routeName = '/webview';
   String url;
   WebView({Key? key, required this.url}) : super(key: key);
  @override
  _WebView createState() => _WebView(this.url);
}

class _WebView extends State<WebView> {
  double progress = 0;
  bool isLoading=true;
  //final urlController = TextEditingController();
  String url = "";
  _WebView(this.url);
  late InAppWebViewController _webViewController;
  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldkey,
        appBar: AppBar(
          title: Text(
            'WebView',
            textDirection: TextDirection.ltr,
            style: TextStyle(color: Color(0xffFFFFFF)),
          ),
          backgroundColor: Color(0xffDF193E),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: false,
        ),
        body: Stack(
          children: [
            InAppWebView(
              //initialUrl: "http://google.com",
              initialUrlRequest: URLRequest(url: Uri.parse(url)),
              initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                      //debuggingEnabled: true,
                      //disableHorizontalScroll: true,
                      //disableVerticalScroll: true,
                      supportZoom: true)),
              onWebViewCreated: (InAppWebViewController controller) {
                _webViewController = controller;
              },
              onLoadStart: (controller, url) async{
                setState(() {
                  this.url = url.toString();
                  print(this.url);
                  //urlController.text = this.url;
                });
              },
              onLoadStop:
                  (controller, url) async {
                setState(() {
                  this.url = url.toString();
                  print(this.url);
                  isLoading = false;
                  //urlController.text = this.url;
                });
              },
              onProgressChanged:
                  (InAppWebViewController controller, int progress) {
                setState(() {
                  this.progress = progress / 100;
                });
              },
            ),
            isLoading ? Center( child: CircularProgressIndicator(),)
                : Stack(),
          ],
        ));
  }
}
