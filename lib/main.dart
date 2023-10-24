import 'package:flutter/material.dart';
import 'signin.dart';
// import 'login.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String _title = 'Iremially';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      theme: ThemeData(
        primarySwatch: MaterialColor(
          0xFFF59B15,
          const <int, Color>{
            50: Color(0xFFFFF7F7),
            100: Color(0xFFFFE8E8),
            200: Color(0xFFFFD9D9),
            300: Color(0xFFFFCACA),
            400: Color(0xFFFFB8B8),
            500: Color(0xFFF59B15),
            600: Color(0xFFF49212),
            700: Color(0xFFF38B0F),
            800: Color(0xFFF2840C),
            900: Color(0xFFF17D09),
          },
        ),
      ),
      // home: LoginScreen(),
      home: const AuthenticateSolo1Widget(),
    );
  }
}
