import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

abstract class CellDef<T> {
  const CellDef({
    required this.value,
    this.width,
  });

  final T value;

  Widget build(BuildContext context);

  final double? width;

  DataCell buildDataCell(BuildContext context) {
    return DataCell(
      SizedBox(width: width, child: build(context)),
    );
  }

  static CellDef<String> text(
    String value, {
    double? width,
  }) {
    return TextCellDef(value: value, width: width);
  }

  static CellDef<num> number(
    num value, {
    double? width,
  }) {
    return NumberCellDef(value: value, width: width);
  }

  static CellDef<num> currency(
    num value, {
    double? width,
  }) {
    return CurrencyCellDef(value: value, width: width);
  }
}

class TextCellDef extends CellDef<String> {
  const TextCellDef({
    required super.value,
    super.width,
  });

  @override
  String toString() {
    return "TextCellDef: $value";
  }

  @override
  Widget build(BuildContext context) {
    return Text(value);
  }
}

class NumberCellDef extends CellDef<num> {
  const NumberCellDef({
    required super.value,
    super.width,
  });

  @override
  String toString() {
    return "NumberCellDef: $value";
  }

  @override
  Widget build(BuildContext context) {
    return Text(NumberFormat.decimalPattern().format(value));
  }
}

class CurrencyCellDef extends CellDef<num> {
  const CurrencyCellDef({
    required super.value,
    super.width,
  });

  @override
  String toString() {
    return "CurrencyCellDef: $value";
  }

  @override
  Widget build(BuildContext context) {
    return Text(NumberFormat.simpleCurrency().format(value));
  }
}
