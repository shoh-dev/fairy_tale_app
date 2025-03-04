// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tale_interaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TaleInteraction _$TaleInteractionFromJson(Map<String, dynamic> json) {
  return _TaleInteraction.fromJson(json);
}

/// @nodoc
mixin _$TaleInteraction {
  String get id => throw _privateConstructorUsedError;
  String get talePageId => throw _privateConstructorUsedError;
  String get eventType => throw _privateConstructorUsedError;
  String get eventSubtype => throw _privateConstructorUsedError;
  int get animationDuration => throw _privateConstructorUsedError;
  TaleInteractionSize get size => throw _privateConstructorUsedError;
  @JsonKey(name: 'initial_pos')
  TaleInteractionPosition get initialPosition =>
      throw _privateConstructorUsedError;
  TaleInteractionMetadata get metadata => throw _privateConstructorUsedError;
  String? get hintKey => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false)
  bool get isUsed => throw _privateConstructorUsedError;
  @JsonKey(name: 'final_pos')
  TaleInteractionPosition? get finalPosition =>
      throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false)
  TaleInteractionPosition get currentPosition =>
      throw _privateConstructorUsedError;

  /// Serializes this TaleInteraction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TaleInteraction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaleInteractionCopyWith<TaleInteraction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaleInteractionCopyWith<$Res> {
  factory $TaleInteractionCopyWith(
          TaleInteraction value, $Res Function(TaleInteraction) then) =
      _$TaleInteractionCopyWithImpl<$Res, TaleInteraction>;
  @useResult
  $Res call(
      {String id,
      String talePageId,
      String eventType,
      String eventSubtype,
      int animationDuration,
      TaleInteractionSize size,
      @JsonKey(name: 'initial_pos') TaleInteractionPosition initialPosition,
      TaleInteractionMetadata metadata,
      String? hintKey,
      @JsonKey(includeFromJson: false) bool isUsed,
      @JsonKey(name: 'final_pos') TaleInteractionPosition? finalPosition,
      @JsonKey(includeFromJson: false)
      TaleInteractionPosition currentPosition});

  $TaleInteractionSizeCopyWith<$Res> get size;
  $TaleInteractionPositionCopyWith<$Res> get initialPosition;
  $TaleInteractionMetadataCopyWith<$Res> get metadata;
  $TaleInteractionPositionCopyWith<$Res>? get finalPosition;
  $TaleInteractionPositionCopyWith<$Res> get currentPosition;
}

/// @nodoc
class _$TaleInteractionCopyWithImpl<$Res, $Val extends TaleInteraction>
    implements $TaleInteractionCopyWith<$Res> {
  _$TaleInteractionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaleInteraction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? talePageId = null,
    Object? eventType = null,
    Object? eventSubtype = null,
    Object? animationDuration = null,
    Object? size = null,
    Object? initialPosition = null,
    Object? metadata = null,
    Object? hintKey = freezed,
    Object? isUsed = null,
    Object? finalPosition = freezed,
    Object? currentPosition = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      talePageId: null == talePageId
          ? _value.talePageId
          : talePageId // ignore: cast_nullable_to_non_nullable
              as String,
      eventType: null == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as String,
      eventSubtype: null == eventSubtype
          ? _value.eventSubtype
          : eventSubtype // ignore: cast_nullable_to_non_nullable
              as String,
      animationDuration: null == animationDuration
          ? _value.animationDuration
          : animationDuration // ignore: cast_nullable_to_non_nullable
              as int,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as TaleInteractionSize,
      initialPosition: null == initialPosition
          ? _value.initialPosition
          : initialPosition // ignore: cast_nullable_to_non_nullable
              as TaleInteractionPosition,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as TaleInteractionMetadata,
      hintKey: freezed == hintKey
          ? _value.hintKey
          : hintKey // ignore: cast_nullable_to_non_nullable
              as String?,
      isUsed: null == isUsed
          ? _value.isUsed
          : isUsed // ignore: cast_nullable_to_non_nullable
              as bool,
      finalPosition: freezed == finalPosition
          ? _value.finalPosition
          : finalPosition // ignore: cast_nullable_to_non_nullable
              as TaleInteractionPosition?,
      currentPosition: null == currentPosition
          ? _value.currentPosition
          : currentPosition // ignore: cast_nullable_to_non_nullable
              as TaleInteractionPosition,
    ) as $Val);
  }

  /// Create a copy of TaleInteraction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TaleInteractionSizeCopyWith<$Res> get size {
    return $TaleInteractionSizeCopyWith<$Res>(_value.size, (value) {
      return _then(_value.copyWith(size: value) as $Val);
    });
  }

  /// Create a copy of TaleInteraction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TaleInteractionPositionCopyWith<$Res> get initialPosition {
    return $TaleInteractionPositionCopyWith<$Res>(_value.initialPosition,
        (value) {
      return _then(_value.copyWith(initialPosition: value) as $Val);
    });
  }

  /// Create a copy of TaleInteraction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TaleInteractionMetadataCopyWith<$Res> get metadata {
    return $TaleInteractionMetadataCopyWith<$Res>(_value.metadata, (value) {
      return _then(_value.copyWith(metadata: value) as $Val);
    });
  }

  /// Create a copy of TaleInteraction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TaleInteractionPositionCopyWith<$Res>? get finalPosition {
    if (_value.finalPosition == null) {
      return null;
    }

    return $TaleInteractionPositionCopyWith<$Res>(_value.finalPosition!,
        (value) {
      return _then(_value.copyWith(finalPosition: value) as $Val);
    });
  }

  /// Create a copy of TaleInteraction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TaleInteractionPositionCopyWith<$Res> get currentPosition {
    return $TaleInteractionPositionCopyWith<$Res>(_value.currentPosition,
        (value) {
      return _then(_value.copyWith(currentPosition: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TaleInteractionImplCopyWith<$Res>
    implements $TaleInteractionCopyWith<$Res> {
  factory _$$TaleInteractionImplCopyWith(_$TaleInteractionImpl value,
          $Res Function(_$TaleInteractionImpl) then) =
      __$$TaleInteractionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String talePageId,
      String eventType,
      String eventSubtype,
      int animationDuration,
      TaleInteractionSize size,
      @JsonKey(name: 'initial_pos') TaleInteractionPosition initialPosition,
      TaleInteractionMetadata metadata,
      String? hintKey,
      @JsonKey(includeFromJson: false) bool isUsed,
      @JsonKey(name: 'final_pos') TaleInteractionPosition? finalPosition,
      @JsonKey(includeFromJson: false)
      TaleInteractionPosition currentPosition});

  @override
  $TaleInteractionSizeCopyWith<$Res> get size;
  @override
  $TaleInteractionPositionCopyWith<$Res> get initialPosition;
  @override
  $TaleInteractionMetadataCopyWith<$Res> get metadata;
  @override
  $TaleInteractionPositionCopyWith<$Res>? get finalPosition;
  @override
  $TaleInteractionPositionCopyWith<$Res> get currentPosition;
}

/// @nodoc
class __$$TaleInteractionImplCopyWithImpl<$Res>
    extends _$TaleInteractionCopyWithImpl<$Res, _$TaleInteractionImpl>
    implements _$$TaleInteractionImplCopyWith<$Res> {
  __$$TaleInteractionImplCopyWithImpl(
      _$TaleInteractionImpl _value, $Res Function(_$TaleInteractionImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaleInteraction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? talePageId = null,
    Object? eventType = null,
    Object? eventSubtype = null,
    Object? animationDuration = null,
    Object? size = null,
    Object? initialPosition = null,
    Object? metadata = null,
    Object? hintKey = freezed,
    Object? isUsed = null,
    Object? finalPosition = freezed,
    Object? currentPosition = null,
  }) {
    return _then(_$TaleInteractionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      talePageId: null == talePageId
          ? _value.talePageId
          : talePageId // ignore: cast_nullable_to_non_nullable
              as String,
      eventType: null == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as String,
      eventSubtype: null == eventSubtype
          ? _value.eventSubtype
          : eventSubtype // ignore: cast_nullable_to_non_nullable
              as String,
      animationDuration: null == animationDuration
          ? _value.animationDuration
          : animationDuration // ignore: cast_nullable_to_non_nullable
              as int,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as TaleInteractionSize,
      initialPosition: null == initialPosition
          ? _value.initialPosition
          : initialPosition // ignore: cast_nullable_to_non_nullable
              as TaleInteractionPosition,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as TaleInteractionMetadata,
      hintKey: freezed == hintKey
          ? _value.hintKey
          : hintKey // ignore: cast_nullable_to_non_nullable
              as String?,
      isUsed: null == isUsed
          ? _value.isUsed
          : isUsed // ignore: cast_nullable_to_non_nullable
              as bool,
      finalPosition: freezed == finalPosition
          ? _value.finalPosition
          : finalPosition // ignore: cast_nullable_to_non_nullable
              as TaleInteractionPosition?,
      currentPosition: null == currentPosition
          ? _value.currentPosition
          : currentPosition // ignore: cast_nullable_to_non_nullable
              as TaleInteractionPosition,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$TaleInteractionImpl extends _TaleInteraction {
  const _$TaleInteractionImpl(
      {required this.id,
      required this.talePageId,
      required this.eventType,
      required this.eventSubtype,
      required this.animationDuration,
      required this.size,
      @JsonKey(name: 'initial_pos') required this.initialPosition,
      required this.metadata,
      this.hintKey,
      @JsonKey(includeFromJson: false) this.isUsed = false,
      @JsonKey(name: 'final_pos') this.finalPosition,
      @JsonKey(includeFromJson: false)
      this.currentPosition = TaleInteractionPosition.zero})
      : super._();

  factory _$TaleInteractionImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaleInteractionImplFromJson(json);

  @override
  final String id;
  @override
  final String talePageId;
  @override
  final String eventType;
  @override
  final String eventSubtype;
  @override
  final int animationDuration;
  @override
  final TaleInteractionSize size;
  @override
  @JsonKey(name: 'initial_pos')
  final TaleInteractionPosition initialPosition;
  @override
  final TaleInteractionMetadata metadata;
  @override
  final String? hintKey;
  @override
  @JsonKey(includeFromJson: false)
  final bool isUsed;
  @override
  @JsonKey(name: 'final_pos')
  final TaleInteractionPosition? finalPosition;
  @override
  @JsonKey(includeFromJson: false)
  final TaleInteractionPosition currentPosition;

  @override
  String toString() {
    return 'TaleInteraction(id: $id, talePageId: $talePageId, eventType: $eventType, eventSubtype: $eventSubtype, animationDuration: $animationDuration, size: $size, initialPosition: $initialPosition, metadata: $metadata, hintKey: $hintKey, isUsed: $isUsed, finalPosition: $finalPosition, currentPosition: $currentPosition)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaleInteractionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.talePageId, talePageId) ||
                other.talePageId == talePageId) &&
            (identical(other.eventType, eventType) ||
                other.eventType == eventType) &&
            (identical(other.eventSubtype, eventSubtype) ||
                other.eventSubtype == eventSubtype) &&
            (identical(other.animationDuration, animationDuration) ||
                other.animationDuration == animationDuration) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.initialPosition, initialPosition) ||
                other.initialPosition == initialPosition) &&
            (identical(other.metadata, metadata) ||
                other.metadata == metadata) &&
            (identical(other.hintKey, hintKey) || other.hintKey == hintKey) &&
            (identical(other.isUsed, isUsed) || other.isUsed == isUsed) &&
            (identical(other.finalPosition, finalPosition) ||
                other.finalPosition == finalPosition) &&
            (identical(other.currentPosition, currentPosition) ||
                other.currentPosition == currentPosition));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      talePageId,
      eventType,
      eventSubtype,
      animationDuration,
      size,
      initialPosition,
      metadata,
      hintKey,
      isUsed,
      finalPosition,
      currentPosition);

  /// Create a copy of TaleInteraction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaleInteractionImplCopyWith<_$TaleInteractionImpl> get copyWith =>
      __$$TaleInteractionImplCopyWithImpl<_$TaleInteractionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaleInteractionImplToJson(
      this,
    );
  }
}

abstract class _TaleInteraction extends TaleInteraction {
  const factory _TaleInteraction(
      {required final String id,
      required final String talePageId,
      required final String eventType,
      required final String eventSubtype,
      required final int animationDuration,
      required final TaleInteractionSize size,
      @JsonKey(name: 'initial_pos')
      required final TaleInteractionPosition initialPosition,
      required final TaleInteractionMetadata metadata,
      final String? hintKey,
      @JsonKey(includeFromJson: false) final bool isUsed,
      @JsonKey(name: 'final_pos') final TaleInteractionPosition? finalPosition,
      @JsonKey(includeFromJson: false)
      final TaleInteractionPosition currentPosition}) = _$TaleInteractionImpl;
  const _TaleInteraction._() : super._();

  factory _TaleInteraction.fromJson(Map<String, dynamic> json) =
      _$TaleInteractionImpl.fromJson;

  @override
  String get id;
  @override
  String get talePageId;
  @override
  String get eventType;
  @override
  String get eventSubtype;
  @override
  int get animationDuration;
  @override
  TaleInteractionSize get size;
  @override
  @JsonKey(name: 'initial_pos')
  TaleInteractionPosition get initialPosition;
  @override
  TaleInteractionMetadata get metadata;
  @override
  String? get hintKey;
  @override
  @JsonKey(includeFromJson: false)
  bool get isUsed;
  @override
  @JsonKey(name: 'final_pos')
  TaleInteractionPosition? get finalPosition;
  @override
  @JsonKey(includeFromJson: false)
  TaleInteractionPosition get currentPosition;

  /// Create a copy of TaleInteraction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaleInteractionImplCopyWith<_$TaleInteractionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
