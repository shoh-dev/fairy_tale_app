import 'package:flutter/material.dart';

class PreviewWrapper extends StatelessWidget {
  const PreviewWrapper({
    super.key,
    required this.child,
    required this.isPreviewMode,
  });

  final bool isPreviewMode;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isPreviewMode ? .5 : 1,
      child: AbsorbPointer(absorbing: isPreviewMode, child: child),
    );
  }
}
