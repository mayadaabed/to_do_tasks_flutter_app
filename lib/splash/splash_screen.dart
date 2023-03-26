import 'package:flutter/material.dart';
import 'package:to_do_app/layouts/home_layout.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  rout() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeLayout()),
    );
  }

  @override
  void initState() {
    super.initState();
    rout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Image.asset(
        'assets/images/logo.jpg',
        width: 200,
      )),
    );
  }
}
