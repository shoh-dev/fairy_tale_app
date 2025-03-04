// import 'package:flutter/material.dart';
// import 'package:myspace_data/myspace_data.dart';
// import 'package:myspace_design_system/myspace_design_system.dart';
// import 'package:shared/shared.dart';

// class TaleEditorLeftSidebarComponent extends StatelessWidget {
//   const TaleEditorLeftSidebarComponent({
//     required this.pages,
//     super.key,
//   });

//   final List<TalePage> pages;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 320,
//       height: context.height,
//       decoration: const BoxDecoration(
//         border: Border(
//           right: BorderSide(
//             color: Colors.grey,
//           ),
//         ),
//       ),
//       child: SingleChildScrollView(
//         padding: EdgeInsets.all(Sizes.web.kLayoutPadding),
//         child: StoreConnector<TalePage>(
//             converter: (state) => state.state.taleEditorState.selectedPage,
//             builder: (context, selectedPage) {
//               return Column(
//                 spacing: 16,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text("Pages", style: context.textTheme.titleLarge),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ButtonComponent.outlined(
//                       text: "Add page",
//                       icon: Icons.add_rounded,
//                       onPressed: () {
//                         context.dispatch(AddEmptyTalePageAction());
//                       },
//                     ),
//                   ),
//                   const Divider(height: 0),
//                   //pages
//                   for (var page in pages)
//                     Builder(builder: (context) {
//                       final bool isSelected = page.id == selectedPage.id;
//                       return InkWell(
//                         onTap: () {
//                           if (isSelected) {
//                             context.dispatch(SelectEditorTalePageAction(null));
//                             return;
//                           }
//                           context.dispatch(SelectEditorTalePageAction(page));
//                         },
//                         borderRadius: BorderRadius.circular(8),
//                         child: AnimatedContainer(
//                           duration: const Duration(milliseconds: 100),
//                           width: double.infinity,
//                           height: 340,
//                           decoration: BoxDecoration(
//                             color: isSelected
//                                 ? context.colorScheme.primaryContainer
//                                 : null,
//                             border: isSelected
//                                 ? Border.all(
//                                     color:
//                                         context.colorScheme.onPrimaryContainer,
//                                     width: 2,
//                                   )
//                                 : null,
//                           ),
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               if (page.backgroundImage.isNotEmpty)
//                                 Image.network(
//                                   page.backgroundImage,
//                                   fit: BoxFit.cover,
//                                 )
//                               else
//                                 Container(
//                                   height: 300,
//                                   decoration: BoxDecoration(
//                                     border: Border.all(
//                                       color: Colors
//                                           .grey, //todo: no image placeholder
//                                     ),
//                                   ),
//                                   child: const Placeholder(),
//                                 ),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(page.text.isEmpty
//                                     ? "No page title"
//                                     : context.taleTr(page.text)),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     }),
//                 ],
//               );
//             }),
//       ),
//     );
//   }
// }
