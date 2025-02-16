import 'package:flutter/material.dart';

extension BuildContextHelpers on BuildContext {
  bool isMobilePlatform() {
    return Theme.of(this).platform == TargetPlatform.android ||
        Theme.of(this).platform == TargetPlatform.iOS;
  }

  RelativeRect? findRelativeRectPosition(TapDownDetails details) {
    try {
      //find the position of the tap using the global position
      final RenderBox renderBox = findRenderObject() as RenderBox;
      final Offset tapPosition = details.globalPosition;
      final Size screenSize = renderBox.size;

      final position = RelativeRect.fromLTRB(
        tapPosition.dx,
        tapPosition.dy,
        screenSize.width + tapPosition.dx,
        screenSize.height - tapPosition.dy,
      );

      return position;
    } catch (e) {
      return null;
    }
  }
}
