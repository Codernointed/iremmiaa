import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VerifyTenantsPage extends StatefulWidget {
  final String accessToken;

  VerifyTenantsPage({required this.accessToken});

  @override
  _VerifyTenantsPageState createState() => _VerifyTenantsPageState();
}

class _VerifyTenantsPageState extends State<VerifyTenantsPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool isScanning = true;
  bool isLoading = false;
  String scanMessage = "Scan the QR code to verify the tenant.";

  @override
  void reassemble() {
    super.reassemble();
    if (controller != null) {
      controller!.toggleFlash();
    }
  }

  void onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      final decodedQRCode = scanData.code; // Extract the text from Barcode
      setState(() {
        isLoading = true;
        scanMessage = "Verifying...";
      });

      // When a QR code is scanned, process it
      await verifyTenant(decodedQRCode);
    });
  }

  Future<void> verifyTenant(String? decodedQRCode) async {
    try {
      final response = await http.post(
        Uri.parse(
            'https://ethenatx.pythonanywhere.com/management/verify-tenant/'),
        headers: {
          'Authorization': 'Bearer ${widget.accessToken}',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'verification_code': decodedQRCode,
        }),
      );
      print(decodedQRCode);
      if (response.statusCode == 200) {
        print(response);
        print(response.body);
        print(response.statusCode);
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
        print("An error occurred :");
        print(response);
        print(response.body);
        print(response.statusCode);
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
          Expanded(
            child: QRView(
              key: qrKey,
              onQRViewCreated: onQRViewCreated,
            ),
          ),
          SizedBox(height: 10),
          Text(
            scanMessage,
            style: TextStyle(fontSize: 18),
          ),
          if (isLoading) CircularProgressIndicator(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
