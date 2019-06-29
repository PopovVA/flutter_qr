import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

Future<String> scan() async {
  try {
    final String barcode = await BarcodeScanner.scan();
    return barcode;
  } on PlatformException catch (e) {
    if (e.code == BarcodeScanner.CameraAccessDenied) {
      return 'The user did not grant the camera permission!';
    } else {
      return 'Unknown error: $e';
    }
  } on FormatException {
    //null (User returned using the "back"-button before scanning anything. Result)
    return null;
  } catch (e) {
    //null Unknown error: $e
    return 'Unknown error: $e';
  }
}
