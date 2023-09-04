import 'dart:async';

// import 'package:bisa_app/animation/fade_animation.dart';
// import 'package:bisa_app/animation/loop_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// import 'package:flutter';
// import 'package:webview_flutter/webview_flutter.dart';

class CovidPage extends StatefulWidget {
  CovidPage({Key? key}) : super(key: key);

  @override
  _CovidPageState createState() => _CovidPageState();
}

class _CovidPageState extends State<CovidPage> {
  // InAppWebViewController _webViewController;
  String url = "";
  double progress = 0;
  // final Completer<WebViewController> _controller =
  //     Completer<WebViewController>();
  late final WebViewController _controller;
  String initialUrl = 'https://ghanahealth.maps.arcgis.com/apps/opsdashboard/index.html#/2acce23387f24cfbb8b9efe76a93e1f7';

  @override
  void initState() {
    super.initState();
    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    _controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..setBackgroundColor(const Color(0x00000000))
  ..setNavigationDelegate(
    NavigationDelegate(
      onProgress: (int progress) {
        // Update loading bar.
      },
      onPageStarted: (String url) {},
      onPageFinished: (String url) {},
      onWebResourceError: (WebResourceError error) {},
      onNavigationRequest: (NavigationRequest request) {
        // if (request.url.startsWith('https://www.youtube.com/')) {
        //   return NavigationDecision.prevent;
        // }
        return NavigationDecision.navigate;
      },
    ),
  )
  ..loadRequest(Uri.parse(initialUrl));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.black,
        ),
        title: Text(
          'Covid-19',
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontFamily: 'Lato',
              fontSize: 30.sp,
              color: Color.fromRGBO(85, 80, 80, 0.98)),
        ),
        elevation: 0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // InAppWebView()
                // SizedBox(height: 0.1.sh,),
                // SizedBox(height: kToolbarHeight,),
                Container(
                  height: 670.h,
                  child: WebViewWidget(controller: _controller),
                  // child: WebView(
                  //   initialUrl:
                  //       'https://ghanahealth.maps.arcgis.com/apps/opsdashboard/index.html#/2acce23387f24cfbb8b9efe76a93e1f7',
                  //   // initialUrl: 'https://ghanahealthservice.org/covid19/dashboardm.php',
                  //   javascriptMode: JavascriptMode.unrestricted,
                  //   onWebViewCreated: (WebViewController webViewController) {
                  //     _controller.complete(webViewController);
                  //   },
                  //   onProgress: (int progress) {
                  //     print("WebView is loading (progress : $progress%)");
                  //   },
                  // ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Source: Ghana Health Service',
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w700,
                            fontSize: 20.sp),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          _launchInBrowser(
                              'https://ghanahealthservice.org/covid19/');
                        },
                        child: Text(
                          'https://ghanahealthservice.org/covid19/',
                          style: TextStyle(
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w400,
                              fontSize: 18.sp,
                              decoration: TextDecoration.underline,
                              color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50.h,
                )
              ],
            ),
          ),
          // Stack(
          //   children: [
          //     Container(
          //       height: 110.h,
          //       color: Colors.white,
          //     ),
          //     Positioned(
          //       top: -20.w,
          //       right: -30.w,
          //       child: FadeAnimation(2.2,-30,0,
          //         LoopWidget(30,Opacity(
          //           opacity: 0.25,
          //           child: Container(
          //             width: 150.w,
          //             height: 150.w,
          //             decoration: BoxDecoration(
          //               shape: BoxShape.circle,
          //               gradient: RadialGradient(
          //                 colors: [
          //                   Color.fromRGBO(63, 133, 198, 0.646),
          //                   Color.fromRGBO(63, 198, 149, 0.76),
          //                 ]
          //               )
          //             ),
          //           ),
          //         ),700)
          //       )
          //     ),
          //     Container(
          //       height: 90.h,
          //       child: FadeAnimation(1.2, - 30,0,Center(
          //         child: Column(
          //           children: [
          //             // SizedBox(height: kToolbarHeight),
          //             Padding(
          //               padding: EdgeInsets.all(8.0),
          //               child: Row(
          //                 children: <Widget>[
          //                   IconButton(
          //                     onPressed: (){
          //                       Navigator.pop(context);
          //                     },
          //                     icon: Icon(Icons.arrow_back,color: Colors.black,),
          //                   ),
          //                   SizedBox(width: 2,),
          //                   Column(
          //                     children: [

          //                       Padding(
          //                         padding: EdgeInsets.all(8.0),
          //                         child: Text('Covid-19',
          //                           style: TextStyle(
          //                             fontWeight: FontWeight.w700,
          //                             fontFamily: 'Lato',
          //                             fontSize: 25.sp,
          //                             color: Color.fromRGBO(85, 80, 80, 0.98)
          //                           ),
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),),
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
}

Future<void> _launchInBrowser(String url) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: true,
      forceWebView: true,
      // headers: <String, String>{'my_header_key': 'my_header_value'},
    );
  } else {
    throw 'Could not launch $url';
  }
}
