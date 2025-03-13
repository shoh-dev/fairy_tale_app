import 'dart:async';

import 'package:fairy_tale_builder_platform/components/card.dart';
import 'package:fairy_tale_builder_platform/manager/redux/mixin.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:fairy_tale_builder_platform/manager/redux/tale_list_state/tale_list_action.dart';
import 'package:fairy_tale_builder_platform/manager/redux/tale_list_state/tale_list_state.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:shared/shared.dart';

class HomepageTaleList extends StatelessWidget
    with StateConnectorMixin<List<Tale>> {
  const HomepageTaleList({super.key});

  @override
  FutureOr<void> onInitialBuild(
      Dispatcher<AppState> dispatch, List<Tale> model) {
    dispatch(GetTaleListAction());
    return super.onInitialBuild(dispatch, model);
  }

  @override
  Widget builder(
    BuildContext context,
    Dispatcher<AppState> dispatch,
    List<Tale> model,
  ) {
    return SliverToBoxAdapter(
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        runSpacing: 32,
        spacing: 16,
        children: [
          for (final tale in model)
            DefaultCard(
              title: tale.title,
              bottomTitle: tale.id,
              image: NetworkImage(tale.coverImage),
              onTap: () {
                //todo:
              },
            ),
        ],
      ),
    );
  }

  @override
  List<Tale> selector(AppState state) => taleList(state);
}
