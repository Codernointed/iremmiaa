import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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

  // Function to log in and obtain an access token from stack overflow
  Future<String?> logInAndGetAccessToken(String email, String password) async {
    final apiUrl = Uri.parse(
        'https://ethenatx.pythonanywhere.com/management/obtain-token/');

    try {
      final response = await http.post(apiUrl,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            // 'Accept ': 'application/json',
            // lemon@yahoo.com
            // 123
          },
          body: jsonEncode({
            'email': email,
            'password': password,
          }));

      if (response.statusCode == 200) {
        // Authentication successful jsonDecode
        final jsonResponse = json.decode(response.body) as Map<String, dynamic>;
        final accessToken = jsonResponse['access'];
        return accessToken;
      } else {
        // Authentication failed
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  // Function to handle login button press
  Future<void> handleLogin() async {
    final email = emailAddressLoginController.text;
    final password = passwordLoginController.text;

    final accessToken = await logInAndGetAccessToken(email, password);

    if (accessToken != null) {
      // Authentication successful
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login Successful!'),
        ),
      );
    } else {
      // Authentication failed
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login Failed. Please check your credentials.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        body: Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'assets/marcus-loke-WQJvWU_HZFo-unsplash.jpg',
                    )
                    // NetworkImage(
                    //   'https://images.unsplash.com/photo-1555854877-bab0e564b8d5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1469&q=80+',
                    // ),
                    ),
              ),
              child: Center(
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
                        Expanded(
                          child: DefaultTabController(
                            length: 2,
                            initialIndex: 0,
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment(0, 0),
                                  child: TabBar(
                                    indicator: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Color(
                                              0xFFF59B15), // Change tab underline color
                                          width: 3.0,
                                        ),
                                      ),
                                    ),
                                    tabs: [
                                      Tab(
                                        text: 'Sign In',
                                      ),
                                      Tab(
                                        text: 'Sign Up',
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: TabBarView(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 20.0),
                                                child: TextFormField(
                                                  controller:
                                                      emailAddressLoginController,
                                                  obscureText: false,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'Email Address',
                                                    labelStyle: TextStyle(
                                                      color: Color(0xffdedddb),
                                                      fontSize: 18,
                                                      fontFamily: 'Roboto',
                                                    ),
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0xFFF59B15),
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0xFFF59B15),
                                                      ),
                                                    ),
                                                  ),
                                                  style: const TextStyle(
                                                    color: Color(0xffdedddb),
                                                    fontSize: 18,
                                                    fontFamily:
                                                        'Helvetica Neue',
                                                  ),
                                                  maxLines: null,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 12.0),
                                                child: TextFormField(
                                                  controller:
                                                      passwordLoginController,
                                                  obscureText:
                                                      passwordLoginVisibility,
                                                  decoration: InputDecoration(
                                                    labelText: 'Password',
                                                    labelStyle: const TextStyle(
                                                      color: Color(0xffdedddb),
                                                      fontSize: 18,
                                                      fontFamily:
                                                          'Helvetica Neue',
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
                                                            ? Icons
                                                                .visibility_outlined
                                                            : Icons
                                                                .visibility_off_outlined,
                                                        size: 20,
                                                        color: const Color(
                                                            0xffdedddb),
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0xFFF59B15),
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0xFFF59B15),
                                                      ),
                                                    ),
                                                  ),
                                                  style: const TextStyle(
                                                    color: Color(0xffdedddb),
                                                    fontSize: 18,
                                                  ),
                                                  maxLines: 1,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 24.0),
                                                child: ElevatedButton(
                                                  onPressed: handleLogin,
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color(0xFFf59b15),
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
                                                padding: const EdgeInsets.only(
                                                    top: 20.0),
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
                                      Container(
                                        child: Text(
                                          "Under Development(Enoch said not yet)",
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w200,
                                            color: Color(0xFFF59B15),
                                          ),
                                        ),
                                      ), // Empty container for Sign Up tab
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
