import 'package:fairy_tale_builder_platform/components/loading_component.dart';
import 'package:fairy_tale_builder_platform/manager/redux/mixin.dart';
import 'package:fairy_tale_builder_platform/manager/redux/selected_tale_state/actions/page_actions.dart';
import 'package:fairy_tale_builder_platform/manager/redux/selected_tale_state/selected_tale_state.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:fairy_tale_builder_platform/pages/talepage/components/pagecard.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:shared/shared.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TalepagePagesList extends StatelessWidget
    with StateConnectorMixin<(StateResult, List<TalePage>)> {
  const TalepagePagesList({super.key});

  @override
  @override
  Widget builder(
    BuildContext context,
    Dispatcher<AppState> dispatch,
    (StateResult, List<TalePage>) model,
  ) {
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
          // bottomRight: Radius.circular(16),
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
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
          const SizedBox(height: 16),
          model.$1.when(
            ok: () {
              return Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 32),
                  itemCount: model.$2.length,
                  itemBuilder: (context, index) {
                    final page = model.$2[index];
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
