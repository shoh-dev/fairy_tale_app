import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myspace_data/myspace_data.dart';

part 'tale_interaction_position.freezed.dart';

@freezed
class TaleInteractionPosition with _$TaleInteractionPosition {
  const TaleInteractionPosition._();

  const factory TaleInteractionPosition(
    num x,
    num y,
  ) = _TaleInteractionPosition;

  //static methods
  static const TaleInteractionPosition zero = TaleInteractionPosition(0, 0);

  // factory methods
  factory TaleInteractionPosition.fromJson(Map<String, dynamic> json) {
    try {
      var model = zero;

      if (json['x'] != null) {
        model = model.copyWith(
          x: json['x'] as num,
        );
      }
      if (json['y'] != null) {
        model = model.copyWith(
          y: json['y'] as num,
        );
      }

      return model;
    } catch (e, st) {
      Log().error('TaleInteractionPosition.fromJson', e, st);
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => {
        'x': x,
        'y': y,
      };

  factory TaleInteractionPosition.fromOffset(Offset offset) =>
      TaleInteractionPosition(offset.dx, offset.dy);

  // instance methods
  Offset toOffset() => Offset(dx, dy);

  // getters
  double get dx => x.toDouble();
  double get dy => y.toDouble();
}
