import 'package:flutter/material.dart';
import 'package:mobile/features/tales/tale_pages/components/background.dart';
import 'package:mobile/features/tales/tale_pages/components/page_navigator.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:myspace_design_system/utils/helpers/context.dart';
import 'package:myspace_redux/myspace_redux.dart';

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
    return StoreConnector<AppState, Result<Tale>>(
        converter: (store) => store.state.talesState.selectedTale,
        onInitialBuild: (context, store, viewModel) async {
          store.dispatch(LoadTaleAction(widget.taleId));
        },
        onDispose: (store) {
          store.dispatch(LoadTaleAction(widget.taleId, reset: true));
        },
        builder: (context, vm) {
          return Scaffold(
            body: vm.fold(
              (ok) {
                return Scaffold(
                  appBar: AppBar(
                    title: TextComponent.any(ok.title),
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(40),
                      child: Text(
                        ok.description,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  body: LayoutBuilder(builder: (context, cc) {
                    return PageView.builder(
                      controller: pageController,
                      itemCount: ok.pages.length,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        final page = ok.pages[index];
                        return Stack(
                          children: [
                            //image
                            if (page.image.isNotEmpty) Positioned.fill(child: TalePageBackroundComponent(imageUrl: page.image)),

                            for (var interaction in page.interactions)
                              //tale object
                              Positioned(
                                // left: objectPos.dx,
                                // top: objectPos.dy,
                                width: interaction.size.width,
                                height: interaction.size.height,
                                left: interaction.initialPosition.dx,
                                top: interaction.initialPosition.dy,
                                child: TaleInteractionObjectComponent(
                                  onDrag: (value) {
                                    // final oldPos = objectPos;
                                    // objectPos += value;
                                    // if (objectPos.dx < 0) {
                                    //   objectPos = Offset(0, objectPos.dy);
                                    // } else if (objectPos.dx > (cc.maxWidth - 40)) {
                                    //   //-40 is the size of the object
                                    //   objectPos = Offset((cc.maxWidth - 40), objectPos.dy);
                                    // }
                                    // if (objectPos.dy < 0) {
                                    //   objectPos = Offset(objectPos.dx, 0);
                                    // } else if (objectPos.dy > (cc.maxHeight - 40)) {
                                    //   //-40 is the size of the object
                                    //   objectPos = Offset(objectPos.dx, (cc.maxHeight - 40));
                                    // }
                                    // if (oldPos != objectPos) {
                                    //   setState(() {});
                                    // }
                                  },
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
                      totalPages: ok.pages.length,
                    ),
                  ),
                );
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
