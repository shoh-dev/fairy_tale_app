import 'package:flutter/material.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:myspace_ui/myspace_ui.dart';
import 'package:tale_mobile_flutter/features/tale/model/page.dart';
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
          child: SafeArea(
            child: ButtonComponent.icon(
              icon: Icons.home,
              onPressed: context.pop,
            ),
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
                  image: NetworkImage(page.backgroundImageUrl),
                  fit: BoxFit.fill,
                )
                : null,
      ),
      child: Stack(
        children: [
          for (final text in page.texts)
            Positioned(
              left: text.dx,
              top: text.dy,
              width: text.width,
              height: text.height,
              child: TextComponent.any(
                translations[text.text] ?? "",
                style: text.style.copyWith(
                  shadows: [
                    Shadow(
                      color: Colors.black54,
                      blurRadius: 8,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
