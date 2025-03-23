import 'package:flutter/material.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

class HoverWidget extends StatefulWidget {
  const HoverWidget({
    required this.child,
    this.onTap,
    this.isSelected = false,
    super.key,
  });

  final Widget Function(bool hovering) child;
  final VoidCallback? onTap;
  final bool isSelected;

  @override
  State<HoverWidget> createState() => _HoverWidgetState();
}

class _HoverWidgetState extends State<HoverWidget> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    final radius = (context.theme.cardTheme.shape! as RoundedRectangleBorder)
        .borderRadius as BorderRadius;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      decoration: BoxDecoration(
        borderRadius: radius,
        border: Border.all(
          strokeAlign: BorderSide.strokeAlignOutside,
          color: widget.isSelected || hovering
              ? Colors.purple
              : Colors.transparent,
          width: !widget.isSelected && hovering ? 2 : 3,
        ),
      ),
      child: GestureDetector(
        onTap: widget.onTap,
        child: MouseRegion(
          cursor: widget.onTap != null
              ? SystemMouseCursors.click
              : SystemMouseCursors.none,
          onHover: (event) {
            setState(() {
              hovering = true;
            });
          },
          onExit: (event) {
            setState(() {
              hovering = false;
            });
          },
          child: widget.child(hovering),
        ),
      ),
    );
  }
}
