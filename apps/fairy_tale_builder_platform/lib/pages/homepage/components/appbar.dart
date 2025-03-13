import 'package:flutter/material.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

class HomepageAppBar extends StatelessWidget {
  const HomepageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
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
          child: TextFieldComponent(hintText: 'Search tales...'),
        ),

        const SizedBox(width: 16),

        //Create tale button
        ButtonComponent.primary(
          text: 'Create Tale',
          icon: Icons.add,
          onPressed: () {},
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
