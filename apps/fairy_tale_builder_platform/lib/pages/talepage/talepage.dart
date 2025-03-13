import 'dart:async';

import 'package:fairy_tale_builder_platform/manager/redux/mixin.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:fairy_tale_builder_platform/pages/talepage/components/appbar.dart';
import 'package:fairy_tale_builder_platform/pages/talepage/components/editor.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myspace_data/myspace_data.dart';

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
    with SingleTickerProviderStateMixin {
  late final TabController controller;

  @override
  void initState() {
    controller = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TalepageAppBar(controller: controller),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller,
              children: const [
                //editor
                TalepageEditor(),
                //interactions
                SizedBox(),
                //preview
                SizedBox(),
                //settings
                SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
