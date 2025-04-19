import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'text.freezed.dart';

@freezed
abstract class TalePageTextModel with _$TalePageTextModel {
  const TalePageTextModel._();

  const factory TalePageTextModel({
    required String id,
    required String text,
    required String pageId,
    required double width,
    required double height,
    required double dx,
    required double dy,
    @Default(false) bool isNew,
    @Default(TalePageTextModel._defaultTextStyle) TextStyle style,
    @Default(TextDecorationModel._default) TextDecorationModel decoration,
  }) = _TalePageTextModel;

  factory TalePageTextModel.fromJson(Map<String, dynamic> json) {
    final metadata = json['metadata'] as Map;
    final size = (metadata['size'] as Map).cast<String, num>();
    final pos = (metadata['pos'] as Map).cast<String, num>();
    final style = ((metadata['style'] ?? {}) as Map);
    final fontSize = style['font_size']?.toDouble();
    final fontColorCode = int.tryParse(
      "0xff${style['font_color']?.toString().toLowerCase().substring(1)}",
    );
    return TalePageTextModel(
      id: json['id'],
      pageId: json['tale_page_id'],
      text: json['text'],
      dx: pos['x']!.ceil().toDouble(),
      dy: pos['y']!.ceil().toDouble(),
      width: size['w']!.ceil().toDouble(),
      height: size['h']!.ceil().toDouble(),
      decoration: TextDecorationModel.fromJson(json),
      style:
          style.isNotEmpty
              ? TextStyle(
                fontSize: fontSize ?? _defaultTextStyle.fontSize,
                color:
                    fontColorCode != null
                        ? Color(fontColorCode)
                        : _defaultTextStyle.color,
              )
              : _defaultTextStyle,
    );
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['id'] = id;
    json['tale_page_id'] = pageId;
    json['text'] = text;
    json['metadata'] = {
      "pos": {"x": dx, "y": dy},
      "size": {"w": width, "h": height},
      "style": {
        "font_size": style.fontSize ?? 18,
        "font_color": colorToHex(),
        ...decoration.toJson(),
      },
    };
    return json;
  }

  static const TextStyle _defaultTextStyle = TextStyle(
    fontSize: 18,
    color: Color(0xFFFFFFFF),
  );

  String colorToHex() {
    int nonAlpha = style.color!.toARGB32() & 0xFFFFFF;
    // if (!withAlpha) {
    return '#${nonAlpha.toRadixString(16).padLeft(6, '0')}'.toLowerCase();
    // }
    // int alpha = (style.color!.toARGB32() & 0xFF000000) >> 24;
    // return '#${nonAlpha.toRadixString(16).padLeft(6, '0')}${alpha.toRadixString(16).padLeft(2, '0')}';
  }

  factory TalePageTextModel.newText(String id, String pageId) =>
      TalePageTextModel(
        id: id,
        pageId: pageId,
        dx: 0,
        dy: 0,
        width: 100,
        height: 40,
        text: '',
        isNew: true,
      );
}

@freezed
abstract class TextDecorationModel with _$TextDecorationModel {
  const TextDecorationModel._();

  const factory TextDecorationModel({
    Color? backgroundColor,
    @Default(BorderRadius.zero) BorderRadius borderRadius,
    @Default(EdgeInsets.zero) EdgeInsets padding,
    @Default(TextAlign.center) TextAlign textAlign,
  }) = _TextDecorationModel;

  factory TextDecorationModel.fromJson(Map<String, dynamic> json) {
    final metadata = json['metadata'] as Map;
    final style = ((metadata['style'] ?? {}) as Map);
    final borderRadius = ((style['border_radius'] ?? {}) as Map);
    var brs = BorderRadius.zero;
    if (borderRadius.isNotEmpty) {
      brs = BorderRadius.only(
        topLeft: Radius.circular(borderRadius['tl']!.toDouble()),
        topRight: Radius.circular(borderRadius['tr']!.toDouble()),
        bottomLeft: Radius.circular(borderRadius['bl']!.toDouble()),
        bottomRight: Radius.circular(borderRadius['br']!.toDouble()),
      );
    }
    final padding = ((style['padding'] ?? {}) as Map);
    var pad = EdgeInsets.zero;
    if (padding.isNotEmpty) {
      pad = EdgeInsets.only(
        left: padding['left']!.toDouble(),
        right: padding['right']!.toDouble(),
        top: padding['top']!.toDouble(),
        bottom: padding['bottom']!.toDouble(),
      );
    }
    final backgroundColorCode = int.tryParse(
      "0xff${style['background_color']?.toString().toLowerCase().substring(1)}",
    );
    final textAlign = TextAlign.values.firstWhere(
      (element) => element.name == style['text_align'],
      orElse: () => TextAlign.start,
    );
    return TextDecorationModel(
      backgroundColor:
          backgroundColorCode != null
              ? Color(backgroundColorCode)
              : _default.backgroundColor,
      borderRadius: brs,
      padding: pad,
      textAlign: textAlign,
    );
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (backgroundColor != null) {
      json['background_color'] = colorToHex();
    }
    json['text_align'] = textAlign.name;
    if (borderRadius != BorderRadius.zero) {
      json['border_radius'] = {
        "tl": borderRadius.topLeft.x,
        "tr": borderRadius.topRight.x,
        "bl": borderRadius.bottomLeft.x,
        "br": borderRadius.bottomRight.x,
      };
    }
    if (padding != EdgeInsets.zero) {
      json['padding'] = {
        "left": padding.left,
        "right": padding.right,
        "top": padding.top,
        "bottom": padding.bottom,
      };
    }
    return json;
  }

  double get borderRadiusAll => borderRadius.topRight.x;
  double get paddingAll => padding.right;

  String colorToHex() {
    if (backgroundColor == null) return '';
    int nonAlpha = backgroundColor!.toARGB32() & 0xFFFFFF;
    return '#${nonAlpha.toRadixString(16).padLeft(6, '0')}'.toLowerCase();
  }

  static const _default = TextDecorationModel();
}
