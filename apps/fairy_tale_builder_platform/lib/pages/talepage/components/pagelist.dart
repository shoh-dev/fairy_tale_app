import 'package:fairy_tale_builder_platform/components/loading_component.dart';
import 'package:fairy_tale_builder_platform/pages/talepage/components/pagecard.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:shared/shared.dart';

class TalepagePagesList extends StatelessWidget
    with StateConnectorMixin<(StateResult, List<TalePage>)> {
  const TalepagePagesList({super.key});

  @override
  Widget builder(
    BuildContext context,
    Dispatcher<AppState> dispatch,
    (StateResult, List<TalePage>) model,
  ) {
    final pages = List.of(model.$2)
      ..sort((a, b) => a.pageNumber > b.pageNumber ? 1 : 0);
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
                  'Pages',
                  style: context.textTheme.titleMedium,
                ),
                const Spacer(),
                ButtonComponent.text(
                  text: 'Add',
                  icon: Icons.add_rounded,
                  onPressed: () {
                    dispatch(AddPageAction());
                  },
                ),
              ],
            ),
          ),
          model.$1.when(
            ok: () {
              if (pages.isEmpty) {
                return Text(
                  'No pages. Add one!',
                  style: context.textTheme.titleMedium,
                );
              }
              return Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(12),
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: pages.length,
                  itemBuilder: (context, index) {
                    final page = pages[index];
                    return Pagecard(page: page);
                  },
                ),
              );
            },
            initial: () => const SizedBox(),
            loading: LoadingComponent.new,
            error: (error) => Center(child: Text(error.string())),
          ),
        ],
      ),
    );
  }

  @override
  (StateResult, List<TalePage>) selector(AppState state) {
    return (state.selectedTaleState.taleResult, state.selectedTaleState.pages);
  }
}
