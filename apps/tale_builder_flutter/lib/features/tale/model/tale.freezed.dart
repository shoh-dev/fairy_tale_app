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

 String get id; String get title; String get description; String get orientation; String get coverImageUrl; String get backgroundAudioUrl;
/// Create a copy of TaleModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaleModelCopyWith<TaleModel> get copyWith => _$TaleModelCopyWithImpl<TaleModel>(this as TaleModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaleModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.orientation, orientation) || other.orientation == orientation)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.backgroundAudioUrl, backgroundAudioUrl) || other.backgroundAudioUrl == backgroundAudioUrl));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,orientation,coverImageUrl,backgroundAudioUrl);

@override
String toString() {
  return 'TaleModel(id: $id, title: $title, description: $description, orientation: $orientation, coverImageUrl: $coverImageUrl, backgroundAudioUrl: $backgroundAudioUrl)';
}


}

/// @nodoc
abstract mixin class $TaleModelCopyWith<$Res>  {
  factory $TaleModelCopyWith(TaleModel value, $Res Function(TaleModel) _then) = _$TaleModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, String orientation, String coverImageUrl, String backgroundAudioUrl
});




}
/// @nodoc
class _$TaleModelCopyWithImpl<$Res>
    implements $TaleModelCopyWith<$Res> {
  _$TaleModelCopyWithImpl(this._self, this._then);

  final TaleModel _self;
  final $Res Function(TaleModel) _then;

/// Create a copy of TaleModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? orientation = null,Object? coverImageUrl = null,Object? backgroundAudioUrl = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,orientation: null == orientation ? _self.orientation : orientation // ignore: cast_nullable_to_non_nullable
as String,coverImageUrl: null == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String,backgroundAudioUrl: null == backgroundAudioUrl ? _self.backgroundAudioUrl : backgroundAudioUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc


class _TaleModel implements TaleModel {
  const _TaleModel({required this.id, required this.title, required this.description, required this.orientation, required this.coverImageUrl, required this.backgroundAudioUrl});
  

@override final  String id;
@override final  String title;
@override final  String description;
@override final  String orientation;
@override final  String coverImageUrl;
@override final  String backgroundAudioUrl;

/// Create a copy of TaleModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaleModelCopyWith<_TaleModel> get copyWith => __$TaleModelCopyWithImpl<_TaleModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaleModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.orientation, orientation) || other.orientation == orientation)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.backgroundAudioUrl, backgroundAudioUrl) || other.backgroundAudioUrl == backgroundAudioUrl));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,orientation,coverImageUrl,backgroundAudioUrl);

@override
String toString() {
  return 'TaleModel(id: $id, title: $title, description: $description, orientation: $orientation, coverImageUrl: $coverImageUrl, backgroundAudioUrl: $backgroundAudioUrl)';
}


}

/// @nodoc
abstract mixin class _$TaleModelCopyWith<$Res> implements $TaleModelCopyWith<$Res> {
  factory _$TaleModelCopyWith(_TaleModel value, $Res Function(_TaleModel) _then) = __$TaleModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, String orientation, String coverImageUrl, String backgroundAudioUrl
});




}
/// @nodoc
class __$TaleModelCopyWithImpl<$Res>
    implements _$TaleModelCopyWith<$Res> {
  __$TaleModelCopyWithImpl(this._self, this._then);

  final _TaleModel _self;
  final $Res Function(_TaleModel) _then;

/// Create a copy of TaleModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? orientation = null,Object? coverImageUrl = null,Object? backgroundAudioUrl = null,}) {
  return _then(_TaleModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,orientation: null == orientation ? _self.orientation : orientation // ignore: cast_nullable_to_non_nullable
as String,coverImageUrl: null == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String,backgroundAudioUrl: null == backgroundAudioUrl ? _self.backgroundAudioUrl : backgroundAudioUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
