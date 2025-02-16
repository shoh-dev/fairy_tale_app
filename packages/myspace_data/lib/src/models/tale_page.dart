// TalePage Model
import 'package:equatable/equatable.dart';
import 'package:myspace_data/myspace_data.dart';

class TalePage extends Equatable {
  final String id;
  final String taleId;
  final int pageNumber;
  final String text;
  final String image;
  final String? narrationAudio;
  final List<TaleInteraction> interactions;

  const TalePage({
    required this.id,
    required this.taleId,
    required this.pageNumber,
    required this.text,
    required this.image,
    this.narrationAudio,
    required this.interactions,
  });

  factory TalePage.fromJson(Map<String, dynamic> json) => TalePage(
        id: json['id'] as String,
        taleId: json['tale_id'] as String,
        pageNumber: json['page_number'] as int,
        text: json['text'] as String,
        image: json['background_image'] as String,
        narrationAudio: json['narration_audio'] as String?,
        interactions: (json['tale_interactions'] as List<dynamic>?)?.map((e) => TaleInteraction.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      );

  @override
  List<Object?> get props => [id, taleId, pageNumber, text, image, narrationAudio, interactions];
}
