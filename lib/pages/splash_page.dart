import 'dart:async';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => Navigator.pushNamed(context, '/sign-in'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 400,
          height: 1000,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/splashscreen.png'), // Sesuaikan nama dan ekstensi file dengan yang ada di pubspec.yaml
              fit: BoxFit.cover, // Sesuaikan sesuai kebutuhan tampilan gambar
            ),
          ),
        ),
      ),
    );
  }
}
