import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:menuboss/domain/usecases/remote/device/PostDeviceUseCase.dart';
import 'package:menuboss/navigation/PageMoveUtil.dart';
import 'package:menuboss_common/components/appbar/TopBarNoneTitleIcon.dart';
import 'package:menuboss_common/components/bottom_sheet/BottomSheetPinCode.dart';
import 'package:menuboss_common/components/bottom_sheet/CommonBottomSheet.dart';
import 'package:menuboss_common/components/button/NeutralFilledButton.dart';
import 'package:menuboss_common/components/loader/LoadSvg.dart';
import 'package:menuboss_common/components/toast/Toast.dart';
import 'package:menuboss_common/components/utils/BaseScaffold.dart';
import 'package:menuboss_common/ui/colors.dart';
import 'package:menuboss_common/ui/Strings.dart';
import 'package:menuboss_common/ui/typography.dart';
import 'package:menuboss_common/utils/Common.dart';
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

    return Stack(
      children: [
        QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
        ),
        if (columnPosition != null)
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomPaint(
              size: getMediaQuery(context).size,
              painter: HolePainter(
                holeWidth: imageSize,
                holeHeight: imageSize,
                holeOffset: Offset(
                  (getMediaQuery(context).size.width - imageSize) / 2, // Center horizontally
                  (getMediaQuery(context).size.height - imageSize) / 2, // Center vertically
                ),
                borderRadius: 20,
              ),
            ),
          ),
        const Center(
          child: LoadSvg(
            path: "assets/imgs/image_qr_guideline.svg",
            width: imageSize,
            height: imageSize,
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: TopBarNoneTitleIcon(
            content: Strings.of(context).scanQrTitle,
            backgroundColor: Colors.transparent,
            reverseContentColor: true,
            onBack: () => popPageWrapper(context: context),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Column(
            key: columnKey,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Strings.of(context).scanQrDescription,
                style: getTextTheme(context).b2m.copyWith(
                      color: getColorScheme(context).white,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 244,
              ),
              NeutralFilledButton.mediumRound100(
                content: Strings.of(context).scanQrEnterPinCode,
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
        Toast.showSuccess(context, Strings.of(context).messageRegisterScreenSuccess);
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
    this.borderRadius = 8.0,
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
