// // ignore_for_file: library_private_types_in_public_api

// import 'package:flutter/material.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class VerifyTenantsPage extends StatefulWidget {
//   final String accessToken;

//   const VerifyTenantsPage({super.key, required this.accessToken});

//   @override
//   _VerifyTenantsPageState createState() => _VerifyTenantsPageState();
// }

// class _VerifyTenantsPageState extends State<VerifyTenantsPage> {
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   QRViewController? controller;
//   String? result = "";

//   @override
//   void reassemble() {
//     super.reassemble();
//     if (controller != null) {
//       controller!.resumeCamera();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         shadowColor: Colors.white,
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Color(0xFFF59B15)),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         title: const Text(
//           'Scan QR',
//           style: TextStyle(
//             fontWeight: FontWeight.w600,
//             color: Color(0xFFF59B15),
//             fontSize: 20,
//           ),
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
//             child: IconButton(
//               icon: const Icon(Icons.flash_on,
//                   color: Color(0xFFF59B15), size: 30),
//               onPressed: () {
//                 // Add an action to navigate to the profile page here.
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
//             child: IconButton(
//               icon: const Icon(Icons.switch_camera,
//                   color: Color(0xFFF59B15), size: 30),
//               onPressed: () {
//                 // Add an action to navigate to the profile page here.
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
//             child: IconButton(
//               icon: const Icon(Icons.account_circle,
//                   color: Color(0xFFF59B15), size: 35),
//               onPressed: () {
//                 // Add an action to navigate to the profile page here.
//               },
//             ),
//           ),
//         ],
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             flex: 5,
//             child: QRView(
//               key: qrKey,
//               onQRViewCreated: _onQRViewCreated,
//               overlay: QrScannerOverlayShape(
//                 borderWidth: 20,
//                 borderLength: 40,
//                 borderRadius: 20,
//                 cutOutSize: MediaQuery.of(context).size.width,
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Center(
//               child: Text(
//                 'Result: \n $result',
//                 style: TextStyle(fontSize: 16),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }

//   void _onQRViewCreated(QRViewController controller) {
//     this.controller = controller;
//     controller.scannedDataStream.listen((scanData) {
//       setState(() {
//         result = scanData.code;
//       });
//       verifyTenant(scanData.code);
//     });
//   }

//   Future<void> verifyTenant(String? qrCode) async {
//     if (qrCode == null) {
//       // Handle the case where the QR code is null (e.g., user canceled the scan).
//       return;
//     }

//     final apiUrl = Uri.parse(
//         'https://ethenatx.pythonanywhere.com/management/verify-tenant/');
//     final response = await http.post(
//       apiUrl,
//       headers: {
//         'Authorization': 'Bearer ${widget.accessToken}',
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode({'verification_code': qrCode}),
//     );

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       if (data['Verified'] == 'Verified') {
//         // Tenant is verified
//         showDialog(
//           context: context,
//           builder: (context) {
//             return AlertDialog(
//               title: Text('Verification Successful'),
//               content: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Student: ${data['Student']}'),
//                   Text('Room Number: ${data['Room Number']}'),
//                   Text('Hostel: ${data['Hostel']}'),
//                 ],
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Text('Close'),
//                 ),
//               ],
//             );
//           },
//         );
//       } else {
//         // Tenant is not verified
//         showDialog(
//           context: context,
//           builder: (context) {
//             return AlertDialog(
//               title: Text('Verification Failed'),
//               content: Text('Tenant is not verified or has not paid.'),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Text('Close'),
//                 ),
//               ],
//             );
//           },
//         );
//       }
//     } else {
//       // Handle errors
//       showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Text('Error'),
//             content: Text('Failed to verify tenant. Please try again.'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('Close'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class VerifyTenantsPage extends StatefulWidget {
//   final String accessToken;

//   VerifyTenantsPage({required this.accessToken});

//   @override
//   _VerifyTenantsPageState createState() => _VerifyTenantsPageState();
// }

// class _VerifyTenantsPageState extends State<VerifyTenantsPage> {
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   QRViewController? controller;
//   bool isScanning = true;
//   bool isLoading = false;
//   String scanMessage = "Scan the QR code to verify the tenant.";

//   @override
//   void reassemble() {
//     super.reassemble();
//     if (controller != null) {
//       controller!.toggleFlash();
//     }
//   }

//   void onQRViewCreated(QRViewController controller) {
//     setState(() {
//       this.controller = controller;
//     });
//     controller.scannedDataStream.listen((scanData) async {
//       final decodedQRCode = scanData.code; // Extract the text from Barcode
//       setState(() {
//         isLoading = true;
//         scanMessage = "Verifying...";
//       });

//       // When a QR code is scanned, process it
//       await verifyTenant(decodedQRCode);
//     });
//   }

//   Future<void> verifyTenant(String? decodedQRCode) async {
//     try {
//       final response = await http.post(
//         Uri.parse(
//             'https://ethenatx.pythonanywhere.com/management/verify-tenant/'),
//         headers: {
//           'Authorization': 'Bearer ${widget.accessToken}',
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode({
//           'verification_code': decodedQRCode,
//         }),
//       );
//       print(decodedQRCode);
//       if (response.statusCode == 200) {
//         print(response);
//         print(response.body);
//         print(response.statusCode);
//         final responseData = json.decode(response.body);
//         if (responseData.containsKey('Student') &&
//             responseData.containsKey('Verified')) {
//           // Tenant is verified
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
//                     Text('Student: ${responseData['Student']}'),
//                     Text('Room Number: ${responseData['Room Number']}'),
//                     Text('Hostel: ${responseData['Hostel']}'),
//                     Text('Verification Status: ${responseData['Verified']}'),
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
//           // Tenant is not verified or has not paid
//           setState(() {
//             isLoading = false;
//             scanMessage = "Tenant is not verified or has not paid.";
//           });
//         }
//       } else {
//         print("An error occurred :");
//         print(response);
//         print(response.body);
//         print(response.statusCode);
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
//         scanMessage = "An error occurred. Please try again later.";
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
//           Expanded(
//             child: QRView(
//               key: qrKey,
//               onQRViewCreated: onQRViewCreated,
//             ),
//           ),
//           SizedBox(height: 10),
//           Text(
//             scanMessage,
//             style: TextStyle(fontSize: 18),
//           ),
//           if (isLoading) CircularProgressIndicator(),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
// }

import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=900&q=60',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                'Hostel Name',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 30,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                'Username',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                'Email',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey,
              ),
              child: ListTile(
                title: Text('Switch to Dark Mode'),
                trailing: Icon(Icons.nights_stay, color: Colors.grey),
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey,
              ),
              child: ListTile(
                title: Text('Edit Profile'),
                trailing: Icon(Icons.chevron_right_rounded),
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey,
              ),
              child: ListTile(
                title: Text('Scanned history'),
                trailing: Icon(Icons.chevron_right_rounded),
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey,
              ),
              child: ListTile(
                title: Text('Statistics'),
                trailing: Icon(Icons.bar_chart),
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey,
              ),
              child: ListTile(
                title: Text('Logout'),
                trailing: Icon(Icons.logout),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
