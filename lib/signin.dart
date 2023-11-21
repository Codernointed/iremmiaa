// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:rebook/pages/home_page.dart';

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
  bool isLoading = false;

  String? accessToken;
  String? refreshToken;

  Future<void> logInAndGetTokens(String email, String password,
      {bool isRefresh = false}) async {
    final apiUrl = Uri.parse(
        'https://ethenatx.pythonanywhere.com/management/obtain-token/');

    try {
      final response = await http.post(
        apiUrl,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(
          isRefresh
              ? {'refresh': refreshToken}
              : {'email': email, 'password': password},
        ),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body) as Map<String, dynamic>;
        accessToken = jsonResponse['access'];
        if (!isRefresh) {
          refreshToken = jsonResponse['refresh'];
        }
      } else {
        accessToken = null;
        refreshToken = null;
      }
    } catch (e) {
      accessToken = null;
      refreshToken = null;
    }
  }

  Future<void> handleLoginOrRefresh() async {
    final email = emailAddressLoginController.text;
    final password = passwordLoginController.text;

    setState(() => isLoading = true);

    await logInAndGetTokens(email, password);

    if (accessToken != null) {
      // Successful login, do something with the access token
    } else {
      showSnackBar('Login Failed. Please check your credentials.');
    }

    setState(() => isLoading = false);
  }

  Future<void> handleLogin() async {
    await handleLoginOrRefresh();

    if (accessToken != null) {
      showSnackBar('Login Successful!');
      navigateToHomePage();
    } else {
      showSnackBar('Login Failed. Please check your credentials.');
    }
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void navigateToHomePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => HomePage(accessToken: accessToken!)),
    );
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
                  image:
                      AssetImage('assets/marcus-loke-WQJvWU_HZFo-unsplash.jpg'),
                ),
              ),
              child: Center(
                child: Container(
                  width: 290,
                  height: 460,
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
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(50),
                            ],
                            decoration: const InputDecoration(
                              labelText: 'Email Address',
                              labelStyle: TextStyle(
                                color: Color(0xffdedddb),
                                fontSize: 18,
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
                            ),
                            maxLines: null,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: TextFormField(
                            controller: passwordLoginController,
                            obscureText: passwordLoginVisibility,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(50),
                            ],
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: const TextStyle(
                                color: Color(0xffdedddb),
                                fontSize: 18,
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
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 24.0),
                          child: ElevatedButton(
                            onPressed: handleLogin,
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(230, 30),
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
                              // Navigate to the forgot password screen
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
                        if (isLoading)
                          const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFFF59B15),
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
