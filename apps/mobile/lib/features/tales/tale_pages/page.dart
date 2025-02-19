import 'dart:developer';

import 'package:core_audio/core_audio.dart';
import 'package:flutter/material.dart';
import 'package:mobile/features/tales/tale_pages/components/tale_page_background.dart';
import 'package:mobile/features/tales/tale_pages/components/tale_page_navigator.dart';
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

  @override
  void dispose() {
    safeDispose(() {
      final audioService = context.getDependency<MainAudioPlayerServiceImpl>();
      if (audioService.isPlaying()) {
        stopAudio(audioService);
      }
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

  void pauseAudio(MainAudioPlayerServiceImpl audioService) async {
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

  void stopAudio(MainAudioPlayerServiceImpl audioService) async {
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

  void resumeAudio(MainAudioPlayerServiceImpl audioService) async {
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

    final audioService = context.getDependency<MainAudioPlayerServiceImpl>();
    final bool isAudioPlaying = audioService.isPlaying();

    if (isAudioPlaying) {
      if (state case AppLifecycleState.hidden || AppLifecycleState.inactive || AppLifecycleState.paused) {
        pauseAudio(audioService);
      }
      if (state case AppLifecycleState.detached) {
        stopAudio(audioService);
      }
    } else {
      if (state case AppLifecycleState.resumed) {
        resumeAudio(audioService);
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
    final audioService = context.getDependency<MainAudioPlayerServiceImpl>();
    return Scaffold(
      appBar: AppBar(
        title: TextComponent.any(tale.title),
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
            context.taleTr(tale.description) ?? "-", //todo: handle localization if fetched as all
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
