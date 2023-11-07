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
  String? result = "";

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
        title: Text('Verify Tenants'),
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
              child: Text(
                'Result: $result',
                style: TextStyle(fontSize: 16),
              ),
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
      setState(() {
        result = scanData.code;
      });
      verifyTenant(scanData.code);
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
      if (data['Verified'] == 'Verified') {
        // Tenant is verified
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Verification Successful'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Student: ${data['Student']}'),
                  Text('Room Number: ${data['Room Number']}'),
                  Text('Hostel: ${data['Hostel']}'),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
              ],
            );
          },
        );
      } else {
        // Tenant is not verified
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Verification Failed'),
              content: Text('Tenant is not verified or has not paid.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
              ],
            );
          },
        );
      }
    } else {
      // Handle errors
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to verify tenant. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    }
  }
}
