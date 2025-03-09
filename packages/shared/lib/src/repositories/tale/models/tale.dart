import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:shared/src/repositories/tale/models.dart';
import 'package:shared/src/services/audio_player_service.dart';

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
    @Default([]) List<TalePage> pages,
    @Default('portrait') String orientation,
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
      if (json['pages'] != null) {
        model = model.copyWith(
          pages: (json['pages'] as List)
              .map((e) => TalePage.fromJson(e as Map<String, dynamic>))
              .toList(),
        );
      }

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
      'orientation': orientation,
    }..removeWhere((key, value) => value.toString().isEmpty);

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

  //updatePageMethod
  Tale updatePage(TalePage page) {
    final pages = List<TalePage>.from(this.pages);
    final index = pages.indexWhere((element) => element.id == page.id);
    if (index != -1) {
      pages[index] = page;
    }
    return copyWith(pages: pages);
  }

  Tale updateOrientation(String orientation) {
    return copyWith(orientation: orientation);
  }

  ResultFuture<void> playAudio() {
    return audioPlayerService.playFromUrl(metadata.backgroundAudioUrl);
  }

  void disposeAudioPlayers() {
    for (final interaction in pages.expand((element) => element.interactions)) {
      interaction.audioPlayerService.dispose();
    }
    audioPlayerService.dispose();
  }
}
