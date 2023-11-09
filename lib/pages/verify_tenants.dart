// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class VerifyTenantsPage extends StatefulWidget {
//   final String accessToken;

//   VerifyTenantsPage({required this.accessToken});

//   @override
//   _VerifyTenantsPageState createState() => _VerifyTenantsPageState();
// }

// class _VerifyTenantsPageState extends State<VerifyTenantsPage> {
//   bool isLoading = false;
//   String scanMessage = "Scan the QR code to verify the tenant.";

//   Future<void> sendHardcodedVerificationCode() async {
//     setState(() {
//       isLoading = true;
//       scanMessage = "Verifying...";
//     });

//     try {
//       final response = await http.post(
//         Uri.parse(
//             'https://ethenatx.pythonanywhere.com/management/verify-tenant/'),
//         headers: {
//           'Authorization': 'Bearer ${widget.accessToken}',
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode({
//           'verification_code':
//               "EVAdc0a-05r0-En-011b0-lem-82dc4dbf-4fd5-42e9-8f4b-41188c18234f-enoch-20951781-072024k0-lemon-15:34:33.411574-Grj",
//         }),
//       );

//       if (response.statusCode == 200) {
//         final responseData = json.decode(response.body);
//         if (responseData.containsKey('tenant_name') &&
//             responseData.containsKey('student_id')) {
//           print("it coming:");
//           print(responseData["message"]);
//           print(responseData);
//           print(response.statusCode);
//           print(response.body);
//           // Display the student's information
//           setState(() {
//             isLoading = false;
//             scanMessage = "Scan the QR code to verify the tenant.";
//           });

//           showDialog(
//             context: context,
//             builder: (context) {
//               return AlertDialog(
//                 title: Text('Verification Successful'),
//                 content: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text('Student: ${responseData['hostel_name']}'),
//                     Text('Room Number: ${responseData['room_number']}'),
//                     // Text('Hostel: ${responseData['Hostel']}'),
//                     // Text('Verification Status: ${responseData['Verified']}'),
//                   ],
//                 ),
//                 actions: [
//                   TextButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: Text('OK'),
//                   ),
//                 ],
//               );
//             },
//           );
//         } else {
//           print("Is it coming:");
//           print(responseData["message"]);
//           print(responseData);
//           print(response.statusCode);
//           print(response.body);
//           // Tenant is not verified or has not paid
//           setState(() {
//             isLoading = false;
//             scanMessage = "Tenant is not verified or has not paid.";
//           });
//         }
//       } else {
//         final responseData = json.decode(response.body);

//         print("An error occurred:");
//         print(responseData["message"]);
//         print(responseData);
//         print(response.statusCode);
//         print(response.body);
//         // Handle other response codes or errors
//         setState(() {
//           isLoading = false;
//           scanMessage = "An error occurred. Please try again later.";
//         });
//       }
//     } catch (e) {
//       // Handle network or other errors
//       print('Error: $e');
//       setState(() {
//         isLoading = false;
//         scanMessage = "A Network error occurred. Please try again later.";
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Verify Tenants'),
//       ),
//       body: Column(
//         children: <Widget>[
//           SizedBox(height: 10),
//           Text(
//             scanMessage,
//             style: TextStyle(fontSize: 18),
//           ),
//           if (isLoading) CircularProgressIndicator(),
//           ElevatedButton(
//             onPressed: sendHardcodedVerificationCode,
//             child: Text('Verify Hardcoded Code'),
//           ),
//         ],
//       ),
//     );
//   }
// }

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VerifyTenantsPage extends StatefulWidget {
  final String accessToken;

  const VerifyTenantsPage({super.key, required this.accessToken});

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
                // Add an action to navigate to the profile page here.
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
              // overlay: QrScannerOverlayShape(
              //   borderWidth: 20,
              //   borderLength: 40,
              //   borderRadius: 20,
              //   cutOutSize: MediaQuery.of(context).size.width,
              // ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                'Result: \n $result',
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
      // if (data['Verified'] == 'Verified') {
      // Tenant is verified
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Verification Successful'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
      // }
      //  else {
      //   // Tenant is not verified
      //   showDialog(
      //     context: context,
      //     builder: (context) {
      //       return AlertDialog(
      //         title: Text('Verification Failed'),
      //         content: Text('Tenant is not verified or has not paid.'),
      //         actions: [
      //           TextButton(
      //             onPressed: () {
      //               Navigator.of(context).pop();
      //             },
      //             child: Text('Close'),
      //           ),
      //         ],
      //       );
      //     },
      //   );
      // }
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
