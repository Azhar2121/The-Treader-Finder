// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:thetrade_finder/Feature/Controller/webview_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({
    super.key,
    required this.webViewUrl,
  });

  final String webViewUrl;

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final webviewController = Get.put(WebviewController());
  late final WebViewController webViewController;
  DateTime? lastBackPressed;

  @override
  void initState() {
    super.initState();
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) async {
            if (request.url.startsWith('tel:') ||
                request.url.startsWith('mailto:')) {
              await launchUrl(request.url);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onPageFinished: (String url) {
            webviewController.isLaoding.value = false;
          },
        ),
      )
      ..loadRequest(
        Uri.parse(widget.webViewUrl),
      );
  }

  Future<bool> _onWillPop() async {
    DateTime now = DateTime.now();
    if (lastBackPressed == null ||
        now.difference(lastBackPressed!) > Duration(seconds: 1)) {
      lastBackPressed = now;
      if (await webViewController.canGoBack()) {
        webViewController.goBack();
        return Future.value(false);
      }
      return Future.value(false); // Handle single tap by not closing app
    } else {
      // Double tap detected
      bool? exit = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Exit App'),
          content: Text('Are you sure you want to exit the app?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Yes'),
            ),
          ],
        ),
      );
      return exit ?? false;
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("build being called in webview ${widget.webViewUrl}");

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              WebViewWidget(
                controller: webViewController,
              ),
              Obx(() => (webviewController.isLaoding.value
                  ? Center(child: CircularProgressIndicator.adaptive())
                  : SizedBox.shrink())),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
