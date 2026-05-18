import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:jobsprint/src/features/authentication/presentation/screens/splashscreen.dart';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 255, 255, 255),
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
    );
  }
}
