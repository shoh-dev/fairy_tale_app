import 'package:flutter/material.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

final class AnyTextComponent extends TextComponent {
  const AnyTextComponent(
    this.value, {
    super.key,
    this.maxLines,
    this.overflow,
  });

  final dynamic value;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      value.toString(),
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
