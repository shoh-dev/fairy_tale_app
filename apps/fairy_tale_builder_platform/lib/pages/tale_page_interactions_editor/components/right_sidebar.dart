// import 'package:flutter/material.dart';
// import 'package:myspace_data/myspace_data.dart';
// import 'package:myspace_design_system/utils/helpers/theme.dart';
// import 'package:myspace_design_system/utils/sizes.dart';

// import 'interaction_details_form.dart';

// class InteractionRightSidebarComponent extends StatelessWidget {
//   const InteractionRightSidebarComponent({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 400,
//       height: context.height,
//       decoration: const BoxDecoration(
//         border: Border(left: BorderSide(color: Colors.grey)),
//       ),
//       child: SingleChildScrollView(
//         padding: EdgeInsets.all(Sizes.web.kLayoutPadding),
//         child: StoreConnector<List<TaleInteraction>>(
//             converter: (store) => store.state.taleEditorState.selectedInteractions,
//             builder: (context, selectedInteractions) {
//               if (selectedInteractions.isEmpty) {
//                 return Text(
//                   "Select an interaction to edit",
//                   style: context.textTheme.titleLarge,
//                 );
//               }
//               return InteractionDetailsForm(interactions: selectedInteractions);
//             }),
//       ),
//     );
//   }
// }
