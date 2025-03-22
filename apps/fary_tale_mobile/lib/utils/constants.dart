import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class AppConstants {
  static const List<DeviceOrientation> appOrientation = [
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ];
}

abstract class AppUI {
  static const defaultShadow = BoxShadow(
    color: Colors.black45,
    offset: Offset(1, 1),
  );
  static BorderRadius maxBorderRadius = BorderRadius.circular(9999);
}
