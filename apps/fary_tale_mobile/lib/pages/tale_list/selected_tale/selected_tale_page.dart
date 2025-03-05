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

  AudioPlayerService audioService(BuildContext context) {
    return context
        .getDependency<DependencyInjection>()
        .interactionAudioPlayerService;
  }

  @override
  void dispose() {
    safeDispose(() {
      if (audioService(context).isPlaying()) {
        stopAudio(audioService(context));
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
    log(state.toString());

    final isAudioPlaying = audioService(context).isPlaying();

    if (isAudioPlaying) {
      if (state
          case AppLifecycleState.hidden ||
              AppLifecycleState.inactive ||
              AppLifecycleState.paused) {
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
  @override
  void initState() {
    super.initState();
    safeInitialize(() async {
      if (!widget.tale.isPortrait) {
        await context
            .getDependency<DependencyInjection>()
            .deviceService
            .setDeviceOrientation([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]).then(
          (value) {
            if (value.isError) {
              log((value as ErrorX).toString());
            }
          },
        );
      }
    });
  }

  @override
  void dispose() {
    safeDispose(() async {
      await context
          .getDependency<DependencyInjection>()
          .deviceService
          .setDeviceOrientation([
        DeviceOrientation.portraitDown,
        DeviceOrientation.portraitUp,
      ]).then(
        (value) {
          if (value.isError) {
            log((value as ErrorX).toString());
          }
        },
      );
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final audioService = context
        .getDependency<DependencyInjection>()
        .interactionAudioPlayerService;
    return Translator(
      toTranslate: [
        widget.tale.title,
        widget.tale.description,
      ],
      builder: (translatedValue) {
        return Scaffold(
          appBar: AppBar(
            title: TextComponent.any(translatedValue[0]),
            actions: [
              StreamBuilder(
                stream: audioService.isPlayingStream,
                builder: (context, snapshot) {
                  if (snapshot.data != null && snapshot.data!) {
                    return const Tooltip(
                      triggerMode: TooltipTriggerMode.tap,
                      message: 'Audio is playing',
                      child: Icon(Icons.pause),
                    );
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
                itemCount: widget.tale.pages.length,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  final page = widget.tale.pages[index];
                  return Stack(
                    children: [
                      //image
                      if (page.backgroundImage.isNotEmpty)
                        Positioned.fill(
                          child: SelectedTalePageBackroundComponent(
                            imageUrl: page.backgroundImage,
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
              totalPages: widget.tale.pages.length,
              interactions: widget.pageController.hasClients
                  ? widget.tale.pages[widget.pageController.page?.toInt() ?? 0]
                      .interactions
                  : widget.tale.pages.first.interactions,
            ),
          ),
        );
      },
    );
  }
}
