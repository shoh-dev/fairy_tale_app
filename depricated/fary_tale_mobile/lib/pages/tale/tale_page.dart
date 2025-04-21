import 'dart:async';

import 'package:fairy_tale_mobile/components/interaction_object.dart';
import 'package:fairy_tale_mobile/components/page_background.dart';
import 'package:fairy_tale_mobile/components/safearea.dart';
import 'package:fairy_tale_mobile/pages/tale/components/left_buttons.dart';
import 'package:fairy_tale_mobile/pages/tale/components/right_buttons.dart';
import 'package:fairy_tale_mobile/pages/tale/components/text.dart';
import '../../../../fairy_tale_builder_platform/lib/components/state_result_wrapper.dart';
import 'package:fairy_tale_mobile/pages/tale_list/selected_tale/components/selected_tale_interaction_object.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:shared/shared.dart';

class Talepage extends StatelessWidget
    with
        StateConnectorMixin<
            (StateResult, List<TalePage>, List<TaleInteraction>)> {
  const Talepage({
    required this.taleId,
    super.key,
  });

  final String taleId;

  @override
  void onInitialBuild(
    Dispatcher<AppState> dispatch,
    (StateResult, List<TalePage>, List<TaleInteraction>) model,
  ) {
    dispatch(GetTaleAction(taleId: taleId));
  }

  @override
  Widget builder(
    BuildContext context,
    Dispatcher<AppState> dispatch,
    (StateResult, List<TalePage>, List<TaleInteraction>) model,
  ) {
    return Scaffold(
      body: StateResultWrapper(
        result: model.$1,
        onOk: _Tale(
          pages: model.$2,
          interactions: model.$3,
        ),
      ),
    );
  }

  @override
  (StateResult, List<TalePage>, List<TaleInteraction>) selector(
    AppState state,
  ) {
    return (
      state.selectedTaleState.taleResult,
      state.selectedTaleState.pages,
      state.selectedTaleState.interactions,
    );
  }
}

class _Tale extends StatefulWidget {
  const _Tale({
    required this.pages,
    required this.interactions,
  });

  final List<TalePage> pages;
  final List<TaleInteraction> interactions;

  @override
  State<_Tale> createState() => _TaleState();
}

class _TaleState extends State<_Tale> with StateHelpers {
  final PageController pageController = PageController();

  int get currentPageIndex {
    if (pageController.hasClients && pageController.page != null) {
      return pageController.page!.toInt();
    }
    return 0;
  }

  bool get isLastPage {
    return currentPageIndex == widget.pages.length - 1;
  }

  bool get isFirstPage {
    return currentPageIndex == 0;
  }

  TalePage get currentPage => widget.pages[currentPageIndex];

  void onNext() {
    if (pageController.hasClients) {
      if (!isLastPage) {
        pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      }
    }
  }

  void onPrev() {
    if (pageController.hasClients) {
      if (!isFirstPage) {
        pageController.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      }
    }
  }

  @override
  void dispose() {
    safeDispose(pageController.dispose);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: _Pages(
            controller: pageController,
            pages: widget.pages,
            interactions: widget.interactions,
          ),
        ),
        Positioned(
          left: 4,
          top: 4,
          child: SafeArea(
            bottom: false,
            top: false,
            right: false,
            child: ListenableBuilder(
              listenable: pageController,
              builder: (context, _) {
                return TalepageLeftButtons(
                  currentPage: currentPageIndex + 1,
                  totalPagesCount: widget.pages.length,
                );
              },
            ),
          ),
        ),
        const Positioned(
          right: 4,
          top: 4,
          child: SafeArea(
            bottom: false,
            top: false,
            left: false,
            child: TalepageRightButtons(),
          ),
        ),
        //tale text
        Positioned.fill(
          child: SafeArea(
            bottom: false,
            top: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ListenableBuilder(
                listenable: pageController,
                builder: (context, _) {
                  return TalepageText(
                    text: currentPage.text,
                    onNext: onNext,
                    onPrev: onPrev,
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Pages extends StatelessWidget {
  const _Pages({
    required this.controller,
    required this.pages,
    required this.interactions,
  });

  final List<TalePage> pages;
  final List<TaleInteraction> interactions;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      itemCount: pages.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final page = pages[index];
        final interactions = this.interactions.where(
              (element) => element.talePageId == page.id,
            );

        return Stack(
          children: [
            Positioned.fill(
              child: PageBackground(
                url: page.metadata.backgroundImageUrl,
              ),
            ),

            //objects
            for (final interaction in interactions)
              SelectedTaleInteractionObjectComponent(
                interaction: interaction,
              )
          ],
        );
      },
    );
  }
}
