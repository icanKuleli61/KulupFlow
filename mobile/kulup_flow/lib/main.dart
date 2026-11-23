import 'package:flutter/material.dart';
import 'package:kulup_flow/KayitSayfasi.dart';
import 'package:kulup_flow/mainNavigator.dart';
import 'package:kulup_flow/splash_screen.dart';
import 'package:kulup_flow/login.dart';

void main() {
  return runApp(KlupFlowApp());
}

class KlupFlowApp extends StatelessWidget {
  @override
  Widget build(Object context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "KlüpFlow",
      theme: ThemeData(
        useMaterial3: true,

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6750D8),
          brightness: Brightness.light,
        ),

        scaffoldBackgroundColor: const Color(0xFFF7F7FC),

        textTheme: const TextTheme(
          headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),

          titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),

          bodyMedium: TextStyle(fontSize: 14),
        ),
      ),
      home: MainNavigator(),
    );
  }
}
