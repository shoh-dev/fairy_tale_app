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
 int get pageNumber; String get text; String get backgroundImageUrl; List<TalePageTextModel> get texts;
/// Create a copy of TalePageModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TalePageModelCopyWith<TalePageModel> get copyWith => _$TalePageModelCopyWithImpl<TalePageModel>(this as TalePageModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TalePageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.taleId, taleId) || other.taleId == taleId)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.text, text) || other.text == text)&&(identical(other.backgroundImageUrl, backgroundImageUrl) || other.backgroundImageUrl == backgroundImageUrl)&&const DeepCollectionEquality().equals(other.texts, texts));
}


@override
int get hashCode => Object.hash(runtimeType,id,taleId,pageNumber,text,backgroundImageUrl,const DeepCollectionEquality().hash(texts));

@override
String toString() {
  return 'TalePageModel(id: $id, taleId: $taleId, pageNumber: $pageNumber, text: $text, backgroundImageUrl: $backgroundImageUrl, texts: $texts)';
}


}

/// @nodoc
abstract mixin class $TalePageModelCopyWith<$Res>  {
  factory $TalePageModelCopyWith(TalePageModel value, $Res Function(TalePageModel) _then) = _$TalePageModelCopyWithImpl;
@useResult
$Res call({
 String id, String taleId, int pageNumber, String text, String backgroundImageUrl, List<TalePageTextModel> texts
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? taleId = null,Object? pageNumber = null,Object? text = null,Object? backgroundImageUrl = null,Object? texts = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,taleId: null == taleId ? _self.taleId : taleId // ignore: cast_nullable_to_non_nullable
as String,pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,backgroundImageUrl: null == backgroundImageUrl ? _self.backgroundImageUrl : backgroundImageUrl // ignore: cast_nullable_to_non_nullable
as String,texts: null == texts ? _self.texts : texts // ignore: cast_nullable_to_non_nullable
as List<TalePageTextModel>,
  ));
}

}


/// @nodoc


class _TalePageModel extends TalePageModel {
  const _TalePageModel({required this.id, required this.taleId, this.pageNumber = -1, this.text = '', this.backgroundImageUrl = '', final  List<TalePageTextModel> texts = const []}): _texts = texts,super._();
  

@override final  String id;
@override final  String taleId;
///for now not using this property
@override@JsonKey() final  int pageNumber;
@override@JsonKey() final  String text;
@override@JsonKey() final  String backgroundImageUrl;
 final  List<TalePageTextModel> _texts;
@override@JsonKey() List<TalePageTextModel> get texts {
  if (_texts is EqualUnmodifiableListView) return _texts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_texts);
}


/// Create a copy of TalePageModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TalePageModelCopyWith<_TalePageModel> get copyWith => __$TalePageModelCopyWithImpl<_TalePageModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TalePageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.taleId, taleId) || other.taleId == taleId)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.text, text) || other.text == text)&&(identical(other.backgroundImageUrl, backgroundImageUrl) || other.backgroundImageUrl == backgroundImageUrl)&&const DeepCollectionEquality().equals(other._texts, _texts));
}


@override
int get hashCode => Object.hash(runtimeType,id,taleId,pageNumber,text,backgroundImageUrl,const DeepCollectionEquality().hash(_texts));

@override
String toString() {
  return 'TalePageModel(id: $id, taleId: $taleId, pageNumber: $pageNumber, text: $text, backgroundImageUrl: $backgroundImageUrl, texts: $texts)';
}


}

/// @nodoc
abstract mixin class _$TalePageModelCopyWith<$Res> implements $TalePageModelCopyWith<$Res> {
  factory _$TalePageModelCopyWith(_TalePageModel value, $Res Function(_TalePageModel) _then) = __$TalePageModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String taleId, int pageNumber, String text, String backgroundImageUrl, List<TalePageTextModel> texts
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? taleId = null,Object? pageNumber = null,Object? text = null,Object? backgroundImageUrl = null,Object? texts = null,}) {
  return _then(_TalePageModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,taleId: null == taleId ? _self.taleId : taleId // ignore: cast_nullable_to_non_nullable
as String,pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,backgroundImageUrl: null == backgroundImageUrl ? _self.backgroundImageUrl : backgroundImageUrl // ignore: cast_nullable_to_non_nullable
as String,texts: null == texts ? _self._texts : texts // ignore: cast_nullable_to_non_nullable
as List<TalePageTextModel>,
  ));
}


}

// dart format on
