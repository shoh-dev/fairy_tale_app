// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'object.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TaleObjectModel {

 String get imageUrl; String get pageId; double get width; double get height; double get dx; double get dy;
/// Create a copy of TaleObjectModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaleObjectModelCopyWith<TaleObjectModel> get copyWith => _$TaleObjectModelCopyWithImpl<TaleObjectModel>(this as TaleObjectModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaleObjectModel&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.pageId, pageId) || other.pageId == pageId)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.dx, dx) || other.dx == dx)&&(identical(other.dy, dy) || other.dy == dy));
}


@override
int get hashCode => Object.hash(runtimeType,imageUrl,pageId,width,height,dx,dy);

@override
String toString() {
  return 'TaleObjectModel(imageUrl: $imageUrl, pageId: $pageId, width: $width, height: $height, dx: $dx, dy: $dy)';
}


}

/// @nodoc
abstract mixin class $TaleObjectModelCopyWith<$Res>  {
  factory $TaleObjectModelCopyWith(TaleObjectModel value, $Res Function(TaleObjectModel) _then) = _$TaleObjectModelCopyWithImpl;
@useResult
$Res call({
 String imageUrl, String pageId, double width, double height, double dx, double dy
});




}
/// @nodoc
class _$TaleObjectModelCopyWithImpl<$Res>
    implements $TaleObjectModelCopyWith<$Res> {
  _$TaleObjectModelCopyWithImpl(this._self, this._then);

  final TaleObjectModel _self;
  final $Res Function(TaleObjectModel) _then;

/// Create a copy of TaleObjectModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? imageUrl = null,Object? pageId = null,Object? width = null,Object? height = null,Object? dx = null,Object? dy = null,}) {
  return _then(_self.copyWith(
imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,pageId: null == pageId ? _self.pageId : pageId // ignore: cast_nullable_to_non_nullable
as String,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,dx: null == dx ? _self.dx : dx // ignore: cast_nullable_to_non_nullable
as double,dy: null == dy ? _self.dy : dy // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// @nodoc


class _TaleObjectModel extends TaleObjectModel {
  const _TaleObjectModel({required this.imageUrl, required this.pageId, this.width = 100, this.height = 100, this.dx = 0, this.dy = 0}): super._();
  

@override final  String imageUrl;
@override final  String pageId;
@override@JsonKey() final  double width;
@override@JsonKey() final  double height;
@override@JsonKey() final  double dx;
@override@JsonKey() final  double dy;

/// Create a copy of TaleObjectModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaleObjectModelCopyWith<_TaleObjectModel> get copyWith => __$TaleObjectModelCopyWithImpl<_TaleObjectModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaleObjectModel&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.pageId, pageId) || other.pageId == pageId)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.dx, dx) || other.dx == dx)&&(identical(other.dy, dy) || other.dy == dy));
}


@override
int get hashCode => Object.hash(runtimeType,imageUrl,pageId,width,height,dx,dy);

@override
String toString() {
  return 'TaleObjectModel(imageUrl: $imageUrl, pageId: $pageId, width: $width, height: $height, dx: $dx, dy: $dy)';
}


}

/// @nodoc
abstract mixin class _$TaleObjectModelCopyWith<$Res> implements $TaleObjectModelCopyWith<$Res> {
  factory _$TaleObjectModelCopyWith(_TaleObjectModel value, $Res Function(_TaleObjectModel) _then) = __$TaleObjectModelCopyWithImpl;
@override @useResult
$Res call({
 String imageUrl, String pageId, double width, double height, double dx, double dy
});




}
/// @nodoc
class __$TaleObjectModelCopyWithImpl<$Res>
    implements _$TaleObjectModelCopyWith<$Res> {
  __$TaleObjectModelCopyWithImpl(this._self, this._then);

  final _TaleObjectModel _self;
  final $Res Function(_TaleObjectModel) _then;

/// Create a copy of TaleObjectModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? imageUrl = null,Object? pageId = null,Object? width = null,Object? height = null,Object? dx = null,Object? dy = null,}) {
  return _then(_TaleObjectModel(
imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,pageId: null == pageId ? _self.pageId : pageId // ignore: cast_nullable_to_non_nullable
as String,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,dx: null == dx ? _self.dx : dx // ignore: cast_nullable_to_non_nullable
as double,dy: null == dy ? _self.dy : dy // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
