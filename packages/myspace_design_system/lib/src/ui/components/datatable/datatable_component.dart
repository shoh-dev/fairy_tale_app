import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:flutter/material.dart';
import 'package:myspace_design_system/utils/helpers/context.dart';
import 'package:myspace_design_system/utils/helpers/theme.dart';

export 'models/cell.dart';
export 'models/row.dart';
export 'models/column.dart';

class DatatableComponent extends StatelessWidget {
  const DatatableComponent({
    super.key,
    required this.columns,
    required this.rows,
    this.onRowActionPressed,
    this.rowActions = const [],
  });

  final List<ColumnDef> columns;
  final List<RowDef> rows;
  final void Function(RowDef row, DropdownItem<String> value)?
      onRowActionPressed;
  final Iterable<DropdownItem<String>> rowActions;

  @override
  Widget build(BuildContext context) {
    return DataTable(
      border: TableBorder(
        bottom: BorderSide(color: context.colorScheme.outline),
        left: BorderSide(color: context.colorScheme.outline),
        right: BorderSide(color: context.colorScheme.outline),
        horizontalInside: BorderSide(color: context.colorScheme.outline),
        verticalInside: BorderSide(color: context.colorScheme.outline),
        top: BorderSide(
            color: context.colorScheme
                .outline), //comment this if the above DataTable is uncommented
      ),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainer,
      ),
      columns: [
        for (var column in columns) column.buildDataColumn(context),
        if (onRowActionPressed != null) const DataColumn(label: Text("")),
      ],
      rows: [
        for (var row in rows)
          DataRow(
            cells: [
              for (var cell in row.cells) cell.buildDataCell(context),
              if (onRowActionPressed != null)
                DataCell(
                  const SizedBox(),
                  showEditIcon: !row.alwaysDisableEdit,
                  onTapDown: row.alwaysDisableEdit
                      ? null
                      : (details) async {
                          final position =
                              context.findRelativeRectPosition(details);

                          if (position == null) return;

                          final action = await showMenu<DropdownItem<String>>(
                              context: context,
                              position: position,
                              items: [
                                for (var action in rowActions)
                                  PopupMenuItem(
                                      value: action, child: Text(action.label))
                              ]);
                          if (action != null) onRowActionPressed!(row, action);
                        },
                ),
            ],
          ),
      ],
    );
  }
}

// class DatatableComponent extends StatefulComonent {
//   const DatatableComponent({
//     super.key,
//     required this.columns,
//     required this.rows,
//     this.onLoaded,
//     this.manager,
//     this.onRowActionPressed,
//     this.rowActions = const [],
//     this.showCheckboxColumn = false,
//     this.tableSize,
//   });

//   final List<ColumnDef> columns;
//   final List<RowDef> rows;
//   final ValueChanged<DatatableManager>? onLoaded;
//   final DatatableManager? manager;
//   final void Function(RowDef row, DropdownItem<String> value)?
//       onRowActionPressed;
//   final Iterable<DropdownItem<String>> rowActions;
//   final bool showCheckboxColumn;
//   final Size? tableSize;

//   @override
//   State<StatefulWidget> createState() => _DatatableComponentState();
// }

// class _DatatableComponentState extends State<DatatableComponent> {
//   late final DatatableManager manager = widget.manager ?? DatatableManager();

//   @override
//   void initState() {
//     manager._rows.addAll(List.of(widget.rows));
//     manager._columns.addAll(List.of(widget.columns));
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       widget.onLoaded?.call(manager);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LayoutComponent.column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         DatatableHeaderComponent(manager: manager),
//         const SizedBox(height: 8),
//         // ListenableBuilder(
//         //     listenable: manager,
//         //     builder: (context, child) {
//         //       return SizedBox.fromSize(
//         //         size: const Size.fromHeight(56),
//         //         child: DataTable(
//         //           columnSpacing: 16,
//         //           sortAscending: manager._sortAscending,
//         //           sortColumnIndex: manager._sortColumnIndex,
//         //           showCheckboxColumn: widget.showCheckboxColumn,
//         //           border: TableBorder(
//         //             top: BorderSide(color: context.colorScheme.outline),
//         //             left: BorderSide(color: context.colorScheme.outline),
//         //             right: BorderSide(color: context.colorScheme.outline),
//         //             horizontalInside:
//         //                 BorderSide(color: context.colorScheme.outline),
//         //             verticalInside:
//         //                 BorderSide(color: context.colorScheme.outline),
//         //           ),
//         //           dataRowMinHeight: 0,
//         //           dataRowMaxHeight: 0,
//         //           columns: [
//         //             for (var column in widget.columns)
//         //               column.buildDataColumn(
//         //                 context,
//         //                 onSort: manager._onSort,
//         //               ),
//         //             if (widget.onRowActionPressed != null)
//         //               const DataColumn(label: Text("")),
//         //           ],
//         //           rows: [
//         //             for (var row in manager._rows.take(1))
//         //               DataRow(
//         //                 selected: manager._getCheckedRows.contains(row),
//         //                 cells: [
//         //                   for (var cell in row.cells)
//         //                     DataCell(
//         //                       SizedBox(width: cell.width - 18),
//         //                     ),
//         //                   if (widget.onRowActionPressed != null)
//         //                     const DataCell(SizedBox()),
//         //                 ],
//         //               ),
//         //           ],
//         //         ),
//         //       );
//         //     }),
//         ListenableBuilder(
//           listenable: manager,
//           builder: (context, child) => SizedBox.fromSize(
//             size: widget.tableSize ??
//                 const Size.fromHeight(
//                     420 + 50 + 1), //column height + cell height + 1(for border)
//             child: SingleChildScrollView(
//               child: DataTable(
//                 border: TableBorder(
//                   bottom: BorderSide(color: context.colorScheme.outline),
//                   left: BorderSide(color: context.colorScheme.outline),
//                   right: BorderSide(color: context.colorScheme.outline),
//                   horizontalInside:
//                       BorderSide(color: context.colorScheme.outline),
//                   verticalInside:
//                       BorderSide(color: context.colorScheme.outline),
//                   top: BorderSide(
//                       color: context.colorScheme
//                           .outline), //comment this if the above DataTable is uncommented
//                 ),
//                 decoration: BoxDecoration(
//                   color: context.colorScheme.surfaceContainer,
//                 ),
//                 columnSpacing: 16,
//                 sortAscending: manager._sortAscending,
//                 sortColumnIndex: manager._sortColumnIndex,
//                 showCheckboxColumn: widget.showCheckboxColumn,
//                 dataRowHeight: 42,
//                 headingRowHeight: 50,
//                 // headingRowHeight: 0,//enable this if the above DataTable is uncommented
//                 columns: [
//                   for (var column in widget.columns)
//                     column.buildDataColumn(
//                       context,
//                       onSort: manager
//                           ._onSort, //comment this if the above DataTable is uncommented
//                     ),
//                   if (widget.onRowActionPressed != null)
//                     const DataColumn(label: Text("")),
//                 ],
//                 rows: [
//                   for (var row in manager._getRows)
//                     DataRow(
//                       selected: manager._getCheckedRows.contains(row),
//                       onSelectChanged: widget.showCheckboxColumn
//                           ? (value) => manager._onRowSelected(row, value)
//                           : null,
//                       cells: [
//                         for (var cell in row.cells) cell.buildDataCell(context),
//                         if (widget.onRowActionPressed != null)
//                           DataCell(
//                             const SizedBox(),
//                             showEditIcon: true,
//                             onTapDown: (details) async {
//                               final position =
//                                   context.findRelativeRectPosition(details);

//                               if (position == null) return;

//                               final action =
//                                   await showMenu<DropdownItem<String>>(
//                                       context: context,
//                                       position: position,
//                                       items: [
//                                     for (var action in widget.rowActions)
//                                       PopupMenuItem(
//                                           value: action,
//                                           child: Text(action.label))
//                                   ]);
//                               if (action != null) {
//                                 widget.onRowActionPressed!(row, action);
//                               }
//                             },
//                           ),
//                       ],
//                     ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(height: 8),
//         DatatableFooterComponent(manager: manager),
//       ],
//     );
//   }
// }

// class DatatableManager extends ChangeNotifier {
//   String _filter = "";
//   int? _sortColumnIndex;
//   bool _sortAscending = true;

//   int _page = 0;
//   int _pageSize = 10;

//   final List<ColumnDef> _columns = [];

//   final List<RowDef> _checkedRows = [];

//   final _rows = <RowDef>[];

//   ColumnDef? get getSortColumn {
//     if (_sortColumnIndex != null) {
//       return _columns[_sortColumnIndex!];
//     }
//     return null;
//   }

//   ColumnDef? getColumnFor(int cellIndex) {
//     return _columns[cellIndex];
//   }

//   List<RowDef> get _getRows {
//     final List<RowDef> rs = [];

//     void doFilter() {
//       if (_filter.isNotEmpty) {
//         //filter
//         rs.addAll(List.of(_rows.where((row) {
//           return row.cells.any((cell) {
//             // switch (cell) {
//             //   case TextCellDef _:
//             //     final text = cell.value.toString().toLowerCase();
//             //     return text.contains(_filter);
//             //   case NumberCellDef _:
//             //   case CurrencyCellDef _:
//             //     final filterNum = num.tryParse(_filter);
//             //     if (filterNum == null) return false;
//             //     final numVal = cell.value as num;
//             //     return numVal == filterNum;
//             //   default:
//             //     throw "Not implemented";
//             // }
//             final String text = cell.value.toString().toLowerCase();
//             return text.contains(_filter.toString());
//           });
//         }).toList()));
//       } else {
//         rs.addAll(List.of(_rows));
//       }
//     }

//     void doSort() {
//       int compare(dynamic a, dynamic b) {
//         if (_sortAscending) return a.compareTo(b);
//         return b.compareTo(a);
//       }

//       rs.sort((a, b) {
//         final acell = a.cells[_sortColumnIndex!];
//         final bcell = b.cells[_sortColumnIndex!];
//         if (acell.runtimeType != bcell.runtimeType) {
//           throw "Make sure to use the same type of cell for all rows! ${acell.runtimeType} != ${bcell.runtimeType}";
//         }
//         switch (acell) {
//           case TextCellDef _:
//             final a = acell;
//             final b = bcell as TextCellDef;
//             return compare(a.value, b.value);
//           case NumberCellDef _:
//             final a = acell;
//             final b = bcell as NumberCellDef;
//             return compare(a.value, b.value);
//           case CurrencyCellDef _:
//             final a = acell;
//             final b = bcell as CurrencyCellDef;
//             return compare(a.value, b.value);
//           default:
//             throw "Not implemented";
//         }
//       });
//     }

//     doFilter();

//     if (_sortColumnIndex != null) {
//       //must sort
//       doSort();
//     } else {
//       rs.clear();
//       doFilter();
//     }

//     return rs.skip(_page * _pageSize).take(_pageSize).toList();
//   }

//   List<RowDef> get _getCheckedRows => _checkedRows;

//   void _onRowSelected(RowDef row, bool? toggle) {
//     if (toggle == true) {
//       _checkedRows.add(row);
//     } else if (toggle == false) {
//       _checkedRows.remove(row);
//     }
//     notifyListeners();
//   }

//   void _onSort(int columnIndex, bool ascending) {
//     if (columnIndex == _sortColumnIndex) {
//       if (ascending) {
//         _sortAscending = true;
//         _sortColumnIndex = null;
//       } else {
//         _sortColumnIndex = columnIndex;
//         _sortAscending = ascending;
//       }
//     } else {
//       _sortColumnIndex = columnIndex;
//       _sortAscending = ascending;
//     }
//     notifyListeners();
//   }

//   void _onFilter(String query) {
//     _filter = query.toLowerCase();
//     if (_page > getTotalPages) _page = 0;
//     if (_getRows.length < _pageSize) {
//       if (_pageSize == 50) {
//         _pageSize = 20;
//       }
//       if (_pageSize == 20) {
//         _pageSize = 10;
//       }
//     }

//     notifyListeners();
//   }

//   void Function(String) get getOnFilterCallback => _onFilter;

//   String get getQueryValue => _filter;

//   int get getPageSize => _pageSize;

//   void setPageSize(int size) {
//     _page = 0;
//     _pageSize = size;
//     notifyListeners();
//   }

//   int get getTotalPages {
//     if (_filter.isNotEmpty) {
//       return (_getRows.length / _pageSize).ceil();
//     }
//     return (_rows.length / _pageSize).ceil();
//   }

//   int get getCurrentPage => _page;

//   bool get canNextPage => _page + 1 < getTotalPages;

//   bool get canPreviousPage => _page > 0;

//   void nextPage() {
//     if (canNextPage) {
//       _page++;
//       notifyListeners();
//     }
//   }

//   void previousPage() {
//     if (canPreviousPage) {
//       _page--;
//       notifyListeners();
//     }
//   }

//   @override
//   String toString() {
//     return "Filter: $_filter, SortColumnIndex: $_sortColumnIndex, SortAscending: $_sortAscending";
//   }
// }
