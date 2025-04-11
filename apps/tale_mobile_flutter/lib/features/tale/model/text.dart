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
    @Default(100.0) double width,
    @Default(40.0) double height,
    @Default(0.0) double dx,
    @Default(0.0) double dy,
    @Default(TalePageTextModel._defaultTextStyle) TextStyle style,
  }) = _TalePageTextModel;

  factory TalePageTextModel.fromJson(Map<String, dynamic> json) {
    final metadata = json['metadata'] as Map;
    final size = (metadata['size'] as Map).cast<String, num>();
    final pos = (metadata['pos'] as Map).cast<String, num>();
    final style = ((metadata['style'] ?? {}) as Map);
    final fontSize = style['font_size']?.toDouble();
    final fontColorCode = int.tryParse(
      "0xFF${style['color']?.toString().substring(1)}",
    );
    return TalePageTextModel(
      id: json['id'],
      pageId: json['tale_page_id'],
      text: json['text'],
      dx: pos['x']!.ceil().toDouble(),
      dy: pos['y']!.ceil().toDouble(),
      width: size['w']!.ceil().toDouble(),
      height: size['h']!.ceil().toDouble(),
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

  static const TextStyle _defaultTextStyle = TextStyle(
    fontSize: 18,
    color: Color(0xFFFFFFFF),
  );
}
