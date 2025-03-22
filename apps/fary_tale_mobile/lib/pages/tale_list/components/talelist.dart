import 'package:fairy_tale_mobile/pages/tale_list/components/state_result_wrapper.dart';
import 'package:fairy_tale_mobile/pages/tale_list/components/tale.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:shared/shared.dart';

class HomepageTalelist extends StatelessWidget
    with StateConnectorMixin<(StateResult, List<Tale>)> {
  const HomepageTalelist({super.key});

  @override
  Widget builder(
    BuildContext context,
    Dispatcher<AppState> dispatch,
    (StateResult, List<Tale>) model,
  ) {
    return StateResultWrapper(
      result: model.$1,
      onOk: ListView(
        padding: const EdgeInsets.only(top: 64, bottom: 32),
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            runSpacing: 24,
            children: [
              for (final tale in model.$2) HomepageTale(tale: tale),
            ],
          ),
        ],
      ),
    );
  }

  @override
  (StateResult, List<Tale>) selector(AppState state) {
    return (
      state.taleListState.listResult,
      taleList(state),
    );
  }
}
