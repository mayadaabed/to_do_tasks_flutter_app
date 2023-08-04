import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/splash/splash_screen.dart';
import 'package:to_do_app/style/colors.dart';
import 'shared/bloc_observer/bloc_observer.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: mainColor),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
