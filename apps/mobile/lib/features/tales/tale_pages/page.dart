import 'package:flutter/material.dart';
import 'package:mobile/features/tales/tale_pages/components/background.dart';
import 'package:mobile/features/tales/tale_pages/components/page_navigator.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:myspace_design_system/utils/helpers/context.dart';

import 'components/tale_object.dart';

class TalePagesPage extends StatefulWidget {
  const TalePagesPage({
    super.key,
    required this.taleId,
  });

  final String taleId;

  @override
  State<TalePagesPage> createState() => _TalePagesPageState();
}

class _TalePagesPageState extends State<TalePagesPage> with StateHelpers {
  final pageController = PageController();

  @override
  void dispose() {
    safeDispose(pageController.dispose);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    afterBuild(() {
      // pageController.addListener(() {
      //   if (pageController.page == pageController.page?.toInt()) {
      //     setState(() {});
      //   }
      // });
    });
  }

  Offset objectPos = const Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    return StatusStatusWrapper(
        converter: (store) => store.state.taleState.status,
        onInitialBuild: (context, store, viewModel) async {
          store.dispatch(LoadTaleAction(widget.taleId));
        },
        onDispose: (store) {
          store.dispatch(LoadTaleAction(widget.taleId, reset: true));
        },
        child: (context, vm) {
          return Scaffold(
            body: vm.fold(
              (ok) {
                return StoreConnector<AppState, Tale>(
                    converter: (store) => store.state.taleState.selectedTale,
                    builder: (context, vm) {
                      return _TaleView(
                        tale: vm,
                        pageController: pageController,
                      );
                    });
              },
              (error) {
                return Center(
                  child: TextComponent.any(error.toString()),
                );
              },
              () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          );
        });
  }
}

class _TaleView extends StatelessWidget {
  const _TaleView({
    required this.tale,
    required this.pageController,
  });

  final PageController pageController;
  final Tale tale;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextComponent.any(tale.title),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Text(
            tale.description,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: LayoutBuilder(builder: (context, cc) {
        return PageView.builder(
          controller: pageController,
          itemCount: tale.pages.length,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            final page = tale.pages[index];
            return Stack(
              children: [
                //image
                if (page.image.isNotEmpty) Positioned.fill(child: TalePageBackroundComponent(imageUrl: page.image)),

                for (var interaction in page.interactions)
                  //tale object
                  AnimatedPositioned(
                    // curve: Curves.easeInOutCubicEmphasized,
                    duration: Duration(milliseconds: interaction.animationDuration),
                    width: interaction.size.width,
                    height: interaction.size.height,
                    left: interaction.currentPosition.dx,
                    top: interaction.currentPosition.dy,
                    child: TaleInteractionObjectComponent(
                      interaction: interaction,
                    ),
                  ),
              ],
            );
          },
        );
      }),
      bottomNavigationBar: BottomAppBar(
        child: TalePageNavigatorComponent(
          controller: pageController,
          totalPages: tale.pages.length,
          interactions: pageController.hasClients ? tale.pages[pageController.page?.toInt() ?? 0].interactions : tale.pages.first.interactions,
        ),
      ),
    );
  }
}
