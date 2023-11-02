import 'package:flutter/material.dart';
import 'signin.dart';
import 'login.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String _title = 'Iremially';
  // This widget is the root of your application.ChJDb250YWluZXJfeWI1M2Uzc2gSzgIKD0NvbHVtbl83d3Z4YXZ2bBJ2Cg1JY29uX2tjMDEzeXh3GAgiVDpACjEI9IM8Eg1NYXRlcmlhbEljb25zIAAyGnN1cGVydmlzb3JfYWNjb3VudF9yb3VuZGVkEQAAAAAAAEZAIgIQB4gDAvoDAPIFCQkAAAAAAADwP2IAkgEHML2ywv6TMMIBABJMCg1UZXh0X3g2cWM0c2tnGAIiKhILCgU1Ni40azACQAFaCSEAAAAAAAAQQIgDAvoDAPIFCQkAAAAAAADwP2IAkgEHMJ/lwv6TMMIBABIsCg1UZXh0X3kyNjA1N3ZnGAIiFxIPCglDdXN0b21lcnMwAkAPiAMC+gMAYgAYBCJAIgYIABAGMgBaJAkAAAAAAAAoQBEAAAAAAAAoQBkAAAAAAAAoQCEAAAAAAAAoQIgDAvoDAPIFCQkAAAAAAADwP2IAwgEAGAEiYgpOChYKCRFokAZpkAY/QBIJCQAAAAAAQGBAEjASJAkAAAAAAAA4QBEAAAAAAAA4QBkAAAAAAAA4QCEAAAAAAAA4QEICEAVaAGICEAEiAFIAiAMC+gMA8gUJCQAAAAAAAPA/YgB6ZAgCEAEZAAAAAAAAAAAhAAAAAADAgkAoAUokCQAAAAAAAAAAEQAAAAAAAAAAGQAAAAAAgFZAIQAAAAAAAPA/UiQJAAAAAAAA8D8RAAAAAAAAAAAZAAAAAAAAAAAhAAAAAAAA8D/CAQA=lemon@yahoo.com
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      theme: ThemeData(
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
      home: RoomPricesPage(),
      // home: const AuthenticateSolo1Widget(),
    );
  }
}
