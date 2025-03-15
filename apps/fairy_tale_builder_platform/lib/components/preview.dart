import 'package:device_preview/device_preview.dart';
import 'package:fairy_tale_builder_platform/components/interaction_object.dart';
import 'package:fairy_tale_builder_platform/components/page_background.dart';
import 'package:fairy_tale_builder_platform/manager/redux/mixin.dart';
import 'package:fairy_tale_builder_platform/manager/redux/selected_tale_state/selected_tale_state.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:fairy_tale_builder_platform/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:shared/shared.dart';

class Preview extends StatelessWidget
    with StateConnectorMixin<(Tale, TalePage?, List<TaleInteraction>)> {
  const Preview({
    super.key,
    this.page,
  });

  final TalePage? page;

  @override
  Widget builder(
    BuildContext context,
    Dispatcher<AppState> dispatch,
    (Tale, TalePage?, List<TaleInteraction>) model,
  ) {
    final device = Sizes.device;
    final tale = model.$1;
    final page = model.$2;
    final interactions = model.$3;

    return Hero(
      tag: page?.id ?? '-',
      child: DeviceFrame(
        orientation:
            tale.isPortrait ? Orientation.portrait : Orientation.landscape,
        device: device,
        screen: page == null
            ? Center(
                child: Text(
                  'No page selected',
                  style: context.textTheme.titleLarge,
                ),
              )
            : Stack(
                children: [
                  //image
                  Positioned.fill(
                    child: PageBackground(
                      url: page.metadata.backgroundImageUrl,
                    ),
                  ),

                  for (final interaction in interactions)
                    //tale object
                    InteractionObject(interaction: interaction),
                ],
              ),
      ),
    );
  }

  @override
  (Tale, TalePage?, List<TaleInteraction>) selector(AppState state) {
    if (page != null) {
      return (
        selectedTale(state),
        page,
        state.selectedTaleState.interactions
            .where((element) => element.talePageId == page?.id)
            .toList(),
      );
    }
    return (
      selectedTale(state),
      selectedPage(state),
      interactionsForPage(state),
    );
  }

  static Future<void> dialog(BuildContext context) {
    return Navigator.push<void>(
      context,
      HeroDialogRoute(
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              children: [
                const Text('Page Preview'),
                const Spacer(),
                ButtonComponent.iconOutlined(
                  icon: Icons.close_rounded,
                  onPressed: Navigator.of(context).pop,
                ),
              ],
            ),
            content: const Preview(),
          );
        },
      ),
    );
  }
}

class HeroDialogRoute<T> extends PageRoute<T> {
  HeroDialogRoute({required this.builder});

  final WidgetBuilder builder;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get maintainState => true;

  @override
  Color get barrierColor => Colors.black54;

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
      child: child,
    );
  }

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return builder(context);
  }

  @override
  String? get barrierLabel => 'Preview';
}


// Stack(
//         children: [
//           //image
//           if (page.metadata.hasBackgroundImage)
//             Positioned.fill(
//               child: SelectedTalePageBackroundComponent(
//                 imageUrl: page.metadata.backgroundImageUrl,
//               ),
//             ),

//           for (final interaction in interactions)
//             //tale object
//             Builder(
//               builder: (context) {
//                 return AnimatedPositioned(
//                   // curve: Curves.ease, //todo: get curve from db
//                   duration: Duration(
//                     milliseconds: interaction.animationDuration,
//                   ),
//                   width: interaction.size.width,
//                   height: interaction.size.height,
//                   left: interaction.currentPosition.dx,
//                   top: interaction.currentPosition.dy,
//                   child: SelectedTaleInteractionObjectComponent(
//                     interaction: interaction,
//                   ),
//                 );
//               },
//             ),
//         ],
//       )