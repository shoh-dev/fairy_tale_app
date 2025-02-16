// import 'package:flutter/material.dart';
// import 'package:myspace_design_system/myspace_design_system.dart';

// class DatatableFooterComponent extends Component {
//   const DatatableFooterComponent({
//     super.key,
//     required this.manager,
//   });

//   final DatatableManager manager;

//   @override
//   Widget build(BuildContext context) {
//     return LayoutComponent.row(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: [
//         SizedBox(
//           width: 200,
//           child: DropdownComponent<int>(
//             label: "Page size",
//             initialValue: DropdownItem(
//               value: manager.getPageSize,
//               label: manager.getPageSize.toString(),
//             ),
//             items: [
//               DropdownItem(value: 10, label: '10'),
//               DropdownItem(value: 20, label: '20'),
//               DropdownItem(value: 50, label: '50'),
//             ],
//             onChanged: (value) {
//               if (value == null) return;
//               manager.setPageSize(value.value);
//             },
//           ),
//         ),
//         const Spacer(),
//         TextComponent.any(
//           "Page ${manager.getCurrentPage + 1} of ${manager.getTotalPages}",
//         ),
//         const SizedBox(width: 8),
//         ButtonComponent.iconOutlined(
//           icon: Icons.chevron_left_rounded,
//           onPressed: manager.canPreviousPage ? manager.previousPage : null,
//         ),
//         const SizedBox(width: 8),
//         ButtonComponent.iconOutlined(
//           icon: Icons.chevron_right_rounded,
//           onPressed: manager.canNextPage ? manager.nextPage : null,
//         ),
//       ],
//     );
//   }
// }
