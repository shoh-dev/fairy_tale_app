import 'dart:developer';

import 'package:fairy_tale_mobile/components/lifecycle_component.dart';
import 'package:fairy_tale_mobile/components/translator_component.dart';
import 'package:fairy_tale_mobile/manager/redux.dart';
import 'package:fairy_tale_mobile/pages/tale_list/selected_tale/components/selected_tale_interaction_object.dart';
import 'package:fairy_tale_mobile/pages/tale_list/selected_tale/components/selected_tale_page_background.dart';
import 'package:fairy_tale_mobile/pages/tale_list/selected_tale/components/selected_tale_page_navigator.dart';
import 'package:fairy_tale_mobile/pages/tale_list/selected_tale/components/tale_page_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:shared/shared.dart';

class SelectedTalePage extends StatefulWidget {
  const SelectedTalePage({
    required this.taleId,
    super.key,
  });

  final String taleId;

  @override
  State<SelectedTalePage> createState() => _SelectedTalePageState();
}

class _SelectedTalePageState extends State<SelectedTalePage> with StateHelpers {
  final pageController = PageController();

  @override
  void dispose() {
    safeDispose(pageController.dispose);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    safeInitialize(() {});
  }

  @override
  Widget build(BuildContext context) {
    return StateConnector<AppState, TaleState>(
      selector: (state) => state.taleListState.taleState,
      onInitialBuild: (dispatch, viewModel) async {
        dispatch(GetTaleAction(widget.taleId));
      },
      onDispose: (dispatch) {
        dispatch(GetTaleAction(widget.taleId, reset: true));
      },
      builder: (context, dispatch, vm) {
        return Scaffold(
          body: vm.selectedTaleResult.when(
            ok: () {
              return _TaleView(
                tale: vm.selectedTale,
                pageController: pageController,
              );
            },
            error: (error) {
              return Center(
                child: TextComponent.any(error.toString()),
              );
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            },
            initial: () {
              return const SizedBox();
            },
          ),
        );
      },
    );
  }
}

class _TaleView extends StatefulWidget {
  const _TaleView({
    required this.tale,
    required this.pageController,
  });

  final PageController pageController;
  final Tale tale;

  @override
  State<_TaleView> createState() => _TaleViewState();
}

class _TaleViewState extends State<_TaleView>
    with StateHelpers, WidgetsBindingObserver {
  Tale get tale => widget.tale;

  AudioPlayerService get backgroundAudioPlayer => tale.audioPlayerService;

  bool isAnyAudioPlaying(BuildContext context) {
    return
        // interactionAudioPlayer.isPlaying() ||
        backgroundAudioPlayer.isPlaying();
  }

  Future<void> pauseAudio(AudioPlayerService audioService) async {
    final paused = await audioService.pause();
    paused.when(
      ok: (ok) {
        log('audio paused');
      },
      error: (error) {
        log(error.toString());
      },
    );
  }

  Future<void> stopAudio(AudioPlayerService audioService) async {
    final stopped = await audioService.stop();
    stopped.when(
      ok: (ok) {
        log('audio stopped');
      },
      error: (error) {
        log(error.toString());
      },
    );
  }

  Future<void> resumeAudio(AudioPlayerService audioService) async {
    final resumed = await audioService.play();
    resumed.when(
      ok: (ok) {
        log('audio resumed');
      },
      error: (error) {
        log(error.toString());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LifecycleComponent(
      onDispose: () async {
        await Future.wait([
          context
              .getDependency<DependencyInjection>()
              .deviceService
              .setDeviceOrientation([
            DeviceOrientation.portraitDown,
            DeviceOrientation.portraitUp,
          ]),
          if (backgroundAudioPlayer.isPlaying())
            stopAudio(backgroundAudioPlayer),
        ]); //todo: handle error
        tale.disposeAudioPlayers();
      },
      onInitialize: () async {
        await Future.wait([
          if (!tale.isPortrait)
            context
                .getDependency<DependencyInjection>()
                .deviceService
                .setDeviceOrientation([
              DeviceOrientation.landscapeLeft,
              DeviceOrientation.landscapeRight,
            ]),
          if (tale.metadata.hasBackgroundAudio) tale.playAudio(),
        ]); //todo: handle error
      },
      onAppBackground: () {
        if (backgroundAudioPlayer.isPlaying()) {
          pauseAudio(backgroundAudioPlayer);
        }
      },
      onAppClosed: () {
        if (backgroundAudioPlayer.isPlaying()) {
          stopAudio(backgroundAudioPlayer);
        }
      },
      onAppResumed: () {
        resumeAudio(backgroundAudioPlayer);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Translator(
            toTranslate: [
              tale.title,
            ],
            builder: (translatedValue) {
              return TextComponent.any(translatedValue[0]);
            },
          ),
          actions: [
            // StreamBuilder(
            //   stream: interactionAudioPlayer.playerStateStream,
            //   builder: (context, snapshot) {
            //     log('Interaction: ${snapshot.data?.playing}');
            //     log('Interaction: ${snapshot.data?.processingState}');
            //     if (snapshot.data != null) {
            //       final isPlaying = snapshot.data!.processingState ==
            //               ProcessingState.ready &&
            //           snapshot.data!.playing == true;
            //       final isBuffering = snapshot.data!.processingState ==
            //           ProcessingState.buffering;
            //       if (isBuffering) {
            //         return const Center(
            //           child: CircularProgressIndicator.adaptive(),
            //         );
            //       }
            //       if (isPlaying) {
            //         return const Tooltip(
            //           triggerMode: TooltipTriggerMode.tap,
            //           message: 'Interaction audio is playing',
            //           child: Icon(Icons.audiotrack),
            //         );
            //       }
            //     }
            //     return const SizedBox();
            //   },
            // ),
            StreamBuilder(
              stream: backgroundAudioPlayer.playerStateStream,
              builder: (context, snapshot) {
                log('Background: ${snapshot.data?.playing}');
                log('Background: ${snapshot.data?.processingState}');
                if (snapshot.data != null) {
                  final isPlaying =
                      snapshot.data!.processingState == ProcessingState.ready &&
                          snapshot.data!.playing == true;
                  final isBuffering = snapshot.data!.processingState ==
                      ProcessingState.buffering;
                  if (isBuffering) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                  if (isPlaying) {
                    return const Tooltip(
                      triggerMode: TooltipTriggerMode.tap,
                      message: 'Background audio is playing',
                      child: Icon(Icons.audiotrack),
                    );
                  }
                }
                return const SizedBox();
              },
            ),
            const SizedBox(width: 10),
          ],
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: Translator(
              toTranslate: [
                tale.description,
              ],
              builder: (translatedValue) {
                return Text(
                  translatedValue[0],
                  textAlign: TextAlign.center,
                );
              },
            ),
          ),
        ),
        body: LayoutBuilder(
          builder: (context, cc) {
            return PageView.builder(
              controller: widget.pageController,
              itemCount: tale.pages.length,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                final page = tale.pages[index];
                return TalePageComponent(page: page);
              },
            );
          },
        ),
        // bottomNavigationBar: BottomAppBar(
        // child: SelectedTalePageNavigatorComponent(
        // controller: widget.pageController,
        // totalPages: tale.pages.length,
        // interactions:
        // tale.pages.isNotEmpty && widget.pageController.hasClients
        // ? tale.pages[widget.pageController.page?.toInt() ?? 0]
        // .interactions
        // : tale.pages.first.interactions,
        // ),//todo: handle if ther is not interactions
        // ),
      ),
    );
  }
}
