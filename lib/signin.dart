//signin page
// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Custom_classes/auth_service.dart';
import 'pages/home_page.dart';

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

  AuthService authService = AuthService();

  Future<void> handleLoginOrRefresh() async {
    final email = emailAddressLoginController.text;
    final password = passwordLoginController.text;

    setState(() => isLoading = true);

    await authService.logInAndGetTokens(email, password);

    if (authService.accessToken != null) {
      // Successful login or refresh, do something with the access token
      navigateToHomePage();
    } else {
      showSnackBar('Login Failed. Please check your credentials.');
    }

    setState(() => isLoading = false);
  }

  Future<void> handleLogin() async {
    await handleLoginOrRefresh();

    if (authService.accessToken != null) {
      // showSnackBar('Login Successful!');
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
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(accessToken: authService.accessToken!),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // checkExistingTokens();
    checkTokensAndNavigate();
  }

  Future<void> checkTokensAndNavigate() async {
    final accessToken =
        await authService.secureStorage.read(key: 'access_token');
    final refreshToken =
        await authService.secureStorage.read(key: 'refresh_token');

    print('Stored Access Token: $accessToken');
    print('Stored Refresh Token: $refreshToken');

    if (accessToken != null && refreshToken != null) {
      // Tokens exist, attempt to refresh and navigate to home page
      await handleLoginOrRefresh();
      print('After Refresh - Access Token: ${authService.accessToken}');
      if (authService.accessToken != null) {
        navigateToHomePage();
      } else {
        // If refresh fails, show an error and offer a login option
        showSnackBar('Token refresh failed. Please log in again.');
      }
    }
  }
  // Future<void> checkExistingTokens() async {
  //   final accessToken =
  //       await authService.secureStorage.read(key: 'access_token');
  //   final refreshToken =
  //       await authService.secureStorage.read(key: 'refresh_token');

  //   if (accessToken != null && refreshToken != null) {
  //     // Tokens exist, navigate to home page
  //     await authService.logInAndGetTokens("", "", isRefresh: true);
  //     if (authService.accessToken != null) {
  //       navigateToHomePage();
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
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
                                "Bookmie",
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
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              handleLogin();
                            },
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

class SplashAndAuthenticate extends StatefulWidget {
  const SplashAndAuthenticate({Key? key}) : super(key: key);

  @override
  _SplashAndAuthenticateState createState() => _SplashAndAuthenticateState();
}

class _SplashAndAuthenticateState extends State<SplashAndAuthenticate> {
  @override
  void initState() {
    super.initState();
    // Simulate a delay before navigating to AuthenticateSolo1Widget
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const AuthenticateSolo1Widget()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/splash_screen.jpeg'),
        ),
      ),
      // child: Scaffold(
      //   body: Center(
      //     child: Image.asset(
      //         'assets/splash_screen.jpeg'), // Replace with your splash image
      //   ),
      // ),
    );
  }
}
