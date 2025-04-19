import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    this.bgColor,
    this.fgColor,
    this.onPressed,
    this.size = 32,
  });

  final VoidCallback? onPressed;
  final IconData icon;
  final double size;
  final Color? bgColor;
  final Color? fgColor;

  @override
  Widget build(BuildContext context) {
    return ButtonComponent.icon(
      icon: icon,
      onPressed: onPressed,
      iconSize: size.w,
      padding: const EdgeInsets.all(8).w,
      elevation: 16,
      shadowColor: Colors.black,
      backgroundColor: bgColor,
      foregroundColor: fgColor,
    );
  }
}
