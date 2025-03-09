import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myspace_data/myspace_data.dart';

part 'tale_interaction_size.freezed.dart';

@freezed
class TaleInteractionSize with _$TaleInteractionSize {
  const TaleInteractionSize._();

  const factory TaleInteractionSize(
    num w,
    num h,
  ) = _TaleInteractionSize;

  static const TaleInteractionSize zero = TaleInteractionSize(0, 0);

  factory TaleInteractionSize.fromJson(Map<String, dynamic> json) {
    try {
      var model = zero;

      if (json['h'] != null) {
        model = model.copyWith(
          h: json['h'] as num,
        );
      }
      if (json['w'] != null) {
        model = model.copyWith(
          w: json['w'] as num,
        );
      }

      return model;
    } catch (e, st) {
      Log().error('TaleInteractionSize.fromJson', e, st);
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => {
        'w': w,
        'h': h,
      };

  factory TaleInteractionSize.fromSize(Size size) =>
      TaleInteractionSize(size.width, size.height);

  Size toSize() => Size(width, height);

  double get width => w.toDouble();
  double get height => h.toDouble();
}
