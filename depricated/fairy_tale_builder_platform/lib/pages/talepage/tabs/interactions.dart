import 'package:fairy_tale_builder_platform/pages/talepage/components/forms/interaction_form.dart';
import 'package:fairy_tale_builder_platform/pages/talepage/components/positioned_interactions.dart';
import 'package:fairy_tale_builder_platform/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:shared/shared.dart';

class TalepageInteractions extends StatelessWidget {
  const TalepageInteractions({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 32,
      children: [
        SizedBox(
          width: Sizes.kMaxWidth * .2,
          child: _List(),
        ),
        SizedBox(
          width: Sizes.kMaxWidth * .5,
          child: TalepagePositionedInteractions(),
        ),
        SizedBox(
          width: Sizes.kMaxWidth * .2,
          child: TalepageInteractionForm(),
        ),
      ],
    );
  }
}

class _List extends StatelessWidget
    with StateConnectorMixin<(List<TaleInteraction>, TaleInteraction?)> {
  const _List();

  @override
  @override
  Widget builder(
    BuildContext context,
    Dispatcher<AppState> dispatch,
    (List<TaleInteraction>, TaleInteraction?) model,
  ) {
    final interactions = List.of(model.$1);
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: context.borderRadius,
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Text(
                  'Interactions',
                  style: context.textTheme.titleMedium,
                ),
                const Spacer(),
                ButtonComponent.text(
                  text: 'Add',
                  icon: Icons.add_rounded,
                  onPressed: () => dispatch(AddInteractionAction()),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(12),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: interactions.length,
              itemBuilder: (context, index) {
                final item = interactions[index];
                final isSelected = item.id == model.$2?.id;
                return Card(
                  child: Badge(
                    isLabelVisible: item.isNew,
                    label: const Text('New'),
                    offset: const Offset(-10, 0),
                    child: ListTile(
                      selectedTileColor: context.colorScheme.primaryContainer,
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide(
                          color: isSelected
                              ? Colors.purpleAccent
                              : context.colorScheme.outline,
                        ),
                      ),
                      selectedColor: context.colorScheme.onPrimaryContainer,
                      selected: isSelected,
                      onTap: () {
                        dispatch(SelectInteractionAction(item.id));
                      },
                      title: Text(
                        item.id,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        item.availableSubTypes.isEmpty
                            ? 'No Action'
                            : '${item.eventType} (${item.eventSubtype}) -> ${item.action}',
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  (List<TaleInteraction>, TaleInteraction?) selector(AppState state) => (
        interactionsForPage(state),
        selectedInteraction(state),
      );
}
