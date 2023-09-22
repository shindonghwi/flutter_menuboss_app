import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:menuboss/domain/usecases/remote/device/PostDeviceUseCase.dart';
import 'package:menuboss/presentation/components/appbar/TopBarNoneTitleIcon.dart';
import 'package:menuboss/presentation/components/bottom_sheet/BottomSheetPinCode.dart';
import 'package:menuboss/presentation/components/bottom_sheet/CommonBottomSheet.dart';
import 'package:menuboss/presentation/components/button/NeutralFilledButton.dart';
import 'package:menuboss/presentation/components/toast/Toast.dart';
import 'package:menuboss/presentation/components/utils/BaseScaffold.dart';
import 'package:menuboss/presentation/utils/Common.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQrScreen extends StatelessWidget {
  const ScanQrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: const QrCodeScanner(),
    );
  }
}

class QrCodeScanner extends StatefulWidget {
  const QrCodeScanner({super.key});

  @override
  State<QrCodeScanner> createState() => _QrCodeScannerState();
}

class _QrCodeScannerState extends State<QrCodeScanner> {
  var isProcessing = false;
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
    return Stack(
      children: [
        QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
        ),
        Align(
          alignment: Alignment.topCenter,
          child: TopBarNoneTitleIcon(
            content: getAppLocalizations(context).scan_qr_title,
            backgroundColor: Colors.transparent,
            reverseContentColor: true,
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/imgs/image_qr_guideline.png",
                width: 180,
                height: 180,
              ),
              const SizedBox(height: 32),
              NeutralFilledButton.mediumRound100(
                content: getAppLocalizations(context).scan_qr_enter_pin_code,
                isActivated: true,
                onPressed: () {
                  CommonBottomSheet.showBottomSheet(
                    context,
                    child: BottomSheetPinCode(
                      onConfirmed: (code) {
                        postDevice(code, isDelayed: false);
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ],
    );
  }

  void postDevice(String code, {isDelayed = true}) {
    isProcessing = true;
    GetIt.instance<PostDeviceUseCase>().call(code).then((response) async {
      if (response.status == 200) {
        Navigator.of(context).pop(true);
      } else {
        Toast.showError(context, response.message ?? "");
        await Future.delayed(const Duration(seconds: 2));
        isProcessing = false;
      }
    });
  }

  void _onQRViewCreated(QRViewController controller) async {
    const scheme = "https://dev-internal.themenuboss.com/qrcode/";

    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      setState(() {
        result = scanData;

        if (isProcessing) return;

        if (result!.code.toString().startsWith(scheme) && !isProcessing) {
          final code = result!.code.toString().replaceAll(scheme, "");
          postDevice(code);
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
