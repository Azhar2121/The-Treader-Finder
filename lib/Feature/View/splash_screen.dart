// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:thetrade_finder/Constant/images.dart';
import 'package:thetrade_finder/Feature/View/test.dart';

import 'web_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future<void>.delayed(
      const Duration(seconds: 5),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => WebViewScreen(
                    webViewUrl: 'https://thetradefinder.co.uk/',
                  )),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Center(
          child: Image.asset(
            Images.splashScreen,
          ),
        ),
      ),
    );
  }
}
