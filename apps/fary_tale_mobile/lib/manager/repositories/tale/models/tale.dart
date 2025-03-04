import 'package:fairy_tale_app/manager/repositories/tale/models/tale_page.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tale.freezed.dart';
part 'tale.g.dart';

@freezed
class Tale with _$Tale {
  const Tale._();

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Tale({
    required String id,
    required String title,
    required String description,
    required String coverImage,
    @Default([]) List<TalePage> talePages,
    @Default('portrait') String orientation,
  }) = _Tale;

  factory Tale.fromJson(Map<String, dynamic> json) => _$TaleFromJson(json);

  static const empty = Tale(
    id: '',
    title: '',
    description: '',
    coverImage: '',
  );

  bool get isPortrait => orientation == 'portrait';

  //updatePageMethod
  Tale updatePage(TalePage page) {
    final pages = List<TalePage>.from(talePages);
    final index = pages.indexWhere((element) => element.id == page.id);
    if (index != -1) {
      pages[index] = page;
    }
    return copyWith(talePages: pages);
  }
}

// // Tale Model
// class Tale extends Equatable {
//   final String id;
//   final String title;
//   final String description;
//   final String languageCode;
//   final String coverImage;
//   final List<TalePage> pages;

//   const Tale({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.languageCode,
//     required this.coverImage,
//     required this.pages,
//   });

//   factory Tale.fromJson(Map<String, dynamic> json) => Tale(
//         id: json['id'] ?? "",
//         title: json['title'] ?? "",
//         description: json['description'] ?? "",
//         languageCode: json['language_code'] ?? "",
//         coverImage: json['cover_image'] ?? "",
//         pages: (json['tale_pages'] as List<dynamic>?)?.map((e) =>
//TalePage.fromJson(e as Map<String, dynamic>)).toList() ?? [],
//       );

//   @override
//   List<Object?> get props =>
//[id, title, description, languageCode, coverImage, pages];

//   static const empty = Tale(
//     id: "",
//     title: "",
//     description: "",
//     languageCode: "",
//     coverImage: "",
//     pages: [],
//   );

//   //copyWithMethod
//   Tale _copyWith({
//     String? id,
//     String? title,
//     String? description,
//     String? languageCode,
//     String? coverImage,
//     List<TalePage>? pages,
//   }) {
//     return Tale(
//       id: id ?? this.id,
//       title: title ?? this.title,
//       description: description ?? this.description,
//       languageCode: languageCode ?? this.languageCode,
//       coverImage: coverImage ?? this.coverImage,
//       pages: pages ?? this.pages,
//     );
//   }

//   //updatePageMethod
//   Tale updatePage(TalePage page) {
//     final pages = List<TalePage>.from(this.pages);
//     final index = pages.indexWhere((element) => element.id == page.id);
//     if (index != -1) {
//       pages[index] = page;
//     }
//     return _copyWith(pages: pages);
//   }

//   @override
//   String toString() {
//     return
//"Tale(id: $id, title: $title, description: $description, languageCode:
//$languageCode, coverImage: $coverImage, pages: $pages)";
//   }
// }
