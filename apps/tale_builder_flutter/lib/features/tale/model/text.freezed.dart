// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'text.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TalePageTextModel {

 String get id; String get text; String get pageId; double get width; double get height; double get dx; double get dy; bool get isNew; TextStyle get style; TextDecorationModel get decoration;
/// Create a copy of TalePageTextModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TalePageTextModelCopyWith<TalePageTextModel> get copyWith => _$TalePageTextModelCopyWithImpl<TalePageTextModel>(this as TalePageTextModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TalePageTextModel&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.pageId, pageId) || other.pageId == pageId)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.dx, dx) || other.dx == dx)&&(identical(other.dy, dy) || other.dy == dy)&&(identical(other.isNew, isNew) || other.isNew == isNew)&&(identical(other.style, style) || other.style == style)&&(identical(other.decoration, decoration) || other.decoration == decoration));
}


@override
int get hashCode => Object.hash(runtimeType,id,text,pageId,width,height,dx,dy,isNew,style,decoration);

@override
String toString() {
  return 'TalePageTextModel(id: $id, text: $text, pageId: $pageId, width: $width, height: $height, dx: $dx, dy: $dy, isNew: $isNew, style: $style, decoration: $decoration)';
}


}

/// @nodoc
abstract mixin class $TalePageTextModelCopyWith<$Res>  {
  factory $TalePageTextModelCopyWith(TalePageTextModel value, $Res Function(TalePageTextModel) _then) = _$TalePageTextModelCopyWithImpl;
@useResult
$Res call({
 String id, String text, String pageId, double width, double height, double dx, double dy, bool isNew, TextStyle style, TextDecorationModel decoration
});


$TextDecorationModelCopyWith<$Res> get decoration;

}
/// @nodoc
class _$TalePageTextModelCopyWithImpl<$Res>
    implements $TalePageTextModelCopyWith<$Res> {
  _$TalePageTextModelCopyWithImpl(this._self, this._then);

  final TalePageTextModel _self;
  final $Res Function(TalePageTextModel) _then;

/// Create a copy of TalePageTextModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? text = null,Object? pageId = null,Object? width = null,Object? height = null,Object? dx = null,Object? dy = null,Object? isNew = null,Object? style = null,Object? decoration = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,pageId: null == pageId ? _self.pageId : pageId // ignore: cast_nullable_to_non_nullable
as String,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,dx: null == dx ? _self.dx : dx // ignore: cast_nullable_to_non_nullable
as double,dy: null == dy ? _self.dy : dy // ignore: cast_nullable_to_non_nullable
as double,isNew: null == isNew ? _self.isNew : isNew // ignore: cast_nullable_to_non_nullable
as bool,style: null == style ? _self.style : style // ignore: cast_nullable_to_non_nullable
as TextStyle,decoration: null == decoration ? _self.decoration : decoration // ignore: cast_nullable_to_non_nullable
as TextDecorationModel,
  ));
}
/// Create a copy of TalePageTextModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TextDecorationModelCopyWith<$Res> get decoration {
  
  return $TextDecorationModelCopyWith<$Res>(_self.decoration, (value) {
    return _then(_self.copyWith(decoration: value));
  });
}
}


/// @nodoc


class _TalePageTextModel extends TalePageTextModel {
  const _TalePageTextModel({required this.id, required this.text, required this.pageId, required this.width, required this.height, required this.dx, required this.dy, this.isNew = false, this.style = TalePageTextModel._defaultTextStyle, this.decoration = TextDecorationModel._default}): super._();
  

@override final  String id;
@override final  String text;
@override final  String pageId;
@override final  double width;
@override final  double height;
@override final  double dx;
@override final  double dy;
@override@JsonKey() final  bool isNew;
@override@JsonKey() final  TextStyle style;
@override@JsonKey() final  TextDecorationModel decoration;

/// Create a copy of TalePageTextModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TalePageTextModelCopyWith<_TalePageTextModel> get copyWith => __$TalePageTextModelCopyWithImpl<_TalePageTextModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TalePageTextModel&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.pageId, pageId) || other.pageId == pageId)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.dx, dx) || other.dx == dx)&&(identical(other.dy, dy) || other.dy == dy)&&(identical(other.isNew, isNew) || other.isNew == isNew)&&(identical(other.style, style) || other.style == style)&&(identical(other.decoration, decoration) || other.decoration == decoration));
}


@override
int get hashCode => Object.hash(runtimeType,id,text,pageId,width,height,dx,dy,isNew,style,decoration);

@override
String toString() {
  return 'TalePageTextModel(id: $id, text: $text, pageId: $pageId, width: $width, height: $height, dx: $dx, dy: $dy, isNew: $isNew, style: $style, decoration: $decoration)';
}


}

/// @nodoc
abstract mixin class _$TalePageTextModelCopyWith<$Res> implements $TalePageTextModelCopyWith<$Res> {
  factory _$TalePageTextModelCopyWith(_TalePageTextModel value, $Res Function(_TalePageTextModel) _then) = __$TalePageTextModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String text, String pageId, double width, double height, double dx, double dy, bool isNew, TextStyle style, TextDecorationModel decoration
});


@override $TextDecorationModelCopyWith<$Res> get decoration;

}
/// @nodoc
class __$TalePageTextModelCopyWithImpl<$Res>
    implements _$TalePageTextModelCopyWith<$Res> {
  __$TalePageTextModelCopyWithImpl(this._self, this._then);

  final _TalePageTextModel _self;
  final $Res Function(_TalePageTextModel) _then;

/// Create a copy of TalePageTextModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? text = null,Object? pageId = null,Object? width = null,Object? height = null,Object? dx = null,Object? dy = null,Object? isNew = null,Object? style = null,Object? decoration = null,}) {
  return _then(_TalePageTextModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,pageId: null == pageId ? _self.pageId : pageId // ignore: cast_nullable_to_non_nullable
as String,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,dx: null == dx ? _self.dx : dx // ignore: cast_nullable_to_non_nullable
as double,dy: null == dy ? _self.dy : dy // ignore: cast_nullable_to_non_nullable
as double,isNew: null == isNew ? _self.isNew : isNew // ignore: cast_nullable_to_non_nullable
as bool,style: null == style ? _self.style : style // ignore: cast_nullable_to_non_nullable
as TextStyle,decoration: null == decoration ? _self.decoration : decoration // ignore: cast_nullable_to_non_nullable
as TextDecorationModel,
  ));
}

/// Create a copy of TalePageTextModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TextDecorationModelCopyWith<$Res> get decoration {
  
  return $TextDecorationModelCopyWith<$Res>(_self.decoration, (value) {
    return _then(_self.copyWith(decoration: value));
  });
}
}

/// @nodoc
mixin _$TextDecorationModel {

 Color? get backgroundColor; BorderRadius get borderRadius; EdgeInsets get padding; TextAlign get textAlign;
/// Create a copy of TextDecorationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TextDecorationModelCopyWith<TextDecorationModel> get copyWith => _$TextDecorationModelCopyWithImpl<TextDecorationModel>(this as TextDecorationModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TextDecorationModel&&(identical(other.backgroundColor, backgroundColor) || other.backgroundColor == backgroundColor)&&(identical(other.borderRadius, borderRadius) || other.borderRadius == borderRadius)&&(identical(other.padding, padding) || other.padding == padding)&&(identical(other.textAlign, textAlign) || other.textAlign == textAlign));
}


@override
int get hashCode => Object.hash(runtimeType,backgroundColor,borderRadius,padding,textAlign);

@override
String toString() {
  return 'TextDecorationModel(backgroundColor: $backgroundColor, borderRadius: $borderRadius, padding: $padding, textAlign: $textAlign)';
}


}

/// @nodoc
abstract mixin class $TextDecorationModelCopyWith<$Res>  {
  factory $TextDecorationModelCopyWith(TextDecorationModel value, $Res Function(TextDecorationModel) _then) = _$TextDecorationModelCopyWithImpl;
@useResult
$Res call({
 Color? backgroundColor, BorderRadius borderRadius, EdgeInsets padding, TextAlign textAlign
});




}
/// @nodoc
class _$TextDecorationModelCopyWithImpl<$Res>
    implements $TextDecorationModelCopyWith<$Res> {
  _$TextDecorationModelCopyWithImpl(this._self, this._then);

  final TextDecorationModel _self;
  final $Res Function(TextDecorationModel) _then;

/// Create a copy of TextDecorationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? backgroundColor = freezed,Object? borderRadius = null,Object? padding = null,Object? textAlign = null,}) {
  return _then(_self.copyWith(
backgroundColor: freezed == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as Color?,borderRadius: null == borderRadius ? _self.borderRadius : borderRadius // ignore: cast_nullable_to_non_nullable
as BorderRadius,padding: null == padding ? _self.padding : padding // ignore: cast_nullable_to_non_nullable
as EdgeInsets,textAlign: null == textAlign ? _self.textAlign : textAlign // ignore: cast_nullable_to_non_nullable
as TextAlign,
  ));
}

}


/// @nodoc


class _TextDecorationModel extends TextDecorationModel {
  const _TextDecorationModel({this.backgroundColor, this.borderRadius = BorderRadius.zero, this.padding = EdgeInsets.zero, this.textAlign = TextAlign.center}): super._();
  

@override final  Color? backgroundColor;
@override@JsonKey() final  BorderRadius borderRadius;
@override@JsonKey() final  EdgeInsets padding;
@override@JsonKey() final  TextAlign textAlign;

/// Create a copy of TextDecorationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TextDecorationModelCopyWith<_TextDecorationModel> get copyWith => __$TextDecorationModelCopyWithImpl<_TextDecorationModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TextDecorationModel&&(identical(other.backgroundColor, backgroundColor) || other.backgroundColor == backgroundColor)&&(identical(other.borderRadius, borderRadius) || other.borderRadius == borderRadius)&&(identical(other.padding, padding) || other.padding == padding)&&(identical(other.textAlign, textAlign) || other.textAlign == textAlign));
}


@override
int get hashCode => Object.hash(runtimeType,backgroundColor,borderRadius,padding,textAlign);

@override
String toString() {
  return 'TextDecorationModel(backgroundColor: $backgroundColor, borderRadius: $borderRadius, padding: $padding, textAlign: $textAlign)';
}


}

/// @nodoc
abstract mixin class _$TextDecorationModelCopyWith<$Res> implements $TextDecorationModelCopyWith<$Res> {
  factory _$TextDecorationModelCopyWith(_TextDecorationModel value, $Res Function(_TextDecorationModel) _then) = __$TextDecorationModelCopyWithImpl;
@override @useResult
$Res call({
 Color? backgroundColor, BorderRadius borderRadius, EdgeInsets padding, TextAlign textAlign
});




}
/// @nodoc
class __$TextDecorationModelCopyWithImpl<$Res>
    implements _$TextDecorationModelCopyWith<$Res> {
  __$TextDecorationModelCopyWithImpl(this._self, this._then);

  final _TextDecorationModel _self;
  final $Res Function(_TextDecorationModel) _then;

/// Create a copy of TextDecorationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? backgroundColor = freezed,Object? borderRadius = null,Object? padding = null,Object? textAlign = null,}) {
  return _then(_TextDecorationModel(
backgroundColor: freezed == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as Color?,borderRadius: null == borderRadius ? _self.borderRadius : borderRadius // ignore: cast_nullable_to_non_nullable
as BorderRadius,padding: null == padding ? _self.padding : padding // ignore: cast_nullable_to_non_nullable
as EdgeInsets,textAlign: null == textAlign ? _self.textAlign : textAlign // ignore: cast_nullable_to_non_nullable
as TextAlign,
  ));
}


}

// dart format on
