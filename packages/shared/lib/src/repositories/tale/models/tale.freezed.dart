// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tale.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Tale _$TaleFromJson(Map<String, dynamic> json) {
  return _Tale.fromJson(json);
}

/// @nodoc
mixin _$Tale {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get coverImage => throw _privateConstructorUsedError;
  TaleLocalization get localizations => throw _privateConstructorUsedError;
  List<TalePage> get pages => throw _privateConstructorUsedError;
  String get orientation => throw _privateConstructorUsedError;
  int get toReRender => throw _privateConstructorUsedError;

  /// Serializes this Tale to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Tale
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaleCopyWith<Tale> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaleCopyWith<$Res> {
  factory $TaleCopyWith(Tale value, $Res Function(Tale) then) =
      _$TaleCopyWithImpl<$Res, Tale>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String coverImage,
      TaleLocalization localizations,
      List<TalePage> pages,
      String orientation,
      int toReRender});

  $TaleLocalizationCopyWith<$Res> get localizations;
}

/// @nodoc
class _$TaleCopyWithImpl<$Res, $Val extends Tale>
    implements $TaleCopyWith<$Res> {
  _$TaleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Tale
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? coverImage = null,
    Object? localizations = null,
    Object? pages = null,
    Object? orientation = null,
    Object? toReRender = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      coverImage: null == coverImage
          ? _value.coverImage
          : coverImage // ignore: cast_nullable_to_non_nullable
              as String,
      localizations: null == localizations
          ? _value.localizations
          : localizations // ignore: cast_nullable_to_non_nullable
              as TaleLocalization,
      pages: null == pages
          ? _value.pages
          : pages // ignore: cast_nullable_to_non_nullable
              as List<TalePage>,
      orientation: null == orientation
          ? _value.orientation
          : orientation // ignore: cast_nullable_to_non_nullable
              as String,
      toReRender: null == toReRender
          ? _value.toReRender
          : toReRender // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  /// Create a copy of Tale
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TaleLocalizationCopyWith<$Res> get localizations {
    return $TaleLocalizationCopyWith<$Res>(_value.localizations, (value) {
      return _then(_value.copyWith(localizations: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TaleImplCopyWith<$Res> implements $TaleCopyWith<$Res> {
  factory _$$TaleImplCopyWith(
          _$TaleImpl value, $Res Function(_$TaleImpl) then) =
      __$$TaleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String coverImage,
      TaleLocalization localizations,
      List<TalePage> pages,
      String orientation,
      int toReRender});

  @override
  $TaleLocalizationCopyWith<$Res> get localizations;
}

/// @nodoc
class __$$TaleImplCopyWithImpl<$Res>
    extends _$TaleCopyWithImpl<$Res, _$TaleImpl>
    implements _$$TaleImplCopyWith<$Res> {
  __$$TaleImplCopyWithImpl(_$TaleImpl _value, $Res Function(_$TaleImpl) _then)
      : super(_value, _then);

  /// Create a copy of Tale
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? coverImage = null,
    Object? localizations = null,
    Object? pages = null,
    Object? orientation = null,
    Object? toReRender = null,
  }) {
    return _then(_$TaleImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      coverImage: null == coverImage
          ? _value.coverImage
          : coverImage // ignore: cast_nullable_to_non_nullable
              as String,
      localizations: null == localizations
          ? _value.localizations
          : localizations // ignore: cast_nullable_to_non_nullable
              as TaleLocalization,
      pages: null == pages
          ? _value._pages
          : pages // ignore: cast_nullable_to_non_nullable
              as List<TalePage>,
      orientation: null == orientation
          ? _value.orientation
          : orientation // ignore: cast_nullable_to_non_nullable
              as String,
      toReRender: null == toReRender
          ? _value.toReRender
          : toReRender // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$TaleImpl extends _Tale {
  const _$TaleImpl(
      {required this.id,
      required this.title,
      required this.description,
      required this.coverImage,
      this.localizations = TaleLocalization.empty,
      final List<TalePage> pages = const [],
      this.orientation = 'portrait',
      this.toReRender = 0})
      : _pages = pages,
        super._();

  factory _$TaleImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaleImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String coverImage;
  @override
  @JsonKey()
  final TaleLocalization localizations;
  final List<TalePage> _pages;
  @override
  @JsonKey()
  List<TalePage> get pages {
    if (_pages is EqualUnmodifiableListView) return _pages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pages);
  }

  @override
  @JsonKey()
  final String orientation;
  @override
  @JsonKey()
  final int toReRender;

  @override
  String toString() {
    return 'Tale(id: $id, title: $title, description: $description, coverImage: $coverImage, localizations: $localizations, pages: $pages, orientation: $orientation, toReRender: $toReRender)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.coverImage, coverImage) ||
                other.coverImage == coverImage) &&
            (identical(other.localizations, localizations) ||
                other.localizations == localizations) &&
            const DeepCollectionEquality().equals(other._pages, _pages) &&
            (identical(other.orientation, orientation) ||
                other.orientation == orientation) &&
            (identical(other.toReRender, toReRender) ||
                other.toReRender == toReRender));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      coverImage,
      localizations,
      const DeepCollectionEquality().hash(_pages),
      orientation,
      toReRender);

  /// Create a copy of Tale
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaleImplCopyWith<_$TaleImpl> get copyWith =>
      __$$TaleImplCopyWithImpl<_$TaleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaleImplToJson(
      this,
    );
  }
}

abstract class _Tale extends Tale {
  const factory _Tale(
      {required final String id,
      required final String title,
      required final String description,
      required final String coverImage,
      final TaleLocalization localizations,
      final List<TalePage> pages,
      final String orientation,
      final int toReRender}) = _$TaleImpl;
  const _Tale._() : super._();

  factory _Tale.fromJson(Map<String, dynamic> json) = _$TaleImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  String get coverImage;
  @override
  TaleLocalization get localizations;
  @override
  List<TalePage> get pages;
  @override
  String get orientation;
  @override
  int get toReRender;

  /// Create a copy of Tale
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaleImplCopyWith<_$TaleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
