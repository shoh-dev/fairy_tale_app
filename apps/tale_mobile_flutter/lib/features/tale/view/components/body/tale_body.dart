import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:myspace_ui/myspace_ui.dart';
import 'package:tale_mobile_flutter/components/animated_preview.dart';
import 'package:tale_mobile_flutter/components/button.dart';
import 'package:tale_mobile_flutter/features/tale/model/page.dart';
import 'package:tale_mobile_flutter/features/tale/model/text.dart';
import 'package:tale_mobile_flutter/features/tale/view_model/tale_view_model.dart';

class TaleBody extends StatefulWidget {
  const TaleBody({super.key, required this.vm});

  final TaleViewModel vm;

  @override
  State<TaleBody> createState() => _TaleBodyState();
}

class _TaleBodyState extends State<TaleBody> {
  TaleViewModel get vm => widget.vm;

  final controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VmWatcher<TaleViewModel>(
      builder:
          (context, vm, child) => Stack(
            children: [
              Positioned.fill(
                child: PageView(
                  physics: ClampingScrollPhysics(),
                  controller: controller,
                  children: [
                    for (final page in vm.pages) _Page(page: page, vm: vm),
                  ],
                ),
              ),
              Positioned(
                top: 16.h,
                left: 16.w,
                child: AnimatedPreview(
                  isPreviewMode: vm.isPreviewMode,
                  child: SafeArea(
                    child: Column(
                      spacing: 6.h,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppIconButton(
                          icon: Icons.home_rounded,
                          onPressed: context.pop,
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(6).w,
                            child: ListenableBuilder(
                              listenable: controller,
                              builder: (context, _) {
                                if (controller.hasClients) {
                                  final currentPage =
                                      (controller.page?.round() ?? 0) + 1;
                                  return Text(
                                    "$currentPage/${vm.pages.length}",
                                    textAlign: TextAlign.center,
                                    style: context.textTheme.titleMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.w900,
                                          color: context.primary,
                                        ),
                                  );
                                }
                                return const SizedBox();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              if (vm.hasBackgroundAudio)
                Positioned(
                  top: 16.h,
                  right: 16.w,
                  child: AnimatedPreview(
                    isPreviewMode: vm.isPreviewMode,
                    child: SafeArea(
                      child: StreamBuilder<bool>(
                        stream: vm.isAudioPlayingStream(),
                        builder: (context, snapshot) {
                          if (snapshot.data == null) return const SizedBox();

                          return AppIconButton(
                            icon:
                                snapshot.data!
                                    ? Icons.music_note_rounded
                                    : Icons.music_off_rounded,
                            // bgColor: Colors.white,
                            // fgColor: context.primary,
                            onPressed: vm.toggleAudio,
                          );
                        },
                      ),
                    ),
                  ),
                ),
            ],
          ),
    );
  }
}

class _Page extends StatelessWidget {
  const _Page({required this.page, required this.vm});

  final TalePageModel page;
  final TaleViewModel vm;

  Map<String, String> get translations => vm.translations;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: ValueKey(page.id),
      onTap: vm.togglePreviewMode,
      child: DecoratedBox(
        decoration: BoxDecoration(
          image:
              page.hasBackgroundImage
                  ? DecorationImage(
                    image: CachedNetworkImageProvider(page.backgroundImageUrl),
                    fit: BoxFit.fill,
                  )
                  : null,
        ),
        child: Stack(
          children: [
            for (final text in page.texts)
              _Text(
                text: text,
                translations: translations,
                isPreviewMode: vm.isPreviewMode,
              ),
          ],
        ),
      ),
    );
  }
}

class _Text extends StatefulWidget {
  const _Text({
    required this.text,
    required this.translations,
    required this.isPreviewMode,
  });

  final TalePageTextModel text;
  final Map<String, String> translations;
  final bool isPreviewMode;

  @override
  State<_Text> createState() => __TextState();
}

class __TextState extends State<_Text> {
  TalePageTextModel get text => widget.text;
  Map<String, String> get translations => widget.translations;

  Offset offset = Offset.zero;
  Size size = Size.zero;

  void initialize() {
    offset = Offset(text.dx, text.dy);
    size = Size(text.width, text.height);
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant _Text oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget != widget) {
      initialize();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      key: ValueKey(text.id),
      width: size.width.w,
      height: size.height.h,
      left: offset.dx.w,
      top: offset.dy.h,
      child: AnimatedPreview(
        isPreviewMode: widget.isPreviewMode,
        child: _textWidget(),
      ),
    );
  }

  Widget _textWidget() {
    final translatedText = translations[text.text] ?? "";
    final style = text.style;
    final decoration = text.decoration;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: decoration.backgroundColor,
        borderRadius: decoration.borderRadius,
      ),
      child: Padding(
        padding: decoration.padding.w,
        child: Text(
          translatedText,
          textAlign: decoration.textAlign,
          style: style.copyWith(
            fontSize: style.fontSize?.sp,
            shadows:
                decoration.backgroundColor == null
                    ? [
                      Shadow(
                        color: Colors.black54,
                        blurRadius: 8,
                        offset: Offset(1, 1),
                      ),
                    ]
                    : null,
          ),
        ),
      ),
    );
  }
}
