import 'package:flutter/material.dart';
import 'signin.dart';
// import 'login.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String _title = '';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: LoginScreen(),
      home: const AuthenticateSolo1Widget(),
    );
  }
}

// import 'package:flutter/material.dart';

// class AuthenticateSolo1Widget extends StatefulWidget {
//   const AuthenticateSolo1Widget({Key? key}) : super(key: key);

//   @override
//   _AuthenticateSolo1WidgetState createState() =>
//       _AuthenticateSolo1WidgetState();
// }

// class _AuthenticateSolo1WidgetState extends State<AuthenticateSolo1Widget>
//     with TickerProviderStateMixin {
//   final emailAddressLoginController = TextEditingController();
//   final passwordLoginController = TextEditingController();
//   bool passwordLoginVisibility = true;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         backgroundColor: Color(0xFF14181B),
//         body: Container(
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height,
//           decoration: BoxDecoration(
//             color: Color(0xFF14181B),
//             image: DecorationImage(
//               fit: BoxFit.cover,
//               image: NetworkImage(
//                 'https://images.unsplash.com/photo-1525824236856-8c0a31dfe3be?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8d2F0ZXJmYWxsfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60',
//               ),
//             ),
//           ),
//           child: Container(
//             width: 100,
//             height: 100,
//             decoration: BoxDecoration(
//               color: Color.fromRGBO(0, 0, 0, 0.6), // Translucent black box
//             ),
//             child: Padding(
//               padding: EdgeInsetsDirectional.fromSTEB(0, 70, 0, 0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   Padding(
//                     padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 20),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.max,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "Gudnyt",
//                           style: TextStyle(
//                             fontSize: 28,
//                             color: Color(0xFFF59B15), // #f59b15 color
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     child: DefaultTabController(
//                       length: 2,
//                       initialIndex: 0,
//                       child: Column(
//                         children: [
//                           Container(
//                             color: Color.fromRGBO(
//                                 0, 0, 0, 0.6), // Translucent black box
//                             child: Align(
//                               alignment: Alignment(0, 0),
//                               child: TabBar(
//                                 tabs: [
//                                   Tab(
//                                     text: 'Sign In',
//                                   ),
//                                   Tab(
//                                     text: 'Sign Up',
//                                   ),
//                                 ],
//                                 labelStyle: TextStyle(
//                                   color: Color(0xFFF59B15), // #f59b15 color
//                                   fontSize: 20, // Increase text size
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             child: TabBarView(
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsetsDirectional.fromSTEB(
//                                       44, 0, 44, 0),
//                                   child: SingleChildScrollView(
//                                     child: Column(
//                                       mainAxisSize: MainAxisSize.max,
//                                       children: [
//                                         Padding(
//                                           padding:
//                                               EdgeInsetsDirectional.fromSTEB(
//                                                   0, 20, 0, 0),
//                                           child: TextFormField(
//                                             controller:
//                                                 emailAddressLoginController,
//                                             obscureText: false,
//                                             decoration: InputDecoration(
//                                               labelText: 'Email Address',
//                                               labelStyle: TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 16,
//                                               ),
//                                               enabledBorder: OutlineInputBorder(
//                                                 borderSide: BorderSide(
//                                                   color: Colors.white,
//                                                 ),
//                                               ),
//                                               focusedBorder: OutlineInputBorder(
//                                                 borderSide: BorderSide(
//                                                   color: Colors.white,
//                                                 ),
//                                               ),
//                                             ),
//                                             style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 16,
//                                             ),
//                                             maxLines: null,
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding:
//                                               EdgeInsetsDirectional.fromSTEB(
//                                                   0, 12, 0, 0),
//                                           child: TextFormField(
//                                             controller: passwordLoginController,
//                                             obscureText:
//                                                 passwordLoginVisibility,
//                                             decoration: InputDecoration(
//                                               labelText: 'Password',
//                                               labelStyle: TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 16,
//                                               ),
//                                               enabledBorder: OutlineInputBorder(
//                                                 borderSide: BorderSide(
//                                                   color: Colors.white,
//                                                 ),
//                                               ),
//                                               focusedBorder: OutlineInputBorder(
//                                                 borderSide: BorderSide(
//                                                   color: Colors.white,
//                                                 ),
//                                               ),
//                                               suffixIcon: InkWell(
//                                                 onTap: () {
//                                                   setState(() {
//                                                     passwordLoginVisibility =
//                                                         !passwordLoginVisibility;
//                                                   });
//                                                 },
//                                                 child: Icon(
//                                                   passwordLoginVisibility
//                                                       ? Icons
//                                                           .visibility_outlined
//                                                       : Icons
//                                                           .visibility_off_outlined,
//                                                   size: 20,
//                                                   color: Colors.white,
//                                                 ),
//                                               ),
//                                             ),
//                                             style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 16,
//                                             ),
//                                             maxLines: 1,
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding:
//                                               EdgeInsetsDirectional.fromSTEB(
//                                                   0, 24, 0, 0),
//                                           child: ElevatedButton(
//                                             onPressed: () async {
//                                               // Your login logic here
//                                             },
//                                             child: Text(
//                                               'Login',
//                                               style: TextStyle(
//                                                 fontSize: 18,
//                                                 color: Colors.white,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding:
//                                               EdgeInsetsDirectional.fromSTEB(
//                                                   0, 20, 0, 0),
//                                           child: TextButton(
//                                             onPressed: () {
//                                               // Navigate to forgot password screen
//                                             },
//                                             child: Text(
//                                               'Forgot Password?',
//                                               style: TextStyle(
//                                                 fontSize: 18,
//                                                 color: Colors.white,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 Container(), // Empty container for Sign Up tab
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// //
// //
// //
// //
// //
// //
