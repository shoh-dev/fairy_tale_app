// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tale.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TaleModel {

 String get id; String get title; String get description; String get orientation; String get coverImageUrl; String get backgroundAudioUrl; TaleLocalizationModel get localization; List<TalePageModel> get pages;
/// Create a copy of TaleModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaleModelCopyWith<TaleModel> get copyWith => _$TaleModelCopyWithImpl<TaleModel>(this as TaleModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaleModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.orientation, orientation) || other.orientation == orientation)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.backgroundAudioUrl, backgroundAudioUrl) || other.backgroundAudioUrl == backgroundAudioUrl)&&(identical(other.localization, localization) || other.localization == localization)&&const DeepCollectionEquality().equals(other.pages, pages));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,orientation,coverImageUrl,backgroundAudioUrl,localization,const DeepCollectionEquality().hash(pages));

@override
String toString() {
  return 'TaleModel(id: $id, title: $title, description: $description, orientation: $orientation, coverImageUrl: $coverImageUrl, backgroundAudioUrl: $backgroundAudioUrl, localization: $localization, pages: $pages)';
}


}

/// @nodoc
abstract mixin class $TaleModelCopyWith<$Res>  {
  factory $TaleModelCopyWith(TaleModel value, $Res Function(TaleModel) _then) = _$TaleModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, String orientation, String coverImageUrl, String backgroundAudioUrl, TaleLocalizationModel localization, List<TalePageModel> pages
});


$TaleLocalizationModelCopyWith<$Res> get localization;

}
/// @nodoc
class _$TaleModelCopyWithImpl<$Res>
    implements $TaleModelCopyWith<$Res> {
  _$TaleModelCopyWithImpl(this._self, this._then);

  final TaleModel _self;
  final $Res Function(TaleModel) _then;

/// Create a copy of TaleModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? orientation = null,Object? coverImageUrl = null,Object? backgroundAudioUrl = null,Object? localization = null,Object? pages = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,orientation: null == orientation ? _self.orientation : orientation // ignore: cast_nullable_to_non_nullable
as String,coverImageUrl: null == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String,backgroundAudioUrl: null == backgroundAudioUrl ? _self.backgroundAudioUrl : backgroundAudioUrl // ignore: cast_nullable_to_non_nullable
as String,localization: null == localization ? _self.localization : localization // ignore: cast_nullable_to_non_nullable
as TaleLocalizationModel,pages: null == pages ? _self.pages : pages // ignore: cast_nullable_to_non_nullable
as List<TalePageModel>,
  ));
}
/// Create a copy of TaleModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaleLocalizationModelCopyWith<$Res> get localization {
  
  return $TaleLocalizationModelCopyWith<$Res>(_self.localization, (value) {
    return _then(_self.copyWith(localization: value));
  });
}
}


/// @nodoc


class _TaleModel extends TaleModel {
  const _TaleModel({required this.id, this.title = '', this.description = '', this.orientation = 'landscape', this.coverImageUrl = '', this.backgroundAudioUrl = '', required this.localization, final  List<TalePageModel> pages = const []}): _pages = pages,super._();
  

@override final  String id;
@override@JsonKey() final  String title;
@override@JsonKey() final  String description;
@override@JsonKey() final  String orientation;
@override@JsonKey() final  String coverImageUrl;
@override@JsonKey() final  String backgroundAudioUrl;
@override final  TaleLocalizationModel localization;
 final  List<TalePageModel> _pages;
@override@JsonKey() List<TalePageModel> get pages {
  if (_pages is EqualUnmodifiableListView) return _pages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pages);
}


/// Create a copy of TaleModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaleModelCopyWith<_TaleModel> get copyWith => __$TaleModelCopyWithImpl<_TaleModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaleModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.orientation, orientation) || other.orientation == orientation)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.backgroundAudioUrl, backgroundAudioUrl) || other.backgroundAudioUrl == backgroundAudioUrl)&&(identical(other.localization, localization) || other.localization == localization)&&const DeepCollectionEquality().equals(other._pages, _pages));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,orientation,coverImageUrl,backgroundAudioUrl,localization,const DeepCollectionEquality().hash(_pages));

@override
String toString() {
  return 'TaleModel(id: $id, title: $title, description: $description, orientation: $orientation, coverImageUrl: $coverImageUrl, backgroundAudioUrl: $backgroundAudioUrl, localization: $localization, pages: $pages)';
}


}

/// @nodoc
abstract mixin class _$TaleModelCopyWith<$Res> implements $TaleModelCopyWith<$Res> {
  factory _$TaleModelCopyWith(_TaleModel value, $Res Function(_TaleModel) _then) = __$TaleModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, String orientation, String coverImageUrl, String backgroundAudioUrl, TaleLocalizationModel localization, List<TalePageModel> pages
});


@override $TaleLocalizationModelCopyWith<$Res> get localization;

}
/// @nodoc
class __$TaleModelCopyWithImpl<$Res>
    implements _$TaleModelCopyWith<$Res> {
  __$TaleModelCopyWithImpl(this._self, this._then);

  final _TaleModel _self;
  final $Res Function(_TaleModel) _then;

/// Create a copy of TaleModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? orientation = null,Object? coverImageUrl = null,Object? backgroundAudioUrl = null,Object? localization = null,Object? pages = null,}) {
  return _then(_TaleModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,orientation: null == orientation ? _self.orientation : orientation // ignore: cast_nullable_to_non_nullable
as String,coverImageUrl: null == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String,backgroundAudioUrl: null == backgroundAudioUrl ? _self.backgroundAudioUrl : backgroundAudioUrl // ignore: cast_nullable_to_non_nullable
as String,localization: null == localization ? _self.localization : localization // ignore: cast_nullable_to_non_nullable
as TaleLocalizationModel,pages: null == pages ? _self._pages : pages // ignore: cast_nullable_to_non_nullable
as List<TalePageModel>,
  ));
}

/// Create a copy of TaleModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaleLocalizationModelCopyWith<$Res> get localization {
  
  return $TaleLocalizationModelCopyWith<$Res>(_self.localization, (value) {
    return _then(_self.copyWith(localization: value));
  });
}
}

// dart format on
