import 'package:fairy_tale_builder_platform/pages/homepage/components/appbar.dart';
import 'package:fairy_tale_builder_platform/pages/homepage/components/tale_list.dart';
import 'package:fairy_tale_builder_platform/pages/homepage/components/title.dart';
import 'package:fairy_tale_builder_platform/pages/talepage/talepage.dart';
import 'package:fairy_tale_builder_platform/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:shared/shared.dart';

part 'homepage.g.dart';

@TypedGoRoute<HomepageRoute>(
  path: '/',
  routes: [
    TypedGoRoute<TalepageRoute>(
      path: 'tale/:id',
    ),
  ],
)
class HomepageRoute extends GoRouteData {
  const HomepageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      UserExceptionDialog<AppState>(
        child: const Homepage(),
      );
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  SliverToBoxAdapter space(double space) {
    return SliverToBoxAdapter(
      child: SizedBox(height: space),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: Sizes.kMaxWidth,
          child: CustomScrollView(
            slivers: [
              //AppBar
              const HomepageAppBar(),

              //space
              space(32),

              //Title and Description
              const HomepageTitle(),

              //space
              space(40),

              //tale list
              const HomepageTaleList(),
            ],
          ),
        ),
      ),
    );
  }
}
