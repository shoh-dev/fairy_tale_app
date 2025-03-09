// TalePage Model
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:shared/src/repositories/tale/models.dart';
import 'package:shared/src/utils.dart';

part 'tale_page.freezed.dart';

@freezed
class TalePage with _$TalePage {
  const TalePage._();

  const factory TalePage({
    required String id,
    required String taleId,

    ///for now not using this property
    @Default(-1) int pageNumber,
    @Default('') String text,
    @Default(TalePageMetadata.empty) TalePageMetadata metadata,
    @Default([]) List<TaleInteraction> interactions,
    @Default(false) bool isNew,
    @Default(0) int toReRender,
  }) = _TalePage;

  factory TalePage.empty({
    required String id,
    required String taleId,
  }) =>
      TalePage(
        id: id,
        taleId: taleId,
      );

  factory TalePage.newPage({
    required String id,
    required String taleId,
    required String text,
    required int pageNumber,
  }) =>
      TalePage.empty(id: id, taleId: taleId)
          .copyWith(text: text, pageNumber: pageNumber, isNew: true);

  factory TalePage.fromJson(Map<String, dynamic> json) {
    try {
      final id = json['id'] as String;
      final taleId = json['tale_id'] as String;
      var model = TalePage.empty(id: id, taleId: taleId);

      if (json['page_number'] != null) {
        model = model.copyWith(pageNumber: json['page_number'] as int);
      }
      if (json['text'] != null) {
        model = model.copyWith(text: json['text'] as String);
      }
      if (json['metadata'] != null) {
        model = model.copyWith(
          metadata: TalePageMetadata.fromJson(
            json['metadata'] as Map<String, dynamic>,
          ),
        );
      }
      if (json['interactions'] != null) {
        model = model.copyWith(
          interactions: (json['interactions'] as List)
              .map((e) => TaleInteraction.fromJson(e as Map<String, dynamic>))
              .toList(),
        );
      }

      return model;
    } catch (e, st) {
      Log().error('TalePage.fromJson', e, st);
      rethrow;
    }
  }

  Map<dynamic, dynamic> toJson() {
    final json = {
      'id': id,
      'tale_id': taleId,
      'page_number': pageNumber,
      'text': text,
      'metadata': metadata.toJson(),
    };
    return json;
  }

  bool get hasBackgroundAudio => metadata.hasBackgroundAudio;

  ModelValidation get isValidToSave {
    final error = ModelValidation();

    if (id.isEmpty) {
      error['tale.page.id'] = ['ID is required'];
    }

    if (taleId.isEmpty) {
      error['tale.page_$id.tale_id'] = ['Tale ID is required'];
    }

    if (text.isEmpty) {
      error['tale.page_$id.text'] = ['Text is required'];
    }

    if (!metadata.hasBackgroundImage) {
      error['tale.page_$id.background_image'] = [
        'Background image is required',
      ];
    }

    //todo: validate interactions

    return error;
  }

  //updateInteractionMethod
  TalePage updateInteraction(TaleInteraction interaction) {
    final interactions = List<TaleInteraction>.from(this.interactions);
    final index =
        interactions.indexWhere((element) => element.id == interaction.id);
    if (index != -1) {
      interactions[index] = interaction;
    }
    return copyWith(interactions: interactions);
  }

  TalePage updateText(String text) {
    return copyWith(text: text);
  }
}
