import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/utils/sizes.dart';

class InteractionObjectComponent extends StatefulWidget {
  const InteractionObjectComponent({super.key, required this.interaction});

  final TaleInteraction interaction;

  @override
  State<InteractionObjectComponent> createState() => _InteractionObjectComponentState();
}

class _InteractionObjectComponentState extends State<InteractionObjectComponent> {
  TaleInteraction get interaction => widget.interaction;

  Offset _position = Offset.zero;
  Size _size = Size.zero;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<List<TaleInteraction>>(
        converter: (store) => store.state.taleEditorState.selectedInteractions,
        onInitialBuild: (context, store, viewModel) {
          setState(() {
            _position = interaction.currentPosition.toOffset();
            _size = interaction.size.toSize();
          });
        },
        builder: (context, selectedInteractions) {
          print(selectedInteractions);
          final bool isSelected = selectedInteractions.contains(interaction);
          return StoreConnector<Tale>(
              converter: (store) => store.state.taleState.selectedTale,
              builder: (context, tale) {
                final deviceSize = Sizes.web.devicePreviewSize(tale.isPortrait);
                return AnimatedPositioned(
                  duration: Duration(milliseconds: interaction.animationDuration),
                  width: _size.width,
                  height: _size.height,
                  left: _position.dx,
                  top: _position.dy,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        context.dispatch(SelectTaleEditorTalePageInteractionAction([interaction]));
                      },
                      onPanUpdate: !isSelected
                          ? null
                          : (details) {
                              final oldPos = _position;
                              _position += details.delta;
                              if (_position.dx < 0) {
                                _position = Offset(0, _position.dy);
                              } else if (_position.dx > (deviceSize.width - _size.width)) {
                                //-40 is the size of the object
                                _position = Offset((deviceSize.width - _size.width), _position.dy);
                              }
                              if (_position.dy < 0) {
                                _position = Offset(_position.dx, 0);
                              } else if (_position.dy > (deviceSize.height - _size.height)) {
                                //-40 is the size of the object
                                _position = Offset(_position.dx, (deviceSize.height - _size.height));
                              }
                              if (oldPos != _position) {
                                setState(() {});
                              }
                            },
                      onPanEnd: (_) {
                        context.dispatch(SelectTaleEditorTalePageInteractionAction(
                            [interaction.copyWith(currentPosition: TaleInteractionPosition(_position.dx, _position.dy))]));
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 100),
                        width: _size.width,
                        height: _size.height,
                        decoration: BoxDecoration(
                          border: isSelected ? Border.all(color: Colors.red, width: 2) : Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: (isSelected ? Colors.red : Colors.black).withAlpha(100),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: interaction.objectImageUrl.isNotEmpty ? Image.network(interaction.objectImageUrl) : null,
                      ),
                    ),
                  ),
                );
              });
        });
  }
}
