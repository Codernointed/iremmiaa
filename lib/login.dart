// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart'; // Import Dio
// import 'dart:convert';

// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final Dio dio = Dio(); // Create a Dio instance

//   Future<void> _login() async {
//     final email = emailController.text;
//     final password = passwordController.text;

//     final apiUrl =
//         'https://ethenatx.pythonanywhere.com/management/obtain-token/';

//     try {
//       final response = await dio.post(apiUrl, data: {
//         'email': email,
//         'password': password,
//       });

//       if (response.statusCode == 200) {
//         final jsonResponse = json.decode(response.data);
//         final accessToken = jsonResponse['access'];

//         // TODO: Save the accessToken. You can use a state management solution like Provider or Bloc for this.

//         // Navigate to the next screen on success
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) =>
//                 SuccessScreen(), // Replace SuccessScreen with your next screen
//           ),
//         );
//       } else {
//         // Authentication failed
//         final jsonResponse = json.decode(response.data);
//         final errorMessage = jsonResponse['message'];

//         // Show an error Snackbar to the user
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(errorMessage), // Display the error message
//             backgroundColor: Colors.red, // Customize the Snackbar color
//           ),
//         );
//       }
//     } catch (e) {
//       // Handle any errors that occurred during the request
//       print('Error: $e');

//       // Show an error Snackbar to the user
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//               'An error occurred. Please try again later.'), // Display a generic error message
//           backgroundColor: Colors.red, // Customize the Snackbar color
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             TextField(
//               controller: emailController,
//               decoration: InputDecoration(labelText: 'Email'),
//             ),
//             SizedBox(height: 16.0),
//             TextField(
//               controller: passwordController,
//               obscureText: true,
//               decoration: InputDecoration(labelText: 'Password'),
//             ),
//             SizedBox(height: 24.0),
//             ElevatedButton(
//               onPressed: _login,
//               child: Text('Login'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SuccessScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Success'),
//       ),
//       body: Center(
//         child: Text('Login Successful!'), // You can customize this screen
//       ),
//     );
//   }
// }
// //
// //
// //
// //
// // import 'package:flutter/material.dart';

// // lemon@yahoo.com
// // 123
// class HomePage extends StatelessWidget {
//   final String accessToken;

//   HomePage({required this.accessToken});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         top: true,
//         child: Column(
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Align(
//               alignment: Alignment(-1.00, 0.00),
//               child: Padding(
//                 padding: EdgeInsets.fromLTRB(30, 30, 0, 30),
//                 child: Text(
//                   'Welcome',
//                   style: TextStyle(
//                     fontFamily: 'Readex Pro',
//                     fontSize: 20,
//                   ),
//                 ),
//               ),
//             ),
//             Align(
//               alignment: Alignment(0.00, 0.00),
//               child: ListView(
//                 padding: EdgeInsets.zero,
//                 shrinkWrap: true,
//                 scrollDirection: Axis.vertical,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
//                     child: Container(
//                       height: 120,
//                       decoration: BoxDecoration(
//                         image: DecorationImage(
//                           fit: BoxFit.cover,
//                           alignment: Alignment(0.00, 0.00),
//                           image: NetworkImage(
//                             'https://images.unsplash.com/photo-1515548212260-ac87067b15ab?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwzfHxwcmljZXN8ZW58MHx8fHwxNjk3NTEwNjA2fDA&ixlib=rb-4.0.3&q=80&w=1080',
//                           ),
//                         ),
//                         gradient: LinearGradient(
//                           colors: [Colors.white, Colors.white],
//                           stops: [0, 1],
//                           begin: Alignment(1, 0),
//                           end: Alignment(-1, 0),
//                         ),
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       child: Stack(
//                         children: [
//                           Opacity(
//                             opacity: 0.5,
//                             child: Align(
//                               alignment: Alignment(0.00, 0.00),
//                               child: Container(
//                                 width: double.infinity,
//                                 height: double.infinity,
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(15),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Align(
//                             alignment: Alignment(0.00, 0.00),
//                             child: Text(
//                               'Update Room Prices',
//                               style: TextStyle(
//                                 fontFamily: 'Readex Pro',
//                                 color: Colors.white,
//                                 fontSize: 25,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   // Add similar code for other items in the list
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:rebook/Custom_classes/custom_card.dart';

class HomePage extends StatelessWidget {
  final String accessToken;

  HomePage({required this.accessToken});

  // Define card data for the custom cards
  final List<Map<String, String>> customCardsData = [
    {
      'text': 'Update Room Prices',
      'imageUrl':
          'https://images.unsplash.com/photo-1515548212260-ac87067b15ab?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwzfHxwcmljZXN8ZW58MHx8fHwxNjk3NTEwNjA2fDA&ixlib=rb-4.0.3&q=80&w=1080',
    },
    {
      'text': 'Update Rooms',
      'imageUrl':
          'https://images.unsplash.com/photo-1515548212260-ac87067b15ab?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&HwxfHNlYXJjaHwzfHxwcmljZXN8ZW58MHx8fHwxNjk3NTEwNjA2fDA&ixlib=rb-4.0.3&q=80&w=1080',
    },
    {
      'text': 'View Rooms',
      'imageUrl':
          'https://images.unsplash.com/photo-1515548212260-ac87067b15ab?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&HwxfHNlYXJjaHwzfHxwcmljZXN8ZW58MHx8fHwxNjk3NTEwNjA2fDA&ixlib=rb-4.0.3&q=80&w=1080',
    },
    {
      'text': 'View Rooms',
      'imageUrl':
          'https://images.unsplash.com/photo-1515548212260-ac87067b15ab?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&HwxfHNlYXJjaHwzfHxwcmljZXN8ZW58MHx8fHwxNjk3NTEwNjA2fDA&ixlib=rb-4.0.3&q=80&w=1080',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment(-1.00, 0.00),
              child: Padding(
                padding: EdgeInsets.fromLTRB(30, 30, 0, 30),
                child: Text(
                  'Welcome',
                  style: TextStyle(
                    fontFamily: 'Readex Pro',
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment(0.00, 0.00),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: customCardsData.length,
                itemBuilder: (context, index) {
                  final cardData = customCardsData[index];
                  return CustomCard(
                    text: cardData['text']!,
                    imageUrl: cardData['imageUrl']!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
