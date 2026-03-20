import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanQRScreen extends StatelessWidget {
  const ScanQRScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Escanear QR")),
      body: MobileScanner(
        onDetect: (BarcodeCapture capture) {
          final String? code = capture.barcodes.first.rawValue;

          if (code != null) {
            Navigator.pop(context, code);
          }
        },
      ),
    );
  }
}
