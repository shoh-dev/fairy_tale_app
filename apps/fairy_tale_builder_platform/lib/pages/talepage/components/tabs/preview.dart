import 'package:fairy_tale_builder_platform/components/preview.dart';
import 'package:fairy_tale_builder_platform/manager/redux/mixin.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:fairy_tale_builder_platform/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:shared/shared.dart';

class TalepagePreview extends StatelessWidget
    with StateConnectorMixin<List<TalePage>> {
  const TalepagePreview({super.key});

  @override
  Widget builder(
    BuildContext context,
    Dispatcher<AppState> dispatch,
    List<TalePage> model,
  ) {
    final pages = List.of(model)
      ..sort((a, b) => a.pageNumber > b.pageNumber ? 1 : 0);
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(
        vertical: 120,
        horizontal: 32,
      ),
      separatorBuilder: (context, index) => const SizedBox(
        width: 64,
        child: Icon(Icons.chevron_right_rounded),
      ),
      itemCount: pages.length,
      itemBuilder: (context, index) {
        final page = pages[index];

        return Stack(
          children: [
            Preview(page: page),
            Positioned(
              bottom: 28,
              left: (Sizes.device.screenSize.width / 2) - 26,
              width: 50,
              child: Text(
                page.pageNumber.toString(),
                textAlign: TextAlign.center,
                style: context.textTheme.headlineSmall,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  List<TalePage> selector(AppState state) => state.selectedTaleState.pages;
}
