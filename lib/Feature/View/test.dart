// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/instance_manager.dart';
// import 'package:thetrade_finder/Feature/Controller/webview_controller.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:url_launcher/url_launcher.dart';

// class WebViewScreen extends StatefulWidget {
//   const WebViewScreen({
//     super.key,
//     required this.webViewUrl,
//   });

//   final String webViewUrl;

//   @override
//   State<WebViewScreen> createState() => _WebViewScreenState();
// }

// class _WebViewScreenState extends State<WebViewScreen> {
//   final webviewController = Get.put(WebviewController());
//   late final WebViewController webViewController;

//   @override
//   void initState() {
//     super.initState();
//     webViewController = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
      
//       ..setNavigationDelegate(NavigationDelegate(
//         onUrlChange: (change) {
//           log("hjsdghjgfhjfg ${change.url}");
//         },
//         // onNavigationRequest: (request) {
//         //   final url = request.url;
//         //   log("hjdhsfg ${url}");
//         //   if (url.startsWith('tel:') || url.startsWith('mailto:')) {
//         //     _launchNativeApp(url);
//         //     return NavigationDecision.prevent;
//         //   }
//         //   return NavigationDecision.navigate;
//         // },
//       ))
//       ..loadRequest(
//         Uri.parse(widget.webViewUrl),
//       );
//   }

//   void _launchNativeApp(String url) async {
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: WebViewWidget(
//         controller: webViewController,
//       ),
//     );
//   }
// }
