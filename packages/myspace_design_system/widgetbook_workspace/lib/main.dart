import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// This file does not exist yet,
// it will be generated in the next step
import 'main.directories.g.dart';

void main() {
  runApp(const WidgetbookApp());
}

@widgetbook.App()
class WidgetbookApp extends StatefulWidget {
  const WidgetbookApp({super.key});

  @override
  State<WidgetbookApp> createState() => _WidgetbookAppState();
}

class _DeviceFramePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blueAccent
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawRect(
      Rect.fromPoints(
        const Offset(0, 0),
        Offset(size.width, size.height),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class _WidgetbookAppState extends State<WidgetbookApp> {
  final fCodeTheme = AppTheme();

  final frames = [
    Devices.ios.iPhone13Mini,
    Devices.ios.iPhone13,
    Devices.ios.iPhone13ProMax,
  ].map((device) => device.copyWith(framePainter: _DeviceFramePainter())).toList();

  late final themes = [
    WidgetbookTheme(name: "Light", data: fCodeTheme.lightTheme),
    WidgetbookTheme(name: "Dark", data: fCodeTheme.darkTheme),
  ];

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      // initialRoute:
      // "/ui/components/datatable/datatablecomponent/datatable-component",
      directories: directories,
      addons: [
        MaterialThemeAddon(initialTheme: MediaQuery.of(context).platformBrightness == Brightness.light ? themes[0] : themes[1], themes: themes),
        DeviceFrameAddon(devices: frames),
        AlignmentAddon(initialAlignment: Alignment.center),
      ],
    );
  }
}
