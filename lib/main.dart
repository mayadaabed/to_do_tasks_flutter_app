import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/splash/splash_screen.dart';
import 'shared/bloc_observer/bloc_observer.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
