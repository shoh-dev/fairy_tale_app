import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/src/repositories/tale/models.dart';

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
    TaleLocalization? localizations,
    @Default([]) List<TalePage> pages,
    @Default('portrait') String orientation,
  }) = _Tale;

  factory Tale.fromJson(Map<String, dynamic> json) => _$TaleFromJson(json);

  Map<dynamic, dynamic> saveToJson() => toJson()
    ..remove('localizations')
    ..remove('pages');

  static const empty = Tale(
    id: '',
    title: '',
    description: '',
    coverImage: '',
  );

  bool get isPortrait => orientation == 'portrait';

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
}
