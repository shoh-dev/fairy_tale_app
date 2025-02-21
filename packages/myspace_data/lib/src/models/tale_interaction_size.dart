import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myspace_data/src/annotations/json_serializable.dart';

part 'tale_interaction_size.freezed.dart';
part 'tale_interaction_size.g.dart';

@freezed
class TaleInteractionSize with _$TaleInteractionSize {
  const TaleInteractionSize._();

  @appJsonSerializable
  const factory TaleInteractionSize(
    num w,
    num h,
  ) = _TaleInteractionSize;

  static const TaleInteractionSize zero = TaleInteractionSize(0, 0);

  factory TaleInteractionSize.fromJson(Map<String, dynamic> json) => _$TaleInteractionSizeFromJson(json);
  factory TaleInteractionSize.fromOffset(Size size) => TaleInteractionSize(size.width, size.height);

  Size toSize() => Size(width.toDouble(), height.toDouble());

  double get width => w.toDouble();
  double get height => h.toDouble();
}
