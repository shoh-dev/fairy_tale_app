import 'package:freezed_annotation/freezed_annotation.dart';

part 'tale.freezed.dart';

@freezed
abstract class TaleModel with _$TaleModel {
  const TaleModel._();

  const factory TaleModel({
    required String id,
    required String title,
    required String description,
    required String orientation,
    required String coverImageUrl,
    required String backgroundAudioUrl,
    @Default(false) bool isNew,
  }) = _TaleModel;

  factory TaleModel.fromJson(Map<String, dynamic> json) {
    return TaleModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      orientation: json['orientation'],
      backgroundAudioUrl: '', //todo:
      coverImageUrl: '', //todo:
    );
  }

  factory TaleModel.newTale(String id) => TaleModel(
    id: id,
    title: '',
    description: '',
    orientation: 'landscape',
    coverImageUrl: '',
    backgroundAudioUrl: '',
    isNew: true,
  );
}
