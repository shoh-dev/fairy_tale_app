import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:myspace_design_system/utils/helpers/theme.dart';

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
        padding: EdgeInsets.all(Sizes.web.kLayoutPadding),
        child: Column(
          spacing: 16,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Interactions", style: context.textTheme.titleLarge),
            SizedBox(
              width: double.infinity,
              child: ButtonComponent.outlined(
                text: "Add interaction",
                icon: Icons.add_rounded,
                onPressed: () {
                  context.dispatch(AddEmptyTalePageInteractionAction());
                },
              ),
            ),
            const Divider(height: 0),
            StoreConnector<List<TaleInteraction>>(
              converter: (store) => store.state.taleEditorState.selectedPage.taleInteractions,
              builder: (context, interactions) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (var interaction in interactions)
                      StoreConnector<List<TaleInteraction>>(
                          converter: (store) => store.state.taleEditorState.selectedInteractions,
                          builder: (context, selectedInteractions) {
                            final bool isSelected = selectedInteractions.any((element) => element.id == interaction.id);
                            return InkWell(
                              onTap: () {
                                if (isSelected) {
                                  context.dispatch(SelectEditorTalePageInteractionAction([]));
                                  return;
                                }
                                context.dispatch(SelectEditorTalePageInteractionAction([interaction]));
                              }, //todo:
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(Sizes.web.kLayoutPadding),
                                decoration: BoxDecoration(
                                  color: isSelected ? context.colorScheme.primary.withAlpha(100) : null,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(interaction.id),
                              ),
                            );
                          }),
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
