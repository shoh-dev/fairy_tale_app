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
  String get backgroundImage => throw _privateConstructorUsedError;
  String get backgroundAudio => throw _privateConstructorUsedError;
  List<TaleInteraction> get taleInteractions =>
      throw _privateConstructorUsedError;
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
      String backgroundImage,
      String backgroundAudio,
      List<TaleInteraction> taleInteractions,
      bool isNew});
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
    Object? backgroundImage = null,
    Object? backgroundAudio = null,
    Object? taleInteractions = null,
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
      backgroundImage: null == backgroundImage
          ? _value.backgroundImage
          : backgroundImage // ignore: cast_nullable_to_non_nullable
              as String,
      backgroundAudio: null == backgroundAudio
          ? _value.backgroundAudio
          : backgroundAudio // ignore: cast_nullable_to_non_nullable
              as String,
      taleInteractions: null == taleInteractions
          ? _value.taleInteractions
          : taleInteractions // ignore: cast_nullable_to_non_nullable
              as List<TaleInteraction>,
      isNew: null == isNew
          ? _value.isNew
          : isNew // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
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
      String backgroundImage,
      String backgroundAudio,
      List<TaleInteraction> taleInteractions,
      bool isNew});
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
    Object? backgroundImage = null,
    Object? backgroundAudio = null,
    Object? taleInteractions = null,
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
      backgroundImage: null == backgroundImage
          ? _value.backgroundImage
          : backgroundImage // ignore: cast_nullable_to_non_nullable
              as String,
      backgroundAudio: null == backgroundAudio
          ? _value.backgroundAudio
          : backgroundAudio // ignore: cast_nullable_to_non_nullable
              as String,
      taleInteractions: null == taleInteractions
          ? _value._taleInteractions
          : taleInteractions // ignore: cast_nullable_to_non_nullable
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
      required this.backgroundImage,
      this.backgroundAudio = '',
      final List<TaleInteraction> taleInteractions = const [],
      this.isNew = false})
      : _taleInteractions = taleInteractions,
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
  final String backgroundImage;
  @override
  @JsonKey()
  final String backgroundAudio;
  final List<TaleInteraction> _taleInteractions;
  @override
  @JsonKey()
  List<TaleInteraction> get taleInteractions {
    if (_taleInteractions is EqualUnmodifiableListView)
      return _taleInteractions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_taleInteractions);
  }

  @override
  @JsonKey()
  final bool isNew;

  @override
  String toString() {
    return 'TalePage(id: $id, taleId: $taleId, pageNumber: $pageNumber, text: $text, backgroundImage: $backgroundImage, backgroundAudio: $backgroundAudio, taleInteractions: $taleInteractions, isNew: $isNew)';
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
            (identical(other.backgroundImage, backgroundImage) ||
                other.backgroundImage == backgroundImage) &&
            (identical(other.backgroundAudio, backgroundAudio) ||
                other.backgroundAudio == backgroundAudio) &&
            const DeepCollectionEquality()
                .equals(other._taleInteractions, _taleInteractions) &&
            (identical(other.isNew, isNew) || other.isNew == isNew));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      taleId,
      pageNumber,
      text,
      backgroundImage,
      backgroundAudio,
      const DeepCollectionEquality().hash(_taleInteractions),
      isNew);

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
      required final String backgroundImage,
      final String backgroundAudio,
      final List<TaleInteraction> taleInteractions,
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
  String get backgroundImage;
  @override
  String get backgroundAudio;
  @override
  List<TaleInteraction> get taleInteractions;
  @override
  bool get isNew;

  /// Create a copy of TalePage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TalePageImplCopyWith<_$TalePageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
