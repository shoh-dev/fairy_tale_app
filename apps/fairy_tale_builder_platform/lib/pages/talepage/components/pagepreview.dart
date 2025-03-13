import 'package:device_preview/device_preview.dart';
import 'package:fairy_tale_builder_platform/manager/redux/mixin.dart';
import 'package:fairy_tale_builder_platform/manager/redux/selected_tale_state/selected_tale_state.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:fairy_tale_builder_platform/pages/talepage/components/pagecard.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:shared/shared.dart';

class TalepagePagePreview extends StatelessWidget
    with StateConnectorMixin<(Tale, TalePage?)> {
  const TalepagePagePreview({super.key});

  @override
  @override
  Widget builder(
    BuildContext context,
    Dispatcher<AppState> dispatch,
    (Tale, TalePage?) model,
  ) {
    final page = model.$2;
    final tale = model.$1;

    if (page == null) {
      return Text(
        'No page selected. Select one!',
        style: context.textTheme.titleMedium,
      );
    }
    final device = Devices.ios.iPhone13;

    return Container(
      width: 320,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        border: Border(
          left: BorderSide(color: Colors.grey.shade800),
          top: BorderSide(color: Colors.grey.shade800),
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Text(
                  'Preview',
                  style: context.textTheme.titleMedium,
                ),
                const Spacer(),
                ButtonComponent.text(
                  text: 'Expand',
                  icon: Icons.expand_rounded,
                  onPressed: () {
                    //todo:
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: DeviceFrame(
              orientation: tale.isPortrait
                  ? Orientation.portrait
                  : Orientation.landscape,
              device: device,
              screen: page.metadata.hasBackgroundImage
                  ? Image.network(
                      page.metadata.backgroundImageUrl,
                      fit: BoxFit.cover, //todo: show interactions as well
                    )
                  : const Placeholder(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  (Tale, TalePage?) selector(AppState state) =>
      (selectedTale(state), selectedPage(state));
}
