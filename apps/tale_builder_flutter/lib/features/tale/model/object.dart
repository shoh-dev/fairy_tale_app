import 'package:freezed_annotation/freezed_annotation.dart';

part 'object.freezed.dart';

@freezed
abstract class TaleObjectModel with _$TaleObjectModel {
  const TaleObjectModel._();

  const factory TaleObjectModel({
    required String imageUrl,
    required String pageId,
    @Default(100) double width,
    @Default(100) double height,
    @Default(0) double dx,
    @Default(0) double dy,
  }) = _TaleObjectModel;

  factory TaleObjectModel.fromJson(Map<String, dynamic> json) {
    final metadata = json['metadata'] as Map;
    final size = (metadata['size'] as Map).cast<String, num>();
    final pos = (metadata['pos'] as Map).cast<String, num>();
    return TaleObjectModel(
      imageUrl: json['image_url'],
      pageId: json['page_id'],
      dx: pos['x']!.ceil().toDouble(),
      dy: pos['y']!.ceil().toDouble(),
      width: size['w']!.ceil().toDouble(),
      height: size['h']!.ceil().toDouble(),
    );
  }
}
