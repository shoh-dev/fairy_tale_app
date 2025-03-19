import 'package:fairy_tale_builder_platform/components/translator_component.dart';
import 'package:fairy_tale_builder_platform/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:shared/shared.dart';

class InteractionObject extends StatelessWidget {
  const InteractionObject({
    required this.interaction,
    super.key,
    this.draggable = false,
  });

  final TaleInteraction interaction;
  final bool draggable;

  @override
  Widget build(BuildContext context) {
    if (draggable) {
      return _DraggableObject(interaction: interaction);
    }
    return _NotDraggableObject(interaction: interaction);
  }
}

//Draggable
class _DraggableObject extends StatefulWidget {
  const _DraggableObject({required this.interaction});

  final TaleInteraction interaction;

  @override
  State<_DraggableObject> createState() => _DraggableObjectState();
}

class _DraggableObjectState extends State<_DraggableObject> {
  TaleInteraction get interaction => widget.interaction;

  late Offset _position = interaction.currentPosition.toOffset();

  @override
  Widget build(BuildContext context) {
    return StateConnector<AppState, TaleInteraction?>(
      selector: selectedInteraction,
      onDidChange: (context, store, viewModel) {
        if (viewModel == null) {
          return;
        }
        if (interaction.id == widget.interaction.id) {
          if (_position != interaction.currentPosition.toOffset()) {
            setState(() {
              _position = viewModel.currentPosition.toOffset();
            });
          }
        }
      },
      builder: (context, dispatch, selectedInteraction) {
        final isSelected = selectedInteraction?.id == interaction.id;
        final device = Sizes.device;
        final deviceSize = device.screenSize;
        return AnimatedPositioned(
          duration: const Duration(milliseconds: 100),
          width: interaction.size.width,
          height: interaction.size.height,
          left: _position.dx,
          top: _position.dy,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                dispatch(SelectInteractionAction(interaction.id));
              },
              onPanUpdate: !isSelected
                  ? null
                  : (details) {
                      final oldPos = _position;
                      _position += details.delta;
                      if (_position.dx < 0) {
                        _position = Offset(0, _position.dy);
                      } else if (_position.dx >
                          (deviceSize.width - interaction.size.width)) {
                        //-40 is the size of the object
                        _position = Offset(
                          deviceSize.width - interaction.size.width,
                          _position.dy,
                        );
                      }
                      if (_position.dy < 0) {
                        _position = Offset(_position.dx, 0);
                      } else if (_position.dy >
                          (deviceSize.height - interaction.size.height)) {
                        //-40 is the size of the object
                        _position = Offset(
                          _position.dx,
                          deviceSize.height - interaction.size.height,
                        );
                      }
                      if (oldPos != _position) {
                        setState(() {});
                      }
                    },
              onPanEnd: (_) {
                if (isSelected) {
                  dispatch(
                    UpdateInteractionAction(
                      initialdx: _position.dx,
                      initialdy: _position.dy,
                    ),
                  );
                }
              },
              onPanStart: (details) {
                if (!isSelected) {
                  //todo: show toast select item first
                }
              },
              child: _banner(
                AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  width: interaction.size.width,
                  height: interaction.size.height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: isSelected
                        ? Border.all(color: Colors.red, width: 2)
                        : Border.all(color: Colors.grey, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: (isSelected ? Colors.red : Colors.grey)
                            .withAlpha(100),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: interaction.metadata.hasImage
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(interaction.metadata.imageUrl),
                        )
                      : null,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _banner(Widget child) {
    if (interaction.isNew) {
      return Badge(
        label: const Text('New'),
        isLabelVisible: interaction.isNew,
        child: child,
      );
    }
    return child;
  }
}

//Not draggable
class _NotDraggableObject extends StatelessWidget {
  const _NotDraggableObject({
    required this.interaction,
  });

  final TaleInteraction interaction;

  @override
  Widget build(BuildContext context) {
    if (interaction.isUsed) {
      return _Child(interaction: interaction);
    }

    return DispatchConnector<AppState>(
      builder: (context, dispatch) {
        return AnimatedPositioned(
          width: interaction.size.width,
          height: interaction.size.height,
          left: interaction.currentPosition.dx,
          top: interaction.currentPosition.dy,
          duration: Duration(
            milliseconds: interaction.animationDuration,
          ),
          child: _Child(interaction: interaction, position: false),
        );
      },
    );
  }
}

class _Child extends StatelessWidget {
  const _Child({
    required this.interaction,
    this.position = true,
  });

  final TaleInteraction interaction;
  final bool position;

  @override
  Widget build(BuildContext context) {
    return _positioned(
      Translator(
        toTranslate: [interaction.hintKey],
        builder: (translatedValue) {
          return Tooltip(
            triggerMode: TooltipTriggerMode.longPress,
            message: translatedValue[0],
            showDuration: const Duration(seconds: 5),
            child: Container(
              width: interaction.size.width,
              height: interaction.size.height,
              decoration: !interaction.metadata.hasImage
                  ? BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(100),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    )
                  : null,
              child: interaction.metadata.hasImage
                  ? Image.network(interaction.metadata.imageUrl)
                  : StreamBuilder(
                      stream: interaction.audioPlayerService.playerStateStream,
                      builder: (context, snapshot) {
                        if (snapshot.data != null) {
                          final isPlaying = snapshot.data!.processingState ==
                                  ProcessingState.ready &&
                              snapshot.data!.playing == true;
                          final isBuffering = snapshot.data!.processingState ==
                              ProcessingState.buffering;
                          if (isBuffering) {
                            return const Center(
                              child: CircularProgressIndicator.adaptive(),
                            );
                          }
                          if (isPlaying) {
                            return const Tooltip(
                              triggerMode: TooltipTriggerMode.tap,
                              message: 'Background audio is playing',
                              child:
                                  Icon(Icons.audiotrack, color: Colors.white),
                            );
                          }
                        }
                        return const SizedBox();
                      },
                    ),
            ),
          );
        },
      ),
    );
  }

  Widget _positioned(Widget child) {
    if (position) {
      return AnimatedPositioned(
        // curve: Curves.ease, //todo: get curve from db
        width: interaction.size.width,
        height: interaction.size.height,
        left: interaction.currentPosition.dx,
        top: interaction.currentPosition.dy,
        duration: Duration(
          milliseconds: interaction.animationDuration,
        ),
        child: child,
      );
    }

    return child;
  }
}
