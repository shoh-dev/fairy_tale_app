import 'package:fairy_tale_builder_platform/manager/redux/mixin.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:fairy_tale_builder_platform/manager/redux/tale_list_state/tale_list_action.dart';
import 'package:fairy_tale_builder_platform/pages/homepage/homepage.dart';
import 'package:fairy_tale_builder_platform/pages/talepage/talepage.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

class HomepageAppBar extends StatelessWidget with DispatchConnectorMixin {
  const HomepageAppBar({super.key});

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
      leadingWidth: 140,
      automaticallyImplyLeading: false,
      toolbarHeight: 68,
      title: const Row(
        spacing: 16,
        children: [
          Text('Home'),
          Text('Explore'),
          Text('Templates'),
          Text('Community'),
        ],
      ),
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(4),
        child: Divider(),
      ),
      actions: [
        //search bar,
        SizedBox(
          width: 240,
          child: TextFieldComponent(
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
            TalepageRoute(id: 'new').push<void>(context);
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
