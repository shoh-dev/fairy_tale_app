import 'package:flutter/material.dart';

abstract class ColumnDef {
  const ColumnDef({
    this.isEditable = false,
  });

  final bool isEditable;

  bool get isNumeric => false;

  Widget build(BuildContext context);

  DataColumn buildDataColumn(
    BuildContext context, {
    void Function(int columnIndex, bool ascending)? onSort,
  }) {
    return DataColumn(
      onSort: onSort,
      label: build(context),
    );
  }

  static ColumnDef text({
    required String label,
    bool isEditable = false,
  }) {
    return TextColumnDef(
      label: label,
      isEditable: isEditable,
    );
  }
}

class TextColumnDef extends ColumnDef {
  const TextColumnDef({
    required this.label,
    super.isEditable,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(label, overflow: TextOverflow.ellipsis);
  }
}
