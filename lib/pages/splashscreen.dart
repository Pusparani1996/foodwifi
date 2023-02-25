import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foodwifi/router/router.gr.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pagenavigateaftersplash();
  }

  void pagenavigateaftersplash() {
    Future.delayed(const Duration(milliseconds: 1650))
        .whenComplete(() => context.router.replace(const NavigationBarRoute()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Image.asset(
          "assets/images/splash.gif",
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
