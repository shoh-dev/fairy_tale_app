import 'package:device_preview/device_preview.dart';
import 'package:fairy_tale_builder_platform/manager/redux/features/tales/tale/editor/interaction_actions.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:fairy_tale_builder_platform/manager/selector.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:shared/shared.dart';

class InteractionObjectComponent extends StatefulWidget {
  const InteractionObjectComponent({required this.interaction, super.key});

  final TaleInteraction interaction;

  @override
  State<InteractionObjectComponent> createState() =>
      _InteractionObjectComponentState();
}

class _InteractionObjectComponentState
    extends State<InteractionObjectComponent> {
  TaleInteraction get interaction => widget.interaction;

  late Offset _position = interaction.initialPosition.toOffset();

  @override
  Widget build(BuildContext context) {
    return StateConnector<AppState, TaleInteraction?>(
      selector: selectedInteractionSelector,
      onDidChange: (context, store, viewModel) {
        if (viewModel == null) {
          return;
        }
        if (interaction.id == widget.interaction.id) {
          if (_position != interaction.initialPosition.toOffset()) {
            setState(() {
              _position = viewModel.initialPosition.toOffset();
            });
          }
        }
      },
      builder: (context, dispatch, selectedInteraction) {
        final isSelected = selectedInteraction?.id == interaction.id;
        final device = Devices.ios.iPhoneSE;
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
                dispatch(
                  UpdateInteractionAction(
                    initialdx: _position.dx,
                    initialdy: _position.dy,
                  ),
                );
              },
              child: AnimatedContainer(
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
        );
      },
    );
  }
}
