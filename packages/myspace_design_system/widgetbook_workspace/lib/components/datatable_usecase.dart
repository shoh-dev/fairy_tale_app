import 'package:flutter/material.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

enum Status { success, failed, processing }

class MyModel {
  final Status status;
  final String email;
  final double amount;

  const MyModel({
    required this.status,
    required this.email,
    required this.amount,
  });
}

const List<MyModel> models = [
  MyModel(status: Status.success, email: 'ken99@yahoo.com', amount: 316),
  MyModel(status: Status.failed, email: 'carmella@hotmail.com', amount: 721),
  MyModel(status: Status.success, email: 'Silas22@gmail.com', amount: 874),
  MyModel(
      status: Status.processing, email: 'Monserrat44@gmail.com', amount: 837),
  MyModel(status: Status.success, email: 'Abe45@gmail.com', amount: 242),
];

@widgetbook.UseCase(name: 'Datatable Component', type: DatatableComponent)
Widget buildDatatable(BuildContext context) {
  return DatatableComponent(
    onRowActionPressed: (row, value) {
      debugPrint(
          'Row action pressed for ${row.cells} with value ${value.value}');
    },
    rowActions: [
      DropdownItem<String>(value: 'edit', label: 'Edit'),
      DropdownItem<String>(value: 'delete', label: 'Delete'),
    ],
    columns: [
      ColumnDef.text(label: "Status"),
      ColumnDef.text(label: "Email"),
      ColumnDef.text(label: "Amount"),
    ],
    rows: [
      for (var model in models)
        RowDef(
          cells: [
            CellDef.text(model.status.name.toUpperCase()),
            CellDef.text(model.email),
            CellDef.currency(model.amount),
          ],
        ),
    ],
  );
}
