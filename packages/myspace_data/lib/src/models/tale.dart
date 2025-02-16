import 'package:equatable/equatable.dart';
import 'package:myspace_data/myspace_data.dart';

// Tale Model
class Tale extends Equatable {
  final String id;
  final String title;
  final String description;
  final String languageCode;
  final String coverImage;
  final List<TalePage> pages;

  const Tale({
    required this.id,
    required this.title,
    required this.description,
    required this.languageCode,
    required this.coverImage,
    required this.pages,
  });

  factory Tale.fromJson(Map<String, dynamic> json) => Tale(
        id: json['id'] ?? "",
        title: json['title'] ?? "",
        description: json['description'] ?? "",
        languageCode: json['language_code'] ?? "",
        coverImage: json['cover_image'] ?? "",
        pages: (json['tale_pages'] as List<dynamic>?)?.map((e) => TalePage.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      );

  @override
  List<Object?> get props => [id, title, description, languageCode, coverImage, pages];
}
