import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage();
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late WebViewController controller;

  bool isLoading = false; // if you use cookies you need to turn false
  bool isError = false;

  // String userCookie = "SID= //SID ; Path= //PATH; HttpOnly;";

  @override
  void initState() {
    super.initState();
    initializeWebView();
  }

  //WebView Configrations with Cookie setup
  Future<void> initializeWebView() async {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onNavigationRequest: (request) {
            if (request.url.startsWith('www.google.com')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            setState(() {
              isError = false;
              isLoading = false;
            });
          },
        ),
      );
        controller
          ..loadRequest(Uri.parse("www.youtube.com"))
          ..currentUrl().then((url) {
            setState(() {

            });
          });

        /* Future.delayed(Duration(seconds: 20), () {
          var data = response.headers['set-cookie'];
          if(data != null){
            print('-------------------------\n $data \n ------------------------');

          }else
          {
            print("NULL");
          }
        });*/

      // print("Response Headers: ${response.headers}");
      // print(await response.stream.bytesToString());

     //if ERROR part
    /*else {
      print("Response Status: ${response.statusCode}");
      print(response.reasonPhrase);
    } //else ERROR part*/


  } // initializeWebView()

  @override
  void dispose() {
    controller.clearCache();
    controller.clearLocalStorage();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: Text('webview'),
      backgroundColor: Colors.orange,
    );
    //AppBar settings for future design use (NOT ACTIVE)

    //ScreenSize apadt
    var size = MediaQuery.of(context).size;
    var height = size.height * 0.7;
    var width = size.width * 0.9;
    var aspectRatioOfDevice = width / height;

    //Error handling for WebView loadin
      return Container(
        //Screen Size adapt
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,

        child:  SafeArea(
          child: AspectRatio(aspectRatio: aspectRatioOfDevice,
            //WebView
            child:  WebViewWidget(controller: controller,
              ),
            ),
          bottom: false,
          ),
      );

  }
}
