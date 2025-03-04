import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tale_interaction_size.freezed.dart';
part 'tale_interaction_size.g.dart';

@freezed
class TaleInteractionSize with _$TaleInteractionSize {
  const TaleInteractionSize._();

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory TaleInteractionSize(
    num w,
    num h,
  ) = _TaleInteractionSize;

  static const TaleInteractionSize zero = TaleInteractionSize(0, 0);

  factory TaleInteractionSize.fromJson(Map<String, dynamic> json) =>
      _$TaleInteractionSizeFromJson(json);
  factory TaleInteractionSize.fromSize(Size size) =>
      TaleInteractionSize(size.width, size.height);

  Size toSize() => Size(width, height);

  double get width => w.toDouble();
  double get height => h.toDouble();
}
