import 'package:fairy_tale_builder_platform/manager/redux/features/tales/tale/editor/interaction_actions.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:fairy_tale_builder_platform/manager/selector.dart';
import 'package:fairy_tale_builder_platform/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:shared/shared.dart';

class InteractionLeftSidebarComponent extends StatelessWidget {
  const InteractionLeftSidebarComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: context.height,
      decoration: const BoxDecoration(
        border: Border(right: BorderSide(color: Colors.grey)),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(Sizes.kLayoutPadding),
        child: Column(
          spacing: 16,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Interactions', style: context.textTheme.titleLarge),
            DispatchConnector<AppState>(
              builder: (context, dispatch) {
                return SizedBox(
                  width: double.infinity,
                  child: ButtonComponent.outlined(
                    text: 'Add interaction',
                    icon: Icons.add_rounded,
                    onPressed: () {
                      dispatch(AddInteractionAction());
                    },
                  ),
                );
              },
            ),
            const Divider(height: 0),
            StateConnector<AppState, (List<TaleInteraction>?, TaleInteraction)>(
              selector: (state) => (
                selectedTalePageSelector(state)?.interactions,
                selectedInteractionSelector(state),
              ),
              builder: (context, dispatch, model) {
                final interactions = model.$1;
                final selectedInteraction = model.$2;

                return Column(
                  spacing: 4,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (final TaleInteraction interaction
                        in interactions ?? [])
                      Builder(
                        builder: (context) {
                          final isSelected =
                              interaction.id == selectedInteraction.id;

                          return ListTile(
                            selected: isSelected,
                            selectedColor:
                                context.colorScheme.onSecondaryContainer,
                            selectedTileColor:
                                context.colorScheme.secondaryContainer,
                            tileColor: interaction.isValidToSave
                                ? null
                                : context.error.withAlpha(30),
                            shape: interaction.isValidToSave
                                ? null
                                : Border.all(color: context.error),
                            title: Text(interaction.id),
                            onTap: () {
                              dispatch(
                                SelectInteractionAction(
                                    interaction: interaction),
                              );
                            },
                            trailing: Badge(
                              isLabelVisible: interaction.isNew,
                              label: const Text('New'),
                              child: ButtonComponent.iconDesctructive(
                                icon: Icons.delete_rounded,
                                onPressed: () {
                                  //todo: delete interaction
                                  dispatch(
                                    DeleteInteractionAction(interaction),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
