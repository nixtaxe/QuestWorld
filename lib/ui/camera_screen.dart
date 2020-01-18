import 'package:flutter/material.dart';
//import 'package:qr_mobile_vision/qr_camera.dart';

class CameraScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
//          child: SizedBox(
//            width: MediaQuery.of(context).size.width,
//            height: MediaQuery.of(context).size.height,
//            child:
//            QrCamera(
//              onError: (context, error) => Text(
//                error.toString(),
//                style: TextStyle(color: Colors.red),
//              ),
//              qrCodeCallback: (code) {
//                _qrCallback(context, code);
//              },
//            ),
//          ),
        ),
      ),
    );
  }

  _qrCallback(context, code) {
    Navigator.pop(context, code);
  }
}