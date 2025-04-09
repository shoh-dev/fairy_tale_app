// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'page.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TalePageModel {

 String get id; String get taleId;///for now not using this property
 int get pageNumber; String get text; bool get isNew; String get backgroundImageUrl;
/// Create a copy of TalePageModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TalePageModelCopyWith<TalePageModel> get copyWith => _$TalePageModelCopyWithImpl<TalePageModel>(this as TalePageModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TalePageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.taleId, taleId) || other.taleId == taleId)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.text, text) || other.text == text)&&(identical(other.isNew, isNew) || other.isNew == isNew)&&(identical(other.backgroundImageUrl, backgroundImageUrl) || other.backgroundImageUrl == backgroundImageUrl));
}


@override
int get hashCode => Object.hash(runtimeType,id,taleId,pageNumber,text,isNew,backgroundImageUrl);

@override
String toString() {
  return 'TalePageModel(id: $id, taleId: $taleId, pageNumber: $pageNumber, text: $text, isNew: $isNew, backgroundImageUrl: $backgroundImageUrl)';
}


}

/// @nodoc
abstract mixin class $TalePageModelCopyWith<$Res>  {
  factory $TalePageModelCopyWith(TalePageModel value, $Res Function(TalePageModel) _then) = _$TalePageModelCopyWithImpl;
@useResult
$Res call({
 String id, String taleId, int pageNumber, String text, bool isNew, String backgroundImageUrl
});




}
/// @nodoc
class _$TalePageModelCopyWithImpl<$Res>
    implements $TalePageModelCopyWith<$Res> {
  _$TalePageModelCopyWithImpl(this._self, this._then);

  final TalePageModel _self;
  final $Res Function(TalePageModel) _then;

/// Create a copy of TalePageModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? taleId = null,Object? pageNumber = null,Object? text = null,Object? isNew = null,Object? backgroundImageUrl = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,taleId: null == taleId ? _self.taleId : taleId // ignore: cast_nullable_to_non_nullable
as String,pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,isNew: null == isNew ? _self.isNew : isNew // ignore: cast_nullable_to_non_nullable
as bool,backgroundImageUrl: null == backgroundImageUrl ? _self.backgroundImageUrl : backgroundImageUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc


class _TalePageModel extends TalePageModel {
  const _TalePageModel({required this.id, required this.taleId, this.pageNumber = -1, this.text = '', this.isNew = false, this.backgroundImageUrl = ''}): super._();
  

@override final  String id;
@override final  String taleId;
///for now not using this property
@override@JsonKey() final  int pageNumber;
@override@JsonKey() final  String text;
@override@JsonKey() final  bool isNew;
@override@JsonKey() final  String backgroundImageUrl;

/// Create a copy of TalePageModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TalePageModelCopyWith<_TalePageModel> get copyWith => __$TalePageModelCopyWithImpl<_TalePageModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TalePageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.taleId, taleId) || other.taleId == taleId)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.text, text) || other.text == text)&&(identical(other.isNew, isNew) || other.isNew == isNew)&&(identical(other.backgroundImageUrl, backgroundImageUrl) || other.backgroundImageUrl == backgroundImageUrl));
}


@override
int get hashCode => Object.hash(runtimeType,id,taleId,pageNumber,text,isNew,backgroundImageUrl);

@override
String toString() {
  return 'TalePageModel(id: $id, taleId: $taleId, pageNumber: $pageNumber, text: $text, isNew: $isNew, backgroundImageUrl: $backgroundImageUrl)';
}


}

/// @nodoc
abstract mixin class _$TalePageModelCopyWith<$Res> implements $TalePageModelCopyWith<$Res> {
  factory _$TalePageModelCopyWith(_TalePageModel value, $Res Function(_TalePageModel) _then) = __$TalePageModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String taleId, int pageNumber, String text, bool isNew, String backgroundImageUrl
});




}
/// @nodoc
class __$TalePageModelCopyWithImpl<$Res>
    implements _$TalePageModelCopyWith<$Res> {
  __$TalePageModelCopyWithImpl(this._self, this._then);

  final _TalePageModel _self;
  final $Res Function(_TalePageModel) _then;

/// Create a copy of TalePageModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? taleId = null,Object? pageNumber = null,Object? text = null,Object? isNew = null,Object? backgroundImageUrl = null,}) {
  return _then(_TalePageModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,taleId: null == taleId ? _self.taleId : taleId // ignore: cast_nullable_to_non_nullable
as String,pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,isNew: null == isNew ? _self.isNew : isNew // ignore: cast_nullable_to_non_nullable
as bool,backgroundImageUrl: null == backgroundImageUrl ? _self.backgroundImageUrl : backgroundImageUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
