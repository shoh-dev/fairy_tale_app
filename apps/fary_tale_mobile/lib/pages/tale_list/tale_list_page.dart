import 'dart:async';
import 'package:fairy_tale_mobile/components/icon_button.dart';
import 'package:fairy_tale_mobile/components/safearea.dart';
import 'package:fairy_tale_mobile/pages/tale_list/components/left_buttons.dart';
import 'package:fairy_tale_mobile/pages/tale_list/components/right_buttons.dart';
import 'package:fairy_tale_mobile/pages/tale_list/components/searchbar.dart';
import 'package:fairy_tale_mobile/pages/tale_list/components/tale.dart';
import 'package:fairy_tale_mobile/pages/tale_list/components/talelist.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:shared/shared.dart';

class TaleListPage extends StatelessWidget with DispatchConnectorMixin {
  const TaleListPage({super.key});

  static const route = '/tale_list';

  @override
  void onInitialBuild(Dispatcher<AppState> dispatch) {
    dispatch(GetTaleListAction());
  }

  @override
  Widget builder(BuildContext context, Dispatcher<AppState> dispatch) {
    return Scaffold(
      body: AppSafeArea(
        child: RefreshIndicator.adaptive(
          onRefresh: () {
            dispatch(GetTaleListAction());
            return Future<void>.value();
          },
          child: const _Tales(),
        ),
      ),
    );
  }
}

class _Tales extends StatelessWidget {
  const _Tales();

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        Positioned(
          left: 4,
          top: 4,
          child: HomepageLeftButtons(),
        ),
        Positioned(
          right: 4,
          top: 4,
          child: HomepageRightButtons(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 32 * 2),
            Expanded(
              child: HomepageTalelist(),
            ),
            SizedBox(width: 32 * 2),
          ],
        ),
        Positioned.fill(
          top: 4,
          child: Align(
            alignment: Alignment.topCenter,
            child: HomepageSearchBar(),
          ),
        ),
      ],
    );
  }
}
