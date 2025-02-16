import 'cell.dart';

class RowDef {
  RowDef({
    required this.cells,
    this.alwaysDisableEdit = false,
  });

  final List<CellDef> cells;

  final bool alwaysDisableEdit;
}
