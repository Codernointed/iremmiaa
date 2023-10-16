import 'package:flutter/material.dart';
import 'package:dio/dio.dart'; // Import Dio
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final Dio dio = Dio(); // Create a Dio instance

  Future<void> _login() async {
    final email = emailController.text;
    final password = passwordController.text;

    final apiUrl =
        'https://ethenatx.pythonanywhere.com/management/obtain-token/';

    try {
      final response = await dio.post(apiUrl, data: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.data);
        final accessToken = jsonResponse['access'];

        // TODO: Save the accessToken. You can use a state management solution like Provider or Bloc for this.

        // Navigate to the next screen on success
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                SuccessScreen(), // Replace SuccessScreen with your next screen
          ),
        );
      } else {
        // Authentication failed
        final jsonResponse = json.decode(response.data);
        final errorMessage = jsonResponse['message'];

        // Show an error Snackbar to the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage), // Display the error message
            backgroundColor: Colors.red, // Customize the Snackbar color
          ),
        );
      }
    } catch (e) {
      // Handle any errors that occurred during the request
      print('Error: $e');

      // Show an error Snackbar to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'An error occurred. Please try again later.'), // Display a generic error message
          backgroundColor: Colors.red, // Customize the Snackbar color
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class SuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Success'),
      ),
      body: Center(
        child: Text('Login Successful!'), // You can customize this screen
      ),
    );
  }
}
