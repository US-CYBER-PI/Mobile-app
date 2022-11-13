import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:qiwi_mobile_app/views/pay_view.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanView extends StatefulWidget {
  const ScanView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView> {
  Barcode? result;
  QRViewController? controller;

  TextEditingController txtController = TextEditingController();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 50),
              child: Text(
                'Наветите камеру на QR код',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomLeft,
              child: CustomTextField(
                controller: txtController,
              )),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 70),
              child: RawMaterialButton(
                onPressed: () async {
                  await controller?.toggleFlash();
                  setState(() {});
                },
                elevation: 2.0,
                fillColor: Theme.of(context).colorScheme.secondary,
                padding: const EdgeInsets.all(15.0),
                shape: const CircleBorder(),
                child: const Icon(
                  (Ionicons.flashlight_outline),
                  color: Colors.white,
                  size: 35.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 300.0
        : 500.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Theme.of(context).colorScheme.secondary,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
