// import 'package:flutter/material.dart';
// import 'package:myspace_data/myspace_data.dart';
// import 'package:myspace_design_system/utils/sizes.dart';

// class InteractionObjectComponent extends StatefulWidget {
//   const InteractionObjectComponent({super.key, required this.interaction});

//   final TaleInteraction interaction;

//   @override
//   State<InteractionObjectComponent> createState() => _InteractionObjectComponentState();
// }

// class _InteractionObjectComponentState extends State<InteractionObjectComponent> {
//   TaleInteraction get interaction => widget.interaction;

//   Offset _position = Offset.zero;

//   @override
//   Widget build(BuildContext context) {
//     return StoreConnector<List<TaleInteraction>>(
//         converter: (store) => store.state.taleEditorState.selectedInteractions,
//         onDidChange: (context, store, viewModel) {
//           for (var interaction in viewModel) {
//             if (interaction.id == widget.interaction.id) {
//               if (_position != interaction.initialPosition.toOffset()) {
//                 setState(() {
//                   _position = viewModel.first.initialPosition.toOffset();
//                 });
//               }
//             }
//           }
//         },
//         onInitialBuild: (context, store, viewModel) {
//           setState(() {
//             _position = interaction.currentPosition.toOffset();
//           });
//         },
//         builder: (context, selectedInteractions) {
//           final bool isSelected = selectedInteractions.any((element) => element.id == interaction.id);
//           return StoreConnector<Tale>(
//               converter: (store) => store.state.taleState.selectedTale,
//               builder: (context, tale) {
//                 final deviceSize = Sizes.web.devicePreviewSize(tale.isPortrait);
//                 return AnimatedPositioned(
//                   duration: const Duration(milliseconds: 100),
//                   width: interaction.size.width,
//                   height: interaction.size.height,
//                   left: _position.dx,
//                   top: _position.dy,
//                   child: MouseRegion(
//                     cursor: SystemMouseCursors.click,
//                     child: GestureDetector(
//                       onTap: () {
//                         context.dispatch(SelectEditorTalePageInteractionAction([interaction]));
//                       },
//                       onPanUpdate: !isSelected
//                           ? null
//                           : (details) {
//                               final oldPos = _position;
//                               _position += details.delta;
//                               if (_position.dx < 0) {
//                                 _position = Offset(0, _position.dy);
//                               } else if (_position.dx > (deviceSize.width - interaction.size.width)) {
//                                 //-40 is the size of the object
//                                 _position = Offset((deviceSize.width - interaction.size.width), _position.dy);
//                               }
//                               if (_position.dy < 0) {
//                                 _position = Offset(_position.dx, 0);
//                               } else if (_position.dy > (deviceSize.height - interaction.size.height)) {
//                                 //-40 is the size of the object
//                                 _position = Offset(_position.dx, (deviceSize.height - interaction.size.height));
//                               }
//                               if (oldPos != _position) {
//                                 setState(() {});
//                               }
//                             },
//                       onPanEnd: (_) {
//                         context.dispatch(UpdateSelectedInteractionAction(
//                           interaction.copyWith(initialPosition: TaleInteractionPosition(_position.dx, _position.dy)),
//                         ));
//                       },
//                       child: AnimatedContainer(
//                         duration: const Duration(milliseconds: 100),
//                         width: interaction.size.width,
//                         height: interaction.size.height,
//                         decoration: BoxDecoration(
//                           border: isSelected ? Border.all(color: Colors.red, width: 2) : Border.all(color: Colors.black, width: 1),
//                           borderRadius: BorderRadius.circular(10),
//                           boxShadow: [
//                             BoxShadow(
//                               color: (isSelected ? Colors.red : Colors.black).withAlpha(100),
//                               blurRadius: 10,
//                               spreadRadius: 2,
//                             ),
//                           ],
//                         ),
//                         child: interaction.objectImageUrl.isNotEmpty ? Image.network(interaction.objectImageUrl) : null,
//                       ),
//                     ),
//                   ),
//                 );
//               });
//         });
//   }
// }
