import 'dart:developer';

import 'package:fairy_tale_mobile/components/translator_component.dart';
import 'package:fairy_tale_mobile/manager/redux.dart';
import 'package:fairy_tale_mobile/pages/tale_list/selected_tale/components/selected_tale_interaction_object.dart';
import 'package:fairy_tale_mobile/pages/tale_list/selected_tale/components/selected_tale_page_background.dart';
import 'package:fairy_tale_mobile/pages/tale_list/selected_tale/components/selected_tale_page_navigator.dart';
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

class _SelectedTalePageState extends State<SelectedTalePage>
    with StateHelpers, WidgetsBindingObserver {
  final pageController = PageController();

  AudioPlayerService interactionAudioService(BuildContext context) {
    return context
        .getDependency<DependencyInjection>()
        .interactionAudioPlayerService;
  }

  AudioPlayerService backgroundAudioService(BuildContext context) {
    return context
        .getDependency<DependencyInjection>()
        .backgroundAudioPlayerService;
  }

  bool isAnyAudioPlaying(BuildContext context) {
    return interactionAudioService(context).isPlaying() ||
        backgroundAudioService(context).isPlaying();
  }

  @override
  void dispose() {
    safeDispose(() {
      if (interactionAudioService(context).isPlaying()) {
        stopAudio(interactionAudioService(context));
      }
      if (backgroundAudioService(context).isPlaying()) {
        stopAudio(backgroundAudioService(context));
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
    safeInitialize(() {});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    Log('SelectedTalePage').debug(state.toString());
    log(state.toString());

    final isInteractionAudioPlaying =
        interactionAudioService(context).isPlaying();
    final isBackgroundAudioPlaying =
        backgroundAudioService(context).isPlaying();

    if (isInteractionAudioPlaying || isBackgroundAudioPlaying) {
      if (state
          case AppLifecycleState.hidden ||
              AppLifecycleState.inactive ||
              AppLifecycleState.paused) {
        if (isInteractionAudioPlaying) {
          pauseAudio(interactionAudioService(context));
        }
        if (isBackgroundAudioPlaying) {
          pauseAudio(backgroundAudioService(context));
        }
      }
      if (state case AppLifecycleState.detached) {
        if (isInteractionAudioPlaying) {
          stopAudio(interactionAudioService(context));
        }
        if (isBackgroundAudioPlaying) {
          stopAudio(backgroundAudioService(context));
        }
      }
    } else {
      if (state case AppLifecycleState.resumed) {
        // if (isInteractionAudioPlaying) {
        resumeAudio(interactionAudioService(context));
        // }
        // if (isBackgroundAudioPlaying) {
        resumeAudio(backgroundAudioService(context));
        // }
      }
    }
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

class _TaleViewState extends State<_TaleView> with StateHelpers {
  Tale get tale => widget.tale;

  @override
  void initState() {
    super.initState();
    safeInitialize(() {
      Future.wait([
        if (!tale.isPortrait)
          context
              .getDependency<DependencyInjection>()
              .deviceService
              .setDeviceOrientation([
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeRight,
          ]),
        if (tale.metadata.hasBackgroundAudio)
          context
              .getDependency<DependencyInjection>()
              .backgroundAudioPlayerService
              .playFromUrl(tale.metadata.backgroundAudioUrl),
      ]); //todo: handle error
    });
  }

  @override
  void dispose() {
    safeDispose(() async {
      await Future.wait([
        context
            .getDependency<DependencyInjection>()
            .deviceService
            .setDeviceOrientation([
          DeviceOrientation.portraitDown,
          DeviceOrientation.portraitUp,
        ]),
      ]); //todo: handle error
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final interactionAudio = context
        .getDependency<DependencyInjection>()
        .interactionAudioPlayerService;
    final backgroundAudio = context
        .getDependency<DependencyInjection>()
        .backgroundAudioPlayerService;
    return Translator(
      toTranslate: [
        tale.title,
        tale.description,
      ],
      builder: (translatedValue) {
        return Scaffold(
          appBar: AppBar(
            title: TextComponent.any(translatedValue[0]),
            actions: [
              StreamBuilder(
                stream: interactionAudio.playerStateStream,
                builder: (context, snapshot) {
                  log('Interaction: ${snapshot.data?.playing}');
                  log('Interaction: ${snapshot.data?.processingState}');
                  if (snapshot.data != null) {
                    final isPlaying = snapshot.data!.processingState ==
                            ProcessingState.ready &&
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
                        message: 'Interaction audio is playing',
                        child: Icon(Icons.audiotrack),
                      );
                    }
                  }
                  return const SizedBox();
                },
              ),
              StreamBuilder(
                stream: backgroundAudio.playerStateStream,
                builder: (context, snapshot) {
                  log('Background: ${snapshot.data?.playing}');
                  log('Background: ${snapshot.data?.processingState}');
                  if (snapshot.data != null) {
                    final isPlaying = snapshot.data!.processingState ==
                            ProcessingState.ready &&
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
              child: Text(
                translatedValue[1],
                textAlign: TextAlign.center,
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
                  return Stack(
                    children: [
                      //image
                      if (page.metadata.hasBackgroundImage)
                        Positioned.fill(
                          child: SelectedTalePageBackroundComponent(
                            imageUrl: page.metadata.backgroundImageUrl,
                          ),
                        ),

                      for (final interaction in page.interactions)
                        //tale object
                        AnimatedPositioned(
                          // curve: Curves.ease, //todo: get curve from db
                          duration: Duration(
                            milliseconds: interaction.animationDuration,
                          ),
                          width: interaction.size.width,
                          height: interaction.size.height,
                          left: interaction.currentPosition.dx,
                          top: interaction.currentPosition.dy,
                          child: SelectedTaleInteractionObjectComponent(
                            interaction: interaction,
                          ),
                        ),
                    ],
                  );
                },
              );
            },
          ),
          bottomNavigationBar: BottomAppBar(
            child: SelectedTalePageNavigatorComponent(
              controller: widget.pageController,
              totalPages: tale.pages.length,
              interactions: widget.pageController.hasClients
                  ? tale.pages[widget.pageController.page?.toInt() ?? 0]
                      .interactions
                  : tale.pages.first.interactions,
            ),
          ),
        );
      },
    );
  }
}
