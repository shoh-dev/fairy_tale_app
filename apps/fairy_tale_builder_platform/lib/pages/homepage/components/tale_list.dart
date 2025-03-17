import 'dart:async';

import 'package:fairy_tale_builder_platform/components/card.dart';
import 'package:fairy_tale_builder_platform/components/loading_component.dart';
import 'package:fairy_tale_builder_platform/manager/redux/mixin.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:fairy_tale_builder_platform/manager/redux/tale_list_state/tale_list_action.dart';
import 'package:fairy_tale_builder_platform/manager/redux/tale_list_state/tale_list_state.dart';
import 'package:fairy_tale_builder_platform/pages/homepage/homepage.dart';
import 'package:fairy_tale_builder_platform/pages/talepage/talepage.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';

class HomepageTaleList extends StatelessWidget
    with StateConnectorMixin<TaleListState> {
  const HomepageTaleList({super.key});

  @override
  FutureOr<void> onInitialBuild(
    Dispatcher<AppState> dispatch,
    TaleListState model,
  ) {
    dispatch(GetTaleListAction());
    return super.onInitialBuild(dispatch, model);
  }

  @override
  Widget builder(
    BuildContext context,
    Dispatcher<AppState> dispatch,
    TaleListState model,
  ) {
    return SliverToBoxAdapter(
      child: model.listResult.when(
        initial: () => const SizedBox(),
        error: (error) => Center(child: Text(error.string())),
        loading: LoadingComponent.new,
        ok: () {
          final tales = model.list;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1),
            child: Wrap(
              runSpacing: 32,
              spacing: 24,
              children: [
                for (final tale in tales)
                  DefaultCard(
                    title: tale.title,
                    bottomTitle: tale.id,
                    image: NetworkImage(tale.coverImage),
                    onTap: () {
                      TalepageRoute(id: tale.id).go(context);
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  TaleListState selector(AppState state) => state.taleListState;
}
