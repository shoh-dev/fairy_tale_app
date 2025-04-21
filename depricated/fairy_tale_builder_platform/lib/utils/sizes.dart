import 'package:device_preview/device_preview.dart';
import 'package:flutter/services.dart';

abstract class Sizes {
  static const kAppBarHeight = 56.0;
  static const kLayoutPadding = 16.0;
  static const kLeftSidebarWidth = 340.0;
  static const kMaxWidth = 1400.0;

  static final device = Devices.ios.iPhoneSE;

  static Size deviceSize(bool isPortrait) {
    if (isPortrait) {
      return device.screenSize;
    }
    return Size(device.screenSize.height, device.screenSize.width);
  }
}
