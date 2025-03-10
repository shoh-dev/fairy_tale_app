import 'dart:developer';

import 'package:fairy_tale_mobile/components/lifecycle_component.dart';
import 'package:fairy_tale_mobile/components/translator_component.dart';
import 'package:fairy_tale_mobile/manager/di/di.dart';
import 'package:fairy_tale_mobile/manager/redux.dart';
import 'package:fairy_tale_mobile/manager/redux/selected_tale_state/action.dart';
import 'package:fairy_tale_mobile/manager/redux/selected_tale_state/selected_tale_state.dart';
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
  Widget build(BuildContext context) {
    return StateConnector<AppState, SelectedTaleState>(
      selector: (state) => state.selectedTaleState,
      onInitialBuild: (dispatch, viewModel) async {
        dispatch(GetTaleAction(widget.taleId));
      },
      onDispose: (dispatch) {
        safeDispose(pageController.dispose);
        dispatch(GetTaleAction(widget.taleId, reset: true));
      },
      builder: (context, dispatch, vm) {
        return Scaffold(
          body: vm.taleResult.when(
            ok: () {
              return _TaleView(
                tale: vm.tale,
                pages: vm.pages,
                interactions: vm.interactionsForPage,
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
    required this.pages,
    required this.pageController,
    required this.interactions,
  });

  final PageController pageController;
  final Tale tale;
  final List<TalePage> pages;
  final List<TaleInteraction> Function(String pageId) interactions;

  @override
  State<_TaleView> createState() => _TaleViewState();
}

class _TaleViewState extends State<_TaleView>
    with StateHelpers, WidgetsBindingObserver {
  Tale get tale => widget.tale;
  List<TalePage> get pages => widget.pages;
  List<TaleInteraction> Function(String pageId) get interactions =>
      widget.interactions;

  AudioPlayerService get backgroundAudioPlayer => tale.audioPlayerService;

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
          if (backgroundAudioPlayer.isPlaying()) backgroundAudioPlayer.stop(),
        ]); //todo: handle error
        tale.audioPlayerService.dispose();
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
      onAppBackground: backgroundAudioPlayer.pause,
      onAppClosed: backgroundAudioPlayer.stop,
      onAppResumed: backgroundAudioPlayer.play,
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
              itemCount: pages.length,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                final page = pages[index];
                return TalePageComponent(
                  page: page,
                  interactions: interactions,
                );
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
