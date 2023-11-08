import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VerifyTenantsPage extends StatefulWidget {
  final String accessToken;

  VerifyTenantsPage({required this.accessToken});

  @override
  _VerifyTenantsPageState createState() => _VerifyTenantsPageState();
}

class _VerifyTenantsPageState extends State<VerifyTenantsPage> {
  bool isLoading = false;
  String scanMessage = "Scan the QR code to verify the tenant.";

  Future<void> sendHardcodedVerificationCode() async {
    setState(() {
      isLoading = true;
      scanMessage = "Verifying...";
    });

    try {
      const verificationCode =
          "ST.7dc0-05r0-En-011b0-Kor-6c1c5909-8a73-463f- be90-07d2d838a0fc-enoch-2038383-072024k0- korley-19:42:56.679167-Grj";

      final response = await http.post(
        Uri.parse(
            'https://ethenatx.pythonanywhere.com/management/verify-tenant/'),
        headers: {
          'Authorization': 'Bearer ${widget.accessToken}',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'verification_code': verificationCode,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData.containsKey('Student') &&
            responseData.containsKey('Verified')) {
          // Tenant is verified
          // Display the student's information
          setState(() {
            isLoading = false;
            scanMessage = "Scan the QR code to verify the tenant.";
          });

          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Verification Successful'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Student: ${responseData['Student']}'),
                    Text('Room Number: ${responseData['Room Number']}'),
                    Text('Hostel: ${responseData['Hostel']}'),
                    Text('Verification Status: ${responseData['Verified']}'),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          // Tenant is not verified or has not paid
          setState(() {
            isLoading = false;
            scanMessage = "Tenant is not verified or has not paid.";
          });
        }
      } else {
        final responseData = json.decode(response.body);

        print("An error occurred:");
        print(responseData["message"]);
        print(responseData);
        print(response.statusCode);
        print(response.body);
        // Handle other response codes or errors
        setState(() {
          isLoading = false;
          scanMessage = "An error occurred. Please try again later.";
        });
      }
    } catch (e) {
      // Handle network or other errors
      print('Error: $e');
      setState(() {
        isLoading = false;
        scanMessage = "An error occurred. Please try again later.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Tenants'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 10),
          Text(
            scanMessage,
            style: TextStyle(fontSize: 18),
          ),
          if (isLoading) CircularProgressIndicator(),
          ElevatedButton(
            onPressed: sendHardcodedVerificationCode,
            child: Text('Verify Hardcoded Code'),
          ),
        ],
      ),
    );
  }
}
