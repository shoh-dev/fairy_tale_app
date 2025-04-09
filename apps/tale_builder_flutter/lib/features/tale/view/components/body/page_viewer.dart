import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:tale_builder_flutter/features/tale/model/localization.dart';
import 'package:tale_builder_flutter/features/tale/model/text.dart';
import 'package:tale_builder_flutter/features/tale/view/tale_view.dart';
import 'package:tale_builder_flutter/features/tale/view_model/tale_view_model.dart';

class PageViewer extends StatefulWidget {
  const PageViewer({super.key, required this.vm});

  final TaleViewModel vm;

  @override
  State<PageViewer> createState() => _PageViewerState();
}

class _PageViewerState extends State<PageViewer> {
  TaleViewModel get vm => widget.vm;

  String hoveredTextId = '';

  @override
  Widget build(BuildContext context) {
    final tale = vm.tale;
    final deviceSize = Sizes.deviceSize(tale.isPortrait);
    final selectedText = vm.selectedText;
    final selectedPage = vm.selectedPage;
    final texts = UnmodifiableListView(
      vm.texts.where((element) => element.pageId == selectedPage?.id),
    );
    return SizedBox(
      width: deviceSize.width,
      height: deviceSize.height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: context.colorScheme.onSurface),
          color: context.colorScheme.surfaceContainer,
        ),
        child: Stack(
          children: [
            Positioned.fill(child: GestureDetector(onTap: vm.onDeselectText)),
            for (final text in texts)
              _Text(
                text: text,
                localization: vm.localization,
                deviceSize: deviceSize,
                onSelect: vm.onSelectText,
                selectedText: selectedText,
                onDeleteText: vm.onDeleteText,
                onChangePosition:
                    (value) => vm.onChangeTextPosition(value.dx, value.dy),
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
    this.selectedText,
    required this.onSelect,
    required this.onChangePosition,
    required this.deviceSize,
    required this.localization,
    required this.onDeleteText,
  });

  final TalePageTextModel text;
  final TalePageTextModel? selectedText;
  final ValueChanged<TalePageTextModel> onSelect;
  final ValueChanged<Offset> onChangePosition;
  final ValueChanged<String> onDeleteText;
  final Size deviceSize;
  final TaleLocalizationModel localization;

  @override
  State<_Text> createState() => __TextState();
}

class __TextState extends State<_Text> {
  TalePageTextModel get text => widget.text;
  TalePageTextModel? get selectedText => widget.selectedText;
  TaleLocalizationModel get localization => widget.localization;
  Size get deviceSize => widget.deviceSize;

  String hoveredTextId = '';
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
      width: size.width,
      height: size.height,
      left: offset.dx,
      top: offset.dy,
      child: GestureDetector(
        onSecondaryTapDown: (TapDownDetails details) {
          final position = context.getTapPosition(details);
          showMenu(
            position: position,
            context: context,
            items: [
              PopupMenuItem(
                child: ListTile(
                  title: Text("Delete"),
                  leading: Icon(Icons.delete),
                ),
                onTap: () {
                  widget.onDeleteText(text.id);
                },
              ),
            ],
          );
        },
        onTap: () {
          widget.onSelect(text);
        },
        onPanUpdate: (details) {
          if (selectedText == null) return;
          if (selectedText!.id == text.id) {
            final oldPos = offset;
            offset += details.delta;
            if (offset.dx < 0) {
              offset = Offset(0, offset.dy);
            } else if (offset.dx > (deviceSize.width - text.width)) {
              //-40 is the size of the object
              offset = Offset(deviceSize.width - text.width, offset.dy);
            }
            if (offset.dy < 0) {
              offset = Offset(offset.dx, 0);
            } else if (offset.dy > (deviceSize.height - text.height)) {
              //-40 is the size of the object
              offset = Offset(offset.dx, deviceSize.height - text.height);
            }
            if (oldPos != offset) {
              setState(() {});
            }
          }
        },
        onPanEnd: (details) {
          widget.onChangePosition(offset);
        },
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) {
            setState(() {
              hoveredTextId = text.id;
            });
          },
          onExit: (_) {
            setState(() {
              hoveredTextId = "";
            });
          },
          child: Builder(
            builder: (context) {
              final isHovered = hoveredTextId == text.id;
              final isSelected = selectedText?.id == text.id;
              return DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(
                    color:
                        isSelected
                            ? Colors.red
                            : (isHovered
                                ? Colors.blue
                                : context.colorScheme.onSurface),
                  ),
                ),
                child: Builder(
                  builder: (context) {
                    final translatedText =
                        text.text.isEmpty
                            ? ""
                            : localization.defaultTranslations[text.text];
                    return TextComponent.any(
                      translatedText ?? "NOT_FOUND",
                      style: text.style,
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
