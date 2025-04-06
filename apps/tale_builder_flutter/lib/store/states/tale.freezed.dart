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
mixin _$TaleState {

 String get id; String get title; String get description; Orientation get orientation; String get coverImageUrl; String get backgroundAudioUrl;
/// Create a copy of TaleState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaleStateCopyWith<TaleState> get copyWith => _$TaleStateCopyWithImpl<TaleState>(this as TaleState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaleState&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.orientation, orientation) || other.orientation == orientation)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.backgroundAudioUrl, backgroundAudioUrl) || other.backgroundAudioUrl == backgroundAudioUrl));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,orientation,coverImageUrl,backgroundAudioUrl);

@override
String toString() {
  return 'TaleState(id: $id, title: $title, description: $description, orientation: $orientation, coverImageUrl: $coverImageUrl, backgroundAudioUrl: $backgroundAudioUrl)';
}


}

/// @nodoc
abstract mixin class $TaleStateCopyWith<$Res>  {
  factory $TaleStateCopyWith(TaleState value, $Res Function(TaleState) _then) = _$TaleStateCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, Orientation orientation, String coverImageUrl, String backgroundAudioUrl
});




}
/// @nodoc
class _$TaleStateCopyWithImpl<$Res>
    implements $TaleStateCopyWith<$Res> {
  _$TaleStateCopyWithImpl(this._self, this._then);

  final TaleState _self;
  final $Res Function(TaleState) _then;

/// Create a copy of TaleState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? orientation = null,Object? coverImageUrl = null,Object? backgroundAudioUrl = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,orientation: null == orientation ? _self.orientation : orientation // ignore: cast_nullable_to_non_nullable
as Orientation,coverImageUrl: null == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String,backgroundAudioUrl: null == backgroundAudioUrl ? _self.backgroundAudioUrl : backgroundAudioUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc


class _TaleState extends TaleState {
  const _TaleState({this.id = '', this.title = '', this.description = '', this.orientation = Orientation.landscape, this.coverImageUrl = '', this.backgroundAudioUrl = ''}): super._();
  

@override@JsonKey() final  String id;
@override@JsonKey() final  String title;
@override@JsonKey() final  String description;
@override@JsonKey() final  Orientation orientation;
@override@JsonKey() final  String coverImageUrl;
@override@JsonKey() final  String backgroundAudioUrl;

/// Create a copy of TaleState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaleStateCopyWith<_TaleState> get copyWith => __$TaleStateCopyWithImpl<_TaleState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaleState&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.orientation, orientation) || other.orientation == orientation)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.backgroundAudioUrl, backgroundAudioUrl) || other.backgroundAudioUrl == backgroundAudioUrl));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,orientation,coverImageUrl,backgroundAudioUrl);

@override
String toString() {
  return 'TaleState(id: $id, title: $title, description: $description, orientation: $orientation, coverImageUrl: $coverImageUrl, backgroundAudioUrl: $backgroundAudioUrl)';
}


}

/// @nodoc
abstract mixin class _$TaleStateCopyWith<$Res> implements $TaleStateCopyWith<$Res> {
  factory _$TaleStateCopyWith(_TaleState value, $Res Function(_TaleState) _then) = __$TaleStateCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, Orientation orientation, String coverImageUrl, String backgroundAudioUrl
});




}
/// @nodoc
class __$TaleStateCopyWithImpl<$Res>
    implements _$TaleStateCopyWith<$Res> {
  __$TaleStateCopyWithImpl(this._self, this._then);

  final _TaleState _self;
  final $Res Function(_TaleState) _then;

/// Create a copy of TaleState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? orientation = null,Object? coverImageUrl = null,Object? backgroundAudioUrl = null,}) {
  return _then(_TaleState(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,orientation: null == orientation ? _self.orientation : orientation // ignore: cast_nullable_to_non_nullable
as Orientation,coverImageUrl: null == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String,backgroundAudioUrl: null == backgroundAudioUrl ? _self.backgroundAudioUrl : backgroundAudioUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
