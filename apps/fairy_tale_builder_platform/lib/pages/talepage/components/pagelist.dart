import 'package:fairy_tale_builder_platform/manager/redux/mixin.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:shared/shared.dart';

class TalepagePagesList extends StatelessWidget
    with StateConnectorMixin<List<TalePage>> {
  const TalepagePagesList({super.key});

  @override
  Widget builder(
    BuildContext context,
    Dispatcher<AppState> dispatch,
    List<TalePage> model,
  ) {
    return Container(
      width: 320,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        border: Border(
          right: BorderSide(color: Colors.grey.shade800),
          top: BorderSide(color: Colors.grey.shade800),
        ),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(16),
          // bottomRight: Radius.circular(16),
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                'Pages',
                style: context.textTheme.titleMedium,
              ),
              const Spacer(),
              ButtonComponent.text(
                text: 'Add',
                icon: Icons.add_rounded,
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  List<TalePage> selector(AppState state) {
    return state.selectedTaleState.pages;
  }
}
