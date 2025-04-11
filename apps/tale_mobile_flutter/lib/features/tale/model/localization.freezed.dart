// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'localization.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TaleLocalizationModel {

 String get taleId; Map<String, Map<String, String>> get translations; String get defaultLocale;
/// Create a copy of TaleLocalizationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaleLocalizationModelCopyWith<TaleLocalizationModel> get copyWith => _$TaleLocalizationModelCopyWithImpl<TaleLocalizationModel>(this as TaleLocalizationModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaleLocalizationModel&&(identical(other.taleId, taleId) || other.taleId == taleId)&&const DeepCollectionEquality().equals(other.translations, translations)&&(identical(other.defaultLocale, defaultLocale) || other.defaultLocale == defaultLocale));
}


@override
int get hashCode => Object.hash(runtimeType,taleId,const DeepCollectionEquality().hash(translations),defaultLocale);

@override
String toString() {
  return 'TaleLocalizationModel(taleId: $taleId, translations: $translations, defaultLocale: $defaultLocale)';
}


}

/// @nodoc
abstract mixin class $TaleLocalizationModelCopyWith<$Res>  {
  factory $TaleLocalizationModelCopyWith(TaleLocalizationModel value, $Res Function(TaleLocalizationModel) _then) = _$TaleLocalizationModelCopyWithImpl;
@useResult
$Res call({
 String taleId, Map<String, Map<String, String>> translations, String defaultLocale
});




}
/// @nodoc
class _$TaleLocalizationModelCopyWithImpl<$Res>
    implements $TaleLocalizationModelCopyWith<$Res> {
  _$TaleLocalizationModelCopyWithImpl(this._self, this._then);

  final TaleLocalizationModel _self;
  final $Res Function(TaleLocalizationModel) _then;

/// Create a copy of TaleLocalizationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? taleId = null,Object? translations = null,Object? defaultLocale = null,}) {
  return _then(_self.copyWith(
taleId: null == taleId ? _self.taleId : taleId // ignore: cast_nullable_to_non_nullable
as String,translations: null == translations ? _self.translations : translations // ignore: cast_nullable_to_non_nullable
as Map<String, Map<String, String>>,defaultLocale: null == defaultLocale ? _self.defaultLocale : defaultLocale // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc


class _TaleLocalizationModel extends TaleLocalizationModel {
  const _TaleLocalizationModel({required this.taleId, final  Map<String, Map<String, String>> translations = const {}, this.defaultLocale = 'en'}): _translations = translations,super._();
  

@override final  String taleId;
 final  Map<String, Map<String, String>> _translations;
@override@JsonKey() Map<String, Map<String, String>> get translations {
  if (_translations is EqualUnmodifiableMapView) return _translations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_translations);
}

@override@JsonKey() final  String defaultLocale;

/// Create a copy of TaleLocalizationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaleLocalizationModelCopyWith<_TaleLocalizationModel> get copyWith => __$TaleLocalizationModelCopyWithImpl<_TaleLocalizationModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaleLocalizationModel&&(identical(other.taleId, taleId) || other.taleId == taleId)&&const DeepCollectionEquality().equals(other._translations, _translations)&&(identical(other.defaultLocale, defaultLocale) || other.defaultLocale == defaultLocale));
}


@override
int get hashCode => Object.hash(runtimeType,taleId,const DeepCollectionEquality().hash(_translations),defaultLocale);

@override
String toString() {
  return 'TaleLocalizationModel(taleId: $taleId, translations: $translations, defaultLocale: $defaultLocale)';
}


}

/// @nodoc
abstract mixin class _$TaleLocalizationModelCopyWith<$Res> implements $TaleLocalizationModelCopyWith<$Res> {
  factory _$TaleLocalizationModelCopyWith(_TaleLocalizationModel value, $Res Function(_TaleLocalizationModel) _then) = __$TaleLocalizationModelCopyWithImpl;
@override @useResult
$Res call({
 String taleId, Map<String, Map<String, String>> translations, String defaultLocale
});




}
/// @nodoc
class __$TaleLocalizationModelCopyWithImpl<$Res>
    implements _$TaleLocalizationModelCopyWith<$Res> {
  __$TaleLocalizationModelCopyWithImpl(this._self, this._then);

  final _TaleLocalizationModel _self;
  final $Res Function(_TaleLocalizationModel) _then;

/// Create a copy of TaleLocalizationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? taleId = null,Object? translations = null,Object? defaultLocale = null,}) {
  return _then(_TaleLocalizationModel(
taleId: null == taleId ? _self.taleId : taleId // ignore: cast_nullable_to_non_nullable
as String,translations: null == translations ? _self._translations : translations // ignore: cast_nullable_to_non_nullable
as Map<String, Map<String, String>>,defaultLocale: null == defaultLocale ? _self.defaultLocale : defaultLocale // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
