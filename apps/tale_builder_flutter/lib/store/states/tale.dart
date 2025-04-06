import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tale.freezed.dart';

@freezed
abstract class TaleState with _$TaleState {
  const TaleState._();

  const factory TaleState({
    @Default('') String id,
    @Default('') String title,
    @Default('') String description,
    @Default(Orientation.landscape) Orientation orientation,
    @Default('') String coverImageUrl,
    @Default('') String backgroundAudioUrl,
  }) = _TaleState;

  bool get isNew => id.isEmpty;
  bool get hasCoverImage => coverImageUrl.isNotEmpty;
  bool get hasBackgroundAudio => backgroundAudioUrl.isNotEmpty;
}
