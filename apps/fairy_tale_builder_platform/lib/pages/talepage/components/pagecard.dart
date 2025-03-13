import 'package:device_preview/device_preview.dart';
import 'package:fairy_tale_builder_platform/components/hover_widget.dart';
import 'package:fairy_tale_builder_platform/manager/redux/mixin.dart';
import 'package:fairy_tale_builder_platform/manager/redux/selected_tale_state/actions/page_actions.dart';
import 'package:fairy_tale_builder_platform/manager/redux/selected_tale_state/selected_tale_state.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:shared/shared.dart';

class Pagecard extends StatelessWidget with StateConnectorMixin<(bool, Tale)> {
  const Pagecard({
    required this.page,
    super.key,
  });
  final TalePage page;

  @override
  Widget builder(
    BuildContext context,
    Dispatcher<AppState> dispatch,
    (bool, Tale) model,
  ) {
    final device = Devices.ios.iPhone13;
    return HoverWidget(
      onTap: () {
        dispatch(SelectPageAction(page.id));
      },
      isSelected: model.$1,
      child: (hovering) {
        return SizedBox(
          height: device.screenSize.height / 2.5,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: _banner(
              Stack(
                alignment: Alignment.center,
                children: [
                  DeviceFrame(
                    orientation: model.$2.isPortrait
                        ? Orientation.portrait
                        : Orientation.landscape,
                    device: device,
                    screen: page.metadata.hasBackgroundImage
                        ? Image.network(
                            page.metadata.backgroundImageUrl,
                            fit: BoxFit.cover,
                          )
                        : const Placeholder(),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Text(page.pageNumber.toString()),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _banner(Widget child) {
    if (page.isNew) {
      return Banner(
        message: 'New',
        location: BannerLocation.topEnd,
        child: child,
      );
    }
    return child;
  }

  @override
  (bool, Tale) selector(AppState state) =>
      (selectedPage(state)?.id == page.id, selectedTale(state));
}
