import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:myspace_ui/myspace_ui.dart';
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
    return Stack(
      children: [
        Positioned.fill(
          child: PageView(
            physics: ClampingScrollPhysics(),
            controller: controller,
            children: [
              for (final page in vm.pages)
                _Page(page: page, translations: vm.translations),
            ],
          ),
        ),
        Positioned(
          top: 16,
          left: 16,
          child: SafeArea(
            child: AppIconButton(icon: Icons.home, onPressed: context.pop),
          ),
        ),
      ],
    );
  }
}

class _Page extends StatelessWidget {
  const _Page({required this.page, required this.translations});

  final TalePageModel page;
  final Map<String, String> translations;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
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
            _Text(text: text, translations: translations),
        ],
      ),
    );
  }
}

class _Text extends StatefulWidget {
  const _Text({required this.text, required this.translations});

  final TalePageTextModel text;
  final Map<String, String> translations;

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
      width: size.width.w,
      height: size.height.h,
      left: offset.dx.w,
      top: offset.dy.h,
      child: _textWidget(),
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
