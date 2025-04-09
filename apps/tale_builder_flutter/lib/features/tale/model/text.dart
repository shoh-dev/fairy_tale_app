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
    @Default(TalePageTextModel.defaultTextStyle) TextStyle style,
  }) = _TalePageTextModel;

  factory TalePageTextModel.fromJson(Map<String, dynamic> json) {
    final metadata = json['metadata'] as Map;
    final size = (metadata['size'] as Map).cast<String, num>();
    final pos = (metadata['pos'] as Map).cast<String, num>();
    final style = ((metadata['style'] ?? {}) as Map);
    final fontSize = style['font_size']?.toDouble();
    final fontColorCode = int.tryParse(
      "0xFF${style['color'].toString().substring(1)}",
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
                fontSize: fontSize,
                color: fontColorCode != null ? Color(fontColorCode) : null,
              )
              : defaultTextStyle,
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
        //todo: handle color
        // "color": "#FF0000"
      },
    };
    return json;
  }

  static const TextStyle defaultTextStyle = TextStyle(
    fontSize: 18,
    color: Color(0xFFFFFFFF),
  );

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
