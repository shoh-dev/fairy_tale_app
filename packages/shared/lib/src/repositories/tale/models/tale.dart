import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:shared/src/repositories/tale/models.dart';
import 'package:shared/src/services/audio_player_service.dart';
import 'package:shared/src/utils.dart';

part 'tale.freezed.dart';

@freezed
class Tale with _$Tale {
  const Tale._();

  const factory Tale({
    required String id,
    required TaleLocalization localizations,
    required AudioPlayerService audioPlayerService,
    @Default('') String title,
    @Default('') String description,
    @Default(TaleMetadata.empty) TaleMetadata metadata,
    @Default('landscape') String orientation,
    @Default(0) int toReRender,
    @Default(false) bool isNew,
  }) = _Tale;

  factory Tale.fromJson(Map<String, dynamic> json) {
    try {
      final id = json['id'] as String;
      var model = Tale.empty(id);

      if (json['localizations'] != null) {
        model = model.copyWith(
          localizations: TaleLocalization.fromJson(
            json['localizations'] as Map<String, dynamic>,
          ),
        );
      }
      if (json['metadata'] != null) {
        model = model.copyWith(
          metadata: TaleMetadata.fromJson(
            json['metadata'] as Map<String, dynamic>,
          ),
        );
      }
      if (json['orientation'] != null) {
        model = model.copyWith(
          orientation: json['orientation'] as String,
        );
      }
      if (json['title'] != null) {
        model = model.copyWith(
          title: json['title'] as String,
        );
      }
      if (json['description'] != null) {
        model = model.copyWith(
          description: json['description'] as String,
        );
      }
      // if (json['pages'] != null) {
      //   model = model.copyWith(
      //     pages: (json['pages'] as List)
      //         .map((e) => TalePage.fromJson(e as Map<String, dynamic>))
      //         .toList(),
      //   );
      // }

      return model;
    } catch (e, st) {
      Log().error('Tale.fromJson', e, st);
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    final json = {
      'id': id,
      'title': title,
      'description': description,
      'metadata': metadata.toJson(),
      'orientation': isOrientationValid ? orientation : 'landscape',
    };

    return json;
  }

  factory Tale.empty(String id) => Tale(
        id: id,
        localizations: TaleLocalization.empty(id),
        audioPlayerService: BackgroundAudioService(),
      );

  factory Tale.newTale(String id) => Tale.empty(id).copyWith(isNew: true);

  bool get isPortrait => orientation == 'portrait';

  String get coverImage => metadata.coverImageUrl;

  bool get isOrientationValid {
    if (orientation.isEmpty) {
      return false;
    }
    if (orientation == 'portrait' || orientation == 'landscape') {
      return true;
    }
    return false;
  }

  ModelValidation get _isMetadataValid {
    return metadata.isValidToSave;
  }

  /// if returns empty string means tale is valid to save
  /// otherwise returns error with which field is invalid
  ModelValidation get isValidToSave {
    final error = ModelValidation();

    if (id.isEmpty) {
      error['tale.id'] = ['ID is empty'];
    }

    if (localizations.isValid.isNotEmpty) {
      error.addAll(localizations.isValid);
    }

    if (title.isEmpty) {
      error['tale.title'] = ['Title is empty'];
    } else {
      if (localizations.defaultTranslation[title] == null) {
        error['tale.title'] = ['Title is not contained in localizations'];
      }
    }

    if (description.isNotEmpty) {
      if (localizations.defaultTranslation[description] == null) {
        error['tale.description'] = [
          'Description is not contained in localizations',
        ];
      }
    }

    if (isOrientationValid == false) {
      error['tale.orientation'] = ['Orientation is not valid'];
    }

    if (_isMetadataValid.isNotEmpty) {
      error.addAll(_isMetadataValid);
    }

    return error;
  }

  ModelValidation isPageValid(TalePage page) {
    final error = ModelValidation();

    if (page.isValidToSave.isNotEmpty) {
      error.addAll(page.isValidToSave);
    }
    //check if page.text contains in localizations
    if (localizations.defaultTranslation[page.text] == null) {
      error['tale.page.${page.id}'] = [
        'Page text [${page.text}] is not contained in localizations',
      ];
    }

    return error;
  }

  ResultFuture<void> playAudio() {
    return audioPlayerService.playFromUrl(metadata.backgroundAudioUrl);
  }
}
