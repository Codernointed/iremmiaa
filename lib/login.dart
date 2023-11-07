import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  late QRViewController _controller;
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  String _scannedData = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Scanner'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: QRView(
              key: _qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Scanned Data:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            _scannedData,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      _controller = controller;
      _controller.scannedDataStream.listen((scanData) {
        setState(() {
          _scannedData = scanData.code ?? '';
        });

        // Perform validation or further processing of the scanned data
        if (_scannedData.isNotEmpty) {
          // Perform your validation logic here
          if (_isValidQRCode(_scannedData)) {
            // QR code is valid, perform further actions
            // e.g., navigate to a different screen, update UI, etc.
          } else {
            // Invalid QR code, show an error message or perform appropriate actions
          }
        }
      });
    });
  }

  bool _isValidQRCode(String scannedData) {
    // Implement your custom validation logic here
    // Return true if the QR code is valid, otherwise return false
    // You can check the scannedData against a specific format or perform any other checks
    // For example, check if the scanned data matches a certain pattern or if it exists in a database
    return true; // Replace with your validation logic
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
