import 'package:fairy_tale_builder_platform/components/card.dart';
import 'package:fairy_tale_builder_platform/components/loading_component.dart';
import 'package:fairy_tale_builder_platform/pages/talepage/talepage.dart';
import 'package:fairy_tale_builder_platform/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
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
              const _AppBar(),

              //space
              space(32),

              //Title and Description
              const _Title(),

              //space
              space(40),

              //tale list
              const _List(),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget with DispatchConnectorMixin {
  const _AppBar();

  @override
  Widget builder(BuildContext context, Dispatcher<AppState> dispatch) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      leading: Align(
        child: Text(
          'StoryLab',
          style: context.textTheme.titleLarge!.copyWith(
            color: Colors.purpleAccent,
          ),
        ),
      ),
      leadingWidth: 100,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          ButtonComponent.text(
            text: 'Home',
            onPressed: () {
              const HomepageRoute().go(context);
            },
          ),
        ],
      ),
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: Divider(height: 0),
      ),
      actions: [
        //search bar,
        SizedBox(
          width: 240,
          child: TextFieldComponent(
            maxLines: 1,
            hintText: 'Search tales...',
            onChanged: (value) {
              dispatch(UpdateSearchQueryAction(value));
            },
            suffixWidgets: (q) => [
              ButtonComponent.icon(
                icon: Icons.search,
                onPressed:
                    q.isEmpty ? null : () => dispatch(GetTaleListAction()),
              ),
            ],
          ),
        ),

        const SizedBox(width: 16),

        //Create tale button
        ButtonComponent.primary(
          text: 'Create Tale',
          icon: Icons.add,
          onPressed: () {
            TalepageRoute(id: 'new').go(context);
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [
          Text(
            'My Tales',
            style: context.textTheme.headlineLarge,
          ),
          Text(
            'Continue working on your interactive stories',
            style: context.textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}

class _List extends StatelessWidget with StateConnectorMixin<TaleListState> {
  const _List();

  @override
  void onInitialBuild(
    Dispatcher<AppState> dispatch,
    TaleListState model,
  ) {
    dispatch(GetTaleListAction());
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
            padding: const EdgeInsets.symmetric(horizontal: 2),
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
