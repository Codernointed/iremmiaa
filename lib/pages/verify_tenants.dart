// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:rebook/profile_page.dart';

class VerifyTenantsPage extends StatefulWidget {
  final String accessToken;

  const VerifyTenantsPage({super.key, required this.accessToken});

  @override
  _VerifyTenantsPageState createState() => _VerifyTenantsPageState();
}

class _VerifyTenantsPageState extends State<VerifyTenantsPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String? result;
  bool isVerificationDialogShown = false;

  @override
  void reassemble() {
    super.reassemble();
    if (controller != null) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.white,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFF59B15)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Scan QR',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFFF59B15),
            fontSize: 20,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: IconButton(
              icon: const Icon(Icons.flash_on,
                  color: Color(0xFFF59B15), size: 30),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: IconButton(
              icon: const Icon(Icons.switch_camera,
                  color: Color(0xFFF59B15), size: 30),
              onPressed: () {
                // Add an action to navigate to the profile page here.
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: IconButton(
              icon: const Icon(Icons.account_circle,
                  color: Color(0xFFF59B15), size: 35),
              onPressed: () {
                // Add an action to navigate to the profile page here.
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
                child: isVerificationDialogShown
                    ? const CircularProgressIndicator()
                    : const Text(
                        "Move camera to scan and verify tenant",
                        style: TextStyle(fontSize: 16),
                      )
                // : Text(
                //     'Result: \n $result',
                //     style: TextStyle(fontSize: 16),
                //   ),
                ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (!isVerificationDialogShown) {
        setState(() {
          result = scanData.code;
          isVerificationDialogShown = true;
        });
        verifyTenant(scanData.code);
      }
    });
  }

  Future<void> verifyTenant(String? qrCode) async {
    if (qrCode == null) {
      // Handle the case where the QR code is null (e.g., user canceled the scan).
      return;
    }

    final apiUrl = Uri.parse(
        'https://ethenatx.pythonanywhere.com/management/verify-tenant/');
    final response = await http.post(
      apiUrl,
      headers: {
        'Authorization': 'Bearer ${widget.accessToken}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'verification_code': qrCode}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Verification Successful'),
            content: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/success.gif',
                  width: 40,
                  height: 40,
                ),
                Text('Hostel: ${data['hostel_name']}'),
                Text('Room Number: ${data['room_number']}'),
                Text('Name: ${data['tenant_name']}'),
                Text('ID: ${data['student_id']}'),
                Text('Stat: ${data['checked_in_status']}'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    isVerificationDialogShown = false;
                  });
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    } else {
      // Handle errors
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Failed to verify tenant. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    isVerificationDialogShown = false;
                  });
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    }
  }
}
