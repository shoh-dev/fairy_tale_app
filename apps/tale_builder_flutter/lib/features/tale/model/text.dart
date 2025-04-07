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
  }) = _TalePageTextModel;

  factory TalePageTextModel.fromJson(Map<String, dynamic> json) {
    final metadata = (json['metadata'] as Map);
    return TalePageTextModel(
      id: json['id'],
      pageId: json['tale_page_id'],
      text: json['text'],
      dx: metadata['pos']!['x']!.ceil().toDouble(),
      dy: metadata['pos']!['y']!.ceil().toDouble(),
      width: metadata['size']!['w']!.ceil().toDouble(),
      height: metadata['size']!['h']!.ceil().toDouble(),
    );
  }

  factory TalePageTextModel.newText(String id, String pageId) =>
      TalePageTextModel(
        id: id,
        pageId: pageId,
        dx: 0,
        dy: 0,
        width: 100,
        height: 40,
        text: 'text_key',
        isNew: true,
      );
}
