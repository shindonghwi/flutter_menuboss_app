import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:menuboss/domain/usecases/remote/device/PostDeviceUseCase.dart';
import 'package:menuboss/presentation/components/appbar/TopBarNoneTitleIcon.dart';
import 'package:menuboss/presentation/components/toast/Toast.dart';
import 'package:menuboss/presentation/components/utils/BaseScaffold.dart';
import 'package:menuboss/presentation/utils/Common.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQrScreen extends StatelessWidget {
  const ScanQrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const QrCodeScanner();
  }
}

class QrCodeScanner extends StatefulWidget {
  const QrCodeScanner({super.key});

  @override
  State<QrCodeScanner> createState() => _QrCodeScannerState();
}

class _QrCodeScannerState extends State<QrCodeScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Column(
        children: [
          TopBarNoneTitleIcon(
            content: getAppLocalizations(context).add_tv_appbar_title,
            backgroundColor: Colors.transparent,
          ),
          Expanded(
            child: Stack(
              children: [
                QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/imgs/image_qr_guideline.png",
                    width: 180,
                    height: 180,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) async {
    var isProcessing = false;
    const scheme = "https://dev-internal.themenuboss.com/qrcode/";

    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      setState(() {
        result = scanData;

        if (isProcessing) return;

        if (result!.code.toString().startsWith(scheme) && !isProcessing) {
          isProcessing = true;

          final code = result!.code.toString().replaceAll(scheme, "");

          GetIt.instance<PostDeviceUseCase>().call(code).then((response) async {
            if (response.status == 200) {
              Navigator.of(context).pop(true);
            } else {
              ToastUtil.errorToast(response.message ?? "");
              await Future.delayed(const Duration(seconds: 2));
              isProcessing = false;
            }
          });
        }
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
