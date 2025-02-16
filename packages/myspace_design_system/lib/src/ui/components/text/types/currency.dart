import 'package:flutter/material.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

class CurrencyTextComponent extends TextComponent {
  const CurrencyTextComponent(this.number, {super.key});

  final num number;

  @override
  Widget build(BuildContext context) {
    //todo: format as currency
    return Text(number.toString());
  }
}
