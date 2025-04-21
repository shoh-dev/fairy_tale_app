import 'package:flutter/material.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

class UIIconButton extends StatelessWidget {
  const UIIconButton({
    required this.icon,
    super.key,
    this.backgroundColor,
    this.foregroundColor,
    this.onPressed,
  });

  final IconData icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ButtonComponent.icon(
      icon: icon,
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      iconSize: 28,
    );
  }
}
