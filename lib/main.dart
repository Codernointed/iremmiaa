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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      color: Color(0xFFF59B15),
      // home: LoginScreen(),
      home: AuthenticateSolo1Widget(),
    );
  }
}
