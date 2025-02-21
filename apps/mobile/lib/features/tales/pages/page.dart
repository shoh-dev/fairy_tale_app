import 'dart:developer';

import 'package:core_audio/core_audio.dart';
import 'package:flutter/material.dart';
import 'package:mobile/features/tales/pages/components/tale_page_background.dart';
import 'package:mobile/features/tales/pages/components/tale_page_navigator.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:myspace_design_system/utils/helpers/context.dart';

import 'components/tale_interaction_object.dart';

class TalePagesPage extends StatefulWidget {
  const TalePagesPage({
    super.key,
    required this.taleId,
  });

  final String taleId;

  @override
  State<TalePagesPage> createState() => _TalePagesPageState();
}

class _TalePagesPageState extends State<TalePagesPage> with StateHelpers, WidgetsBindingObserver {
  final pageController = PageController();

  InteractionAudioPlayerServiceImpl audioService(BuildContext context) {
    return context.getDependency<InteractionAudioPlayerServiceImpl>();
  }

  @override
  void dispose() {
    safeDispose(() {
      stopAudio(audioService(context));
      pageController.dispose();
      WidgetsBinding.instance.removeObserver(this);
    });
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    afterBuild(() {});
  }

  void pauseAudio(InteractionAudioPlayerServiceImpl audioService) async {
    final paused = await audioService.pause();
    paused.fold(
      (ok) {
        log("audio paused");
      },
      (error) {
        log(error.toString());
      },
    );
  }

  void stopAudio(InteractionAudioPlayerServiceImpl audioService) async {
    final stopped = await audioService.stop();
    stopped.fold(
      (ok) {
        log("audio stopped");
      },
      (error) {
        log(error.toString());
      },
    );
  }

  void resumeAudio(InteractionAudioPlayerServiceImpl audioService) async {
    final resumed = await audioService.play();
    resumed.fold(
      (ok) {
        log("audio resumed");
      },
      (error) {
        log(error.toString());
      },
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    log(state.toString());

    final bool isAudioPlaying = audioService(context).isPlaying();

    if (isAudioPlaying) {
      if (state case AppLifecycleState.hidden || AppLifecycleState.inactive || AppLifecycleState.paused) {
        pauseAudio(audioService(context));
      }
      if (state case AppLifecycleState.detached) {
        stopAudio(audioService(context));
      }
    } else {
      if (state case AppLifecycleState.resumed) {
        resumeAudio(audioService(context));
      }
    }
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
        builder: (context, vm) {
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
    final audioService = context.getDependency<InteractionAudioPlayerServiceImpl>();
    return Scaffold(
      appBar: AppBar(
        title: TextComponent.any(context.taleTr(tale.title)),
        actions: [
          StreamBuilder(
              stream: audioService.isPlayingStream,
              builder: (context, snapshot) {
                if (snapshot.data == true) {
                  return const Tooltip(
                    triggerMode: TooltipTriggerMode.tap,
                    message: 'Audio is playing',
                    child: Icon(Icons.pause),
                  );
                }
                return const SizedBox();
              }),
          const SizedBox(width: 10),
        ],
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Text(
            context.taleTr(tale.description),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: LayoutBuilder(builder: (context, cc) {
        return PageView.builder(
          controller: pageController,
          itemCount: tale.talePages.length,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            final page = tale.talePages[index];
            return Stack(
              children: [
                //image
                if (page.backgroundImage.isNotEmpty) Positioned.fill(child: TalePageBackroundComponent(imageUrl: page.backgroundImage)),

                for (var interaction in page.taleInteractions)
                  //tale object
                  AnimatedPositioned(
                    // curve: Curves.easeInOutCubicEmphasized,//todo: get curve from db
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
          totalPages: tale.talePages.length,
          interactions: pageController.hasClients ? tale.talePages[pageController.page?.toInt() ?? 0].taleInteractions : tale.talePages.first.taleInteractions,
        ),
      ),
    );
  }
}
