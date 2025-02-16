import 'package:flutter/material.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

final class AnyTextComponent extends TextComponent {
  const AnyTextComponent(this.value, {super.key});

  final dynamic value;

  @override
  Widget build(BuildContext context) {
    return Text(value.toString());
  }
}
