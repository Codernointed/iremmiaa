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
import 'package:http/http.dart' as http;
import 'package:rebook/home_page.dart';
import 'dart:convert';

class AuthenticateSolo1Widget extends StatefulWidget {
  const AuthenticateSolo1Widget({Key? key}) : super(key: key);

  @override
  _AuthenticateSolo1WidgetState createState() =>
      _AuthenticateSolo1WidgetState();
}

class _AuthenticateSolo1WidgetState extends State<AuthenticateSolo1Widget>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final emailAddressLoginController = TextEditingController();
  final passwordLoginController = TextEditingController();
  bool passwordLoginVisibility = true;

  bool loading = false; // Added loading state

  // Function to log in and obtain an access token
  Future<String?> logInAndGetAccessToken(String email, String password) async {
    final apiUrl = Uri.parse(
        'https://ethenatx.pythonanywhere.com/management/obtain-token/');

    try {
      final response = await http.post(apiUrl,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            'email': email,
            'password': password,
          }));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body) as Map<String, dynamic>;
        final accessToken = jsonResponse['access'];
        return accessToken;
      } else {
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  // Function to handle login button press
  Future<void> handleLogin() async {
    setState(() {
      loading = true;
    });

    final email = emailAddressLoginController.text;
    final password = passwordLoginController.text;

    final accessToken = await logInAndGetAccessToken(email, password);

    if (accessToken != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login Successful!'),
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(accessToken: accessToken),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login Failed. Please check your credentials.'),
        ),
      );
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        body: Builder(
          builder: (BuildContext context) {
            return SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                        'assets/marcus-loke-WQJvWU_HZFo-unsplash.jpg'),
                  ),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        width: 290,
                        height: 420,
                        decoration: BoxDecoration(
                          color: const Color(0x99000000),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Guudnyt",
                                      style: TextStyle(
                                        fontSize: 38,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFFF59B15),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: TextFormField(
                                  controller: emailAddressLoginController,
                                  obscureText: false,
                                  decoration: const InputDecoration(
                                    labelText: 'Email Address',
                                    labelStyle: TextStyle(
                                      color: Color(0xffdedddb),
                                      fontSize: 18,
                                      fontFamily: 'Roboto',
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFF59B15),
                                      ),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFF59B15),
                                      ),
                                    ),
                                  ),
                                  style: const TextStyle(
                                    color: Color(0xffdedddb),
                                    fontSize: 18,
                                    fontFamily: 'Helvetica Neue',
                                  ),
                                  maxLines: null,
                                  cursorColor: Color(0xFFF59B15),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: TextFormField(
                                  controller: passwordLoginController,
                                  obscureText: passwordLoginVisibility,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    labelStyle: const TextStyle(
                                      color: Color(0xffdedddb),
                                      fontSize: 18,
                                      fontFamily: 'Helvetica Neue',
                                    ),
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        setState(() {
                                          passwordLoginVisibility =
                                              !passwordLoginVisibility;
                                        });
                                      },
                                      child: Icon(
                                        passwordLoginVisibility
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        size: 20,
                                        color: const Color(0xffdedddb),
                                      ),
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFF59B15),
                                      ),
                                    ),
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFF59B15),
                                      ),
                                    ),
                                  ),
                                  style: const TextStyle(
                                    color: Color(0xffdedddb),
                                    fontSize: 18,
                                  ),
                                  maxLines: 1,
                                  cursorColor: Color(0xFFF59B15),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 24.0),
                                child: ElevatedButton(
                                  onPressed: handleLogin,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFf59b15),
                                  ),
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: TextButton(
                                  onPressed: () {
                                    // Navigate to forgot password screen
                                  },
                                  child: const Text(
                                    'Forgot Password?',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (loading)
                      Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(0xFFF59B15)),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:rebook/Custom_classes/custom_card.dart';

// class HomePage extends StatelessWidget {
//   final String accessToken;

//   HomePage({required this.accessToken});

//   // Define card data for the custom cards
//   final List<Map<String, String>> customCardsData = [
//     {
//       'text': 'Update Room Prices',
//       'imageUrl':
//           'https://images.unsplash.com/photo-1515548212260-ac87067b15ab?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwzfHxwcmljZXN8ZW58MHx8fHwxNjk3NTEwNjA2fDA&ixlib=rb-4.0.3&q=80&w=1080',
//     },
//     {
//       'text': 'Update Rooms',
//       'imageUrl':
//           'https://images.unsplash.com/photo-1515548212260-ac87067b15ab?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&HwxfHNlYXJjaHwzfHxwcmljZXN8ZW58MHx8fHwxNjk3NTEwNjA2fDA&ixlib=rb-4.0.3&q=80&w=1080',
//     },
//     {
//       'text': 'View Rooms',
//       'imageUrl':
//           'https://images.unsplash.com/photo-1515548212260-ac87067b15ab?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&HwxfHNlYXJjaHwzfHxwcmljZXN8ZW58MHx8fHwxNjk3NTEwNjA2fDA&ixlib=rb-4.0.3&q=80&w=1080',
//     },
//     {
//       'text': 'View Rooms',
//       'imageUrl':
//           'https://images.unsplash.com/photo-1515548212260-ac87067b15ab?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&HwxfHNlYXJjaHwzfHxwcmljZXN8ZW58MHx8fHwxNjk3NTEwNjA2fDA&ixlib=rb-4.0.3&q=80&w=1080',
//     },
//   ];

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
//               child: ListView.builder(
//                 padding: EdgeInsets.zero,
//                 shrinkWrap: true,
//                 scrollDirection: Axis.vertical,
//                 itemCount: customCardsData.length,
//                 itemBuilder: (context, index) {
//                   final cardData = customCardsData[index];
//                   return CustomCard(
//                     text: cardData['text']!,
//                     imageUrl: cardData['imageUrl']!,
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
