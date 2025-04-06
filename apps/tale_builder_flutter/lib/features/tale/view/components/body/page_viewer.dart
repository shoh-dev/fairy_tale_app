import 'package:flutter/material.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

class PageViewer extends StatefulWidget {
  const PageViewer({super.key, required this.deviceSize});

  final Size deviceSize;

  @override
  State<PageViewer> createState() => _PageViewerState();
}

class _PageViewerState extends State<PageViewer> {
  Size get deviceSize => widget.deviceSize;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceSize.width,
      height: deviceSize.height,
      decoration: BoxDecoration(
        border: Border.all(color: context.colorScheme.onSurface),
        color: context.colorScheme.surfaceContainer,
      ),
      child: Stack(),
    );
  }
}
