import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myspace_data/src/annotations/json_serializable.dart';

part 'tale_interaction_position.freezed.dart';
part 'tale_interaction_position.g.dart';

@freezed
class TaleInteractionPosition with _$TaleInteractionPosition {
  const TaleInteractionPosition._();

  @appJsonSerializable
  const factory TaleInteractionPosition(
    num x,
    num y,
  ) = _TaleInteractionPosition;

  //static methods
  static const TaleInteractionPosition zero = TaleInteractionPosition(0, 0);

  // factory methods
  factory TaleInteractionPosition.fromJson(Map<String, dynamic> json) => _$TaleInteractionPositionFromJson(json);
  factory TaleInteractionPosition.fromOffset(Offset offset) => TaleInteractionPosition(offset.dx, offset.dy);

  // instance methods
  Offset toOffset() => Offset(dx.toDouble(), dy.toDouble());

  // getters
  double get dx => x.toDouble();
  double get dy => y.toDouble();
}
