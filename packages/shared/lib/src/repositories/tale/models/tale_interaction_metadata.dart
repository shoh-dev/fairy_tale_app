import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:shared/shared.dart';
import 'package:shared/src/repositories/tale/models.dart';

part 'tale_interaction_metadata.freezed.dart';

@freezed
class TaleInteractionMetadata with _$TaleInteractionMetadata {
  const TaleInteractionMetadata._();

  const factory TaleInteractionMetadata({
    @Default(TaleInteractionSize(40, 40)) TaleInteractionSize size,
    @Default(TaleInteractionPosition.zero)
    TaleInteractionPosition initialPosition,
    @Default('') String imageUrl,
    @Default('') String audioUrl,
    TaleInteractionPosition? finalPosition,
    @Default(TaleInteractionPosition.zero)
    TaleInteractionPosition currentPosition,
  }) = _TaleInteractionMetadata;

  factory TaleInteractionMetadata.fromJson(Map<String, dynamic> json) {
    try {
      var model = empty;

      if (json['size'] != null) {
        model = model.copyWith(
          size: TaleInteractionSize.fromJson(
            json['size'] as Map<String, dynamic>,
          ),
        );
      }
      if (json['initial_pos'] != null) {
        model = model.copyWith(
          initialPosition: TaleInteractionPosition.fromJson(
            json['initial_pos'] as Map<String, dynamic>,
          ),
        );
      }
      if (json['final_pos'] != null) {
        model = model.copyWith(
          finalPosition: TaleInteractionPosition.fromJson(
            json['final_pos'] as Map<String, dynamic>,
          ),
        );
      }
      if (json['image_url'] != null) {
        model = model.copyWith(
          imageUrl: json['image_url'] as String,
        );
      }
      if (json['audio_url'] != null) {
        model = model.copyWith(
          audioUrl: json['audio_url'] as String,
        );
      }
      return model.copyWith(
        currentPosition: model.initialPosition,
      );
    } catch (e, st) {
      Log().error('TaleInteractionMetadata.fromJson', e, st);
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    final json = {
      'size': size.toJson(),
      'initial_pos': initialPosition.toJson(),
      'final_pos': finalPosition?.toJson(),
      'image_url': imageUrl,
      'audio_url': audioUrl,
    }..removeWhere((key, value) => value == null || value.toString().isEmpty);

    return json;
  }

  ModelValidation get isValidToSave {
    final error = ModelValidation();
    final isSizeValid = size.width > 0 && size.height > 0;

    if (!isSizeValid) {
      error['size'] = ['Size is invalid'];
    }

    return error;
  }

  static const empty = TaleInteractionMetadata();

  bool get hasAudio => audioUrl.isNotEmpty;
  bool get hasImage => imageUrl.isNotEmpty;
}
