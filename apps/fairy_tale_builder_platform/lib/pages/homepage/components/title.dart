import 'package:flutter/material.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

class HomepageTitle extends StatelessWidget {
  const HomepageTitle({super.key});

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
