import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shoes_store/presentation/routes/app_pages.dart';

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3), // Change the duration as needed
      () => Navigator.pushReplacement(context, Routes.register()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/splashscreen.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
