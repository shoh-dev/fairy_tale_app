// import 'package:flutter/material.dart';
// import 'package:myspace_data/myspace_data.dart';
// import 'package:myspace_design_system/myspace_design_system.dart';
// import 'package:myspace_design_system/utils/helpers/theme.dart';
// // import 'package:tale_buider_app/features/tale_page_interactions_editor/components/left_sidebar.dart';
// import 'package:tale_buider_app/features/tale_page_interactions_editor/components/right_sidebar.dart';
// import 'package:tale_buider_app/layout/default_layout.dart';

// import 'components/interaction_object.dart';
// import 'components/left_sidebar.dart';

// class TalePageInteractionsEditor extends StatelessWidget {
//   const TalePageInteractionsEditor({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return const DefaultLayout(
//       title: Text("Update Tale Interactions"),
//       leftSidebar: InteractionLeftSidebarComponent(),
//       rigthSidebar: InteractionRightSidebarComponent(),
//       body: _Body(),
//     );
//   }
// }

// class _Body extends StatelessWidget {
//   const _Body();

//   @override
//   Widget build(BuildContext context) {
//     return StoreConnector<Tale>(
//         converter: (store) => store.state.taleState.selectedTale,
//         onDispose: (store) {
//           store.dispatch(SelectEditorTalePageInteractionAction([]));
//         },
//         builder: (context, tale) {
//           return StoreConnector<TalePage>(
//             converter: (store) => store.state.taleEditorState.selectedPage,
//             builder: (context, page) {
//               return Center(
//                 child: Container(
//                     width: Sizes.web.devicePreviewSize(tale.isPortrait).width,
//                     height: Sizes.web.devicePreviewSize(tale.isPortrait).height,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: context.colorScheme.primary),
//                     ),
//                     child: Stack(
//                       children: [
//                         //image
//                         if (page.backgroundImage.isNotEmpty)
//                           Positioned.fill(
//                               child: Image.network(
//                             page.backgroundImage,
//                             fit: BoxFit.cover,
//                           )),

//                         Positioned.fill(child: GestureDetector(
//                           onTap: () {
//                             context.dispatch(SelectEditorTalePageInteractionAction([]));
//                           },
//                         )),

//                         for (var interaction in page.taleInteractions)
//                           //tale object
//                           InteractionObjectComponent(interaction: interaction),
//                       ],
//                     )),
//               );
//             },
//           );
//         });
//   }
// }
