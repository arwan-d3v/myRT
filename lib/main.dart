import 'package:flutter/material.dart';
import 'package:myrt/core/theme/app_theme.dart';
import 'package:myrt/features/auth/screens/login_screen.dart';
import 'package:myrt/features/home/screens/home_screen.dart';

void main() {
  runApp(const MyRTApp());
}

class MyRTApp extends StatelessWidget {
  const MyRTApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyRT Digital',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}