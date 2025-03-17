import 'package:fairy_tale_builder_platform/manager/redux/mixin.dart';
import 'package:fairy_tale_builder_platform/manager/redux/selected_tale_state/actions/interaction_actions.dart';
import 'package:fairy_tale_builder_platform/manager/redux/selected_tale_state/selected_tale_state.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:shared/shared.dart';

class TalepageInteractionsList extends StatelessWidget
    with StateConnectorMixin<(List<TaleInteraction>, TaleInteraction?)> {
  const TalepageInteractionsList({super.key});

  @override
  @override
  Widget builder(
    BuildContext context,
    Dispatcher<AppState> dispatch,
    (List<TaleInteraction>, TaleInteraction?) model,
  ) {
    final interactions = List.of(model.$1);
    return Container(
      width: 320,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        border: Border(
          right: BorderSide(color: Colors.grey.shade800),
          top: BorderSide(color: Colors.grey.shade800),
        ),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(16),
        ),
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
                  onPressed: () {
                    dispatch(AddInteractionAction());
                  },
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
