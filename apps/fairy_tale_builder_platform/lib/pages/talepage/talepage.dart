import 'package:fairy_tale_builder_platform/pages/talepage/components/appbar.dart';
import 'package:fairy_tale_builder_platform/pages/talepage/tabs/pages.dart';
import 'package:fairy_tale_builder_platform/pages/talepage/tabs/interactions.dart';
import 'package:fairy_tale_builder_platform/pages/talepage/tabs/preview.dart';
import 'package:fairy_tale_builder_platform/pages/talepage/tabs/tale.dart';
import 'package:fairy_tale_builder_platform/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:shared/shared.dart';

class TalepageRoute extends GoRouteData {
  TalepageRoute({required this.id});
  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      Talepage(taleId: id);
}

class Talepage extends StatefulWidget {
  const Talepage({
    required this.taleId,
    super.key,
  });

  final String taleId;

  @override
  State<Talepage> createState() => _TalepageState();
}

class _TalepageState extends State<Talepage>
    with SingleTickerProviderStateMixin, DispatchConnectorMixinState<Talepage> {
  late final TabController controller;

  @override
  void initState() {
    controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void onDispose(Dispatcher<AppState> dispatch) {
    dispatch(ResetTaleAction());
  }

  @override
  void onInitialBuild(Dispatcher<AppState> dispatch) {
    dispatch(
      GetTaleAction(taleId: widget.taleId == 'new' ? '' : widget.taleId),
    );
  }

  @override
  Widget builder(BuildContext context, Dispatcher<AppState> dispatch) {
    return Scaffold(
      appBar: TalepageAppBar(controller: controller),
      body: Center(
        child: SizedBox(
          width: Sizes.kMaxWidth,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: controller,
                  children: const [
                    //Tale
                    TalepageTale(),

                    //pages
                    TalepagePages(),

                    //interactions
                    TalepageInteractions(),
                  ],
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
