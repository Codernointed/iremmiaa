import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:rebook/profile_page.dart';

import 'signin.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String _title = 'Bookmie';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      theme: ThemeData(
        fontFamily: GoogleFonts.merriweatherSans().fontFamily,
        primarySwatch: const MaterialColor(
          0xFFF59B15,
          <int, Color>{
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
      // routes: {
      //   '/login': (context) => AuthenticateSolo1Widget(),
      //   '/home': (context) => HomePage(
      //       accessToken: ModalRoute.of(context)!.settings.arguments as String),
      //   '/price': (context) => RoomPricesPage(
      //       accessToken: ModalRoute.of(context)!.settings.arguments as String),
      //   '/detail': (context) => RoomDetailsPage(
      //       accessToken: ModalRoute.of(context)!.settings.arguments as String),
      // },
      // initialRoute: '/login',
      // home: ProfilePage(),
      home: const AuthenticateSolo1Widget(),
    );
  }
}
