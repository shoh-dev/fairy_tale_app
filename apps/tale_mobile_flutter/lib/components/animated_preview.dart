import 'package:flutter/material.dart';

class AnimatedPreview extends StatelessWidget {
  const AnimatedPreview({
    super.key,
    required this.child,
    required this.isPreviewMode,
  });

  final Widget child;
  final bool isPreviewMode;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isPreviewMode ? 0 : 1,
      duration: Durations.medium4,
      child: AbsorbPointer(absorbing: isPreviewMode, child: child),
    );
  }
}
