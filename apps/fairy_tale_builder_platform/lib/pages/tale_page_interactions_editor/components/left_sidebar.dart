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
            SizedBox(
              width: double.infinity,
              child: ButtonComponent.outlined(
                text: 'Add interaction',
                icon: Icons.add_rounded,
                onPressed: () {
                  //todo:
                  // context.dispatch(AddEmptyTalePageInteractionAction());
                },
              ),
            ),
            const Divider(height: 0),
            StateConnector<AppState, (List<TaleInteraction>, TaleInteraction)>(
              selector: (state) => (
                selectedTalePageSelector(state).interactions,
                selectedInteractionSelector(state),
              ),
              builder: (context, dispatch, model) {
                final interactions = model.$1;
                final selectedInteraction = model.$2;

                return Column(
                  spacing: 4,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (final interaction in interactions)
                      Builder(
                        builder: (context) {
                          final isSelected =
                              interaction.id == selectedInteraction.id;

                          return ListTile(
                            selected: isSelected,
                            title: Text(interaction.id),
                            onTap: () {
                              //todo:
                              // if (isSelected) {
                              //   context.dispatch(
                              //       SelectEditorTalePageInteractionAction([]),
                              // );
                              //   return;
                              // }
                              // context.dispatch(
                              //     SelectEditorTalePageInteractionAction(
                              //         [interaction]));
                            },
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
