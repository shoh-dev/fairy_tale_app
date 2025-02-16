import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Popup Menu Button', type: PopupMenuButtonComponent)
Widget buildPopupMenuButton(BuildContext context) {
  return PopupMenuButtonComponent<String>(
    onSelected: (value) {
      debugPrint(value?.value);
    },
    items: [
      DropdownItem(value: 'Item 1', label: 'Item 1'),
      DropdownItem(value: 'Item 2', label: 'Item 2'),
      DropdownItem(value: 'Item 3', label: 'Item 3'),
    ],
  );
}
