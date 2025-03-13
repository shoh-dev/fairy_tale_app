import 'package:device_preview/device_preview.dart';
import 'package:fairy_tale_builder_platform/components/hover_widget.dart';
import 'package:fairy_tale_builder_platform/manager/redux/mixin.dart';
import 'package:fairy_tale_builder_platform/manager/redux/selected_tale_state/actions/page_actions.dart';
import 'package:fairy_tale_builder_platform/manager/redux/selected_tale_state/selected_tale_state.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:shared/shared.dart';

class Pagecard extends StatelessWidget with StateConnectorMixin<bool> {
  const Pagecard({
    required this.page,
    super.key,
  });
  final TalePage page;

  @override
  Widget builder(
    BuildContext context,
    Dispatcher<AppState> dispatch,
    bool model,
  ) {
    return HoverWidget(
      onTap: () {
        dispatch(SelectPageAction(page.id));
      },
      isSelected: model,
      child: (hovering) {
        return SizedBox(
          height: Devices.ios.iPhone13.screenSize.height / 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: DeviceFrame(
              device: Devices.ios.iPhone13,
              screen: page.metadata.hasBackgroundImage
                  ? Image.network(
                      page.metadata.backgroundImageUrl,
                      fit: BoxFit.cover,
                    )
                  : const Placeholder(),
            ),
          ),
        );
      },
    );
  }

  @override
  bool selector(AppState state) => selectedPage(state)?.id == page.id;
}
