// import 'package:flutter/material.dart';
// import 'package:myspace_design_system/myspace_design_system.dart';

// class DatatableHeaderComponent extends Component {
//   const DatatableHeaderComponent({
//     super.key,
//     required this.manager,
//     this.title,
//   });

//   final DatatableManager manager;
//   final TextComponent? title;

//   @override
//   Widget build(BuildContext context) {
//     return LayoutComponent.row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         if (title != null) ...[
//           title!, //todo: add title component
//           const SizedBox(width: 16),
//         ],
//         SizedBox(
//           width: 200,
//           child: TextFieldComponent(
//             hintText: "Filter emails",
//             canClear: true,
//             onChanged: manager.getOnFilterCallback,
//             initialValue: manager.getQueryValue,
//           ),
//         ),
//       ],
//     );
//   }
// }
