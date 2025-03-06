// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tale_page.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TalePage _$TalePageFromJson(Map<String, dynamic> json) {
  return _TalePage.fromJson(json);
}

/// @nodoc
mixin _$TalePage {
  String get id => throw _privateConstructorUsedError;
  String get taleId => throw _privateConstructorUsedError;
  int get pageNumber => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  TalePageMetadata get metadata => throw _privateConstructorUsedError;
  List<TaleInteraction> get interactions => throw _privateConstructorUsedError;
  bool get isNew => throw _privateConstructorUsedError;

  /// Serializes this TalePage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TalePage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TalePageCopyWith<TalePage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TalePageCopyWith<$Res> {
  factory $TalePageCopyWith(TalePage value, $Res Function(TalePage) then) =
      _$TalePageCopyWithImpl<$Res, TalePage>;
  @useResult
  $Res call(
      {String id,
      String taleId,
      int pageNumber,
      String text,
      TalePageMetadata metadata,
      List<TaleInteraction> interactions,
      bool isNew});

  $TalePageMetadataCopyWith<$Res> get metadata;
}

/// @nodoc
class _$TalePageCopyWithImpl<$Res, $Val extends TalePage>
    implements $TalePageCopyWith<$Res> {
  _$TalePageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TalePage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? taleId = null,
    Object? pageNumber = null,
    Object? text = null,
    Object? metadata = null,
    Object? interactions = null,
    Object? isNew = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      taleId: null == taleId
          ? _value.taleId
          : taleId // ignore: cast_nullable_to_non_nullable
              as String,
      pageNumber: null == pageNumber
          ? _value.pageNumber
          : pageNumber // ignore: cast_nullable_to_non_nullable
              as int,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as TalePageMetadata,
      interactions: null == interactions
          ? _value.interactions
          : interactions // ignore: cast_nullable_to_non_nullable
              as List<TaleInteraction>,
      isNew: null == isNew
          ? _value.isNew
          : isNew // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of TalePage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TalePageMetadataCopyWith<$Res> get metadata {
    return $TalePageMetadataCopyWith<$Res>(_value.metadata, (value) {
      return _then(_value.copyWith(metadata: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TalePageImplCopyWith<$Res>
    implements $TalePageCopyWith<$Res> {
  factory _$$TalePageImplCopyWith(
          _$TalePageImpl value, $Res Function(_$TalePageImpl) then) =
      __$$TalePageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String taleId,
      int pageNumber,
      String text,
      TalePageMetadata metadata,
      List<TaleInteraction> interactions,
      bool isNew});

  @override
  $TalePageMetadataCopyWith<$Res> get metadata;
}

/// @nodoc
class __$$TalePageImplCopyWithImpl<$Res>
    extends _$TalePageCopyWithImpl<$Res, _$TalePageImpl>
    implements _$$TalePageImplCopyWith<$Res> {
  __$$TalePageImplCopyWithImpl(
      _$TalePageImpl _value, $Res Function(_$TalePageImpl) _then)
      : super(_value, _then);

  /// Create a copy of TalePage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? taleId = null,
    Object? pageNumber = null,
    Object? text = null,
    Object? metadata = null,
    Object? interactions = null,
    Object? isNew = null,
  }) {
    return _then(_$TalePageImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      taleId: null == taleId
          ? _value.taleId
          : taleId // ignore: cast_nullable_to_non_nullable
              as String,
      pageNumber: null == pageNumber
          ? _value.pageNumber
          : pageNumber // ignore: cast_nullable_to_non_nullable
              as int,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as TalePageMetadata,
      interactions: null == interactions
          ? _value._interactions
          : interactions // ignore: cast_nullable_to_non_nullable
              as List<TaleInteraction>,
      isNew: null == isNew
          ? _value.isNew
          : isNew // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$TalePageImpl extends _TalePage {
  const _$TalePageImpl(
      {required this.id,
      required this.taleId,
      required this.pageNumber,
      required this.text,
      required this.metadata,
      final List<TaleInteraction> interactions = const [],
      this.isNew = false})
      : _interactions = interactions,
        super._();

  factory _$TalePageImpl.fromJson(Map<String, dynamic> json) =>
      _$$TalePageImplFromJson(json);

  @override
  final String id;
  @override
  final String taleId;
  @override
  final int pageNumber;
  @override
  final String text;
  @override
  final TalePageMetadata metadata;
  final List<TaleInteraction> _interactions;
  @override
  @JsonKey()
  List<TaleInteraction> get interactions {
    if (_interactions is EqualUnmodifiableListView) return _interactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_interactions);
  }

  @override
  @JsonKey()
  final bool isNew;

  @override
  String toString() {
    return 'TalePage(id: $id, taleId: $taleId, pageNumber: $pageNumber, text: $text, metadata: $metadata, interactions: $interactions, isNew: $isNew)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TalePageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.taleId, taleId) || other.taleId == taleId) &&
            (identical(other.pageNumber, pageNumber) ||
                other.pageNumber == pageNumber) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.metadata, metadata) ||
                other.metadata == metadata) &&
            const DeepCollectionEquality()
                .equals(other._interactions, _interactions) &&
            (identical(other.isNew, isNew) || other.isNew == isNew));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, taleId, pageNumber, text,
      metadata, const DeepCollectionEquality().hash(_interactions), isNew);

  /// Create a copy of TalePage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TalePageImplCopyWith<_$TalePageImpl> get copyWith =>
      __$$TalePageImplCopyWithImpl<_$TalePageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TalePageImplToJson(
      this,
    );
  }
}

abstract class _TalePage extends TalePage {
  const factory _TalePage(
      {required final String id,
      required final String taleId,
      required final int pageNumber,
      required final String text,
      required final TalePageMetadata metadata,
      final List<TaleInteraction> interactions,
      final bool isNew}) = _$TalePageImpl;
  const _TalePage._() : super._();

  factory _TalePage.fromJson(Map<String, dynamic> json) =
      _$TalePageImpl.fromJson;

  @override
  String get id;
  @override
  String get taleId;
  @override
  int get pageNumber;
  @override
  String get text;
  @override
  TalePageMetadata get metadata;
  @override
  List<TaleInteraction> get interactions;
  @override
  bool get isNew;

  /// Create a copy of TalePage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TalePageImplCopyWith<_$TalePageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
