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
import 'package:menuboss/presentation/ui/colors.dart';
import 'package:menuboss/presentation/ui/typography.dart';
import 'package:menuboss/presentation/utils/Common.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQrScreen extends StatelessWidget {
  const ScanQrScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const BaseScaffold(
      body: QrCodeScanner(),
    );
  }
}

class QrCodeScanner extends StatefulWidget {
  const QrCodeScanner({Key? key}) : super(key: key);

  @override
  State<QrCodeScanner> createState() => _QrCodeScannerState();
}

class _QrCodeScannerState extends State<QrCodeScanner> {
  final columnKey = GlobalKey();
  Offset? columnPosition;

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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox? columnRenderBox = columnKey.currentContext?.findRenderObject() as RenderBox?;
      final position = columnRenderBox?.localToGlobal(Offset.zero);
      setState(() {
        columnPosition = position;
        debugPrint("columnPosition: $columnPosition");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    const imageSize = 180.0;
    const textHeight = 36;
    const verticalPadding = 32;

    return Stack(
      children: [
        QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
        ),
        if (columnPosition != null)
          CustomPaint(
            size: getMediaQuery(context).size,
            painter: HolePainter(
              holeWidth: imageSize,
              holeHeight: imageSize,
              holeOffset: Offset(
                  (getMediaQuery(context).size.width - imageSize) / 2,
                  (getMediaQuery(context).size.height / 2) -
                      (imageSize / 2) -
                      (textHeight - verticalPadding) / 2 // Adjusting for the text and padding
                  ),
              borderRadius: 20,
            ),
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
            key: columnKey,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                getAppLocalizations(context).scan_qr_description,
                style: getTextTheme(context).b2sb.copyWith(
                      color: getColorScheme(context).white,
                    ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0),
                child: Image.asset(
                  "assets/imgs/image_qr_guideline.png",
                  width: imageSize,
                  height: imageSize,
                ),
              ),
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
        Toast.showSuccess(context, getAppLocalizations(context).message_register_screen_success);
        Navigator.of(context).pop(true);
      } else {
        Toast.showError(context, response.message);
        await Future.delayed(const Duration(seconds: 2));
        isProcessing = false;
      }
    });
  }

  void _onQRViewCreated(QRViewController controller) async {
    const scheme = "menuboss.onelink.me";

    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      setState(() {
        result = scanData;

        if (isProcessing) return;

        if (result!.code.toString().contains(scheme) && result!.code.toString().contains("?pin=") && !isProcessing) {
          final code = result!.code.toString().split("?pin=").last;
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

class HolePainter extends CustomPainter {
  final double holeWidth;
  final double holeHeight;
  final Offset holeOffset;
  final double borderRadius;

  HolePainter({
    required this.holeWidth,
    required this.holeHeight,
    required this.holeOffset,
    this.borderRadius = 20.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black.withOpacity(0.5);

    final outerPath = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    final innerRRect = RRect.fromRectAndRadius(
      holeOffset & Size(holeWidth, holeHeight),
      Radius.circular(borderRadius),
    );

    final innerPath = Path()..addRRect(innerRRect);

    final combinedPath = Path.combine(PathOperation.difference, outerPath, innerPath);

    canvas.drawPath(combinedPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
