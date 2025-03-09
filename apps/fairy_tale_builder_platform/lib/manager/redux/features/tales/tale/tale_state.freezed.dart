// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tale_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TaleState {
  StateResult get taleResult => throw _privateConstructorUsedError;
  Tale get tale => throw _privateConstructorUsedError;
  TaleEditorState get editorState => throw _privateConstructorUsedError;

  /// Create a copy of TaleState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaleStateCopyWith<TaleState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaleStateCopyWith<$Res> {
  factory $TaleStateCopyWith(TaleState value, $Res Function(TaleState) then) =
      _$TaleStateCopyWithImpl<$Res, TaleState>;
  @useResult
  $Res call({StateResult taleResult, Tale tale, TaleEditorState editorState});

  $StateResultCopyWith<$Res> get taleResult;
  $TaleCopyWith<$Res> get tale;
  $TaleEditorStateCopyWith<$Res> get editorState;
}

/// @nodoc
class _$TaleStateCopyWithImpl<$Res, $Val extends TaleState>
    implements $TaleStateCopyWith<$Res> {
  _$TaleStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaleState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taleResult = null,
    Object? tale = null,
    Object? editorState = null,
  }) {
    return _then(_value.copyWith(
      taleResult: null == taleResult
          ? _value.taleResult
          : taleResult // ignore: cast_nullable_to_non_nullable
              as StateResult,
      tale: null == tale
          ? _value.tale
          : tale // ignore: cast_nullable_to_non_nullable
              as Tale,
      editorState: null == editorState
          ? _value.editorState
          : editorState // ignore: cast_nullable_to_non_nullable
              as TaleEditorState,
    ) as $Val);
  }

  /// Create a copy of TaleState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StateResultCopyWith<$Res> get taleResult {
    return $StateResultCopyWith<$Res>(_value.taleResult, (value) {
      return _then(_value.copyWith(taleResult: value) as $Val);
    });
  }

  /// Create a copy of TaleState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TaleCopyWith<$Res> get tale {
    return $TaleCopyWith<$Res>(_value.tale, (value) {
      return _then(_value.copyWith(tale: value) as $Val);
    });
  }

  /// Create a copy of TaleState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TaleEditorStateCopyWith<$Res> get editorState {
    return $TaleEditorStateCopyWith<$Res>(_value.editorState, (value) {
      return _then(_value.copyWith(editorState: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TaleStateImplCopyWith<$Res>
    implements $TaleStateCopyWith<$Res> {
  factory _$$TaleStateImplCopyWith(
          _$TaleStateImpl value, $Res Function(_$TaleStateImpl) then) =
      __$$TaleStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({StateResult taleResult, Tale tale, TaleEditorState editorState});

  @override
  $StateResultCopyWith<$Res> get taleResult;
  @override
  $TaleCopyWith<$Res> get tale;
  @override
  $TaleEditorStateCopyWith<$Res> get editorState;
}

/// @nodoc
class __$$TaleStateImplCopyWithImpl<$Res>
    extends _$TaleStateCopyWithImpl<$Res, _$TaleStateImpl>
    implements _$$TaleStateImplCopyWith<$Res> {
  __$$TaleStateImplCopyWithImpl(
      _$TaleStateImpl _value, $Res Function(_$TaleStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaleState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taleResult = null,
    Object? tale = null,
    Object? editorState = null,
  }) {
    return _then(_$TaleStateImpl(
      taleResult: null == taleResult
          ? _value.taleResult
          : taleResult // ignore: cast_nullable_to_non_nullable
              as StateResult,
      tale: null == tale
          ? _value.tale
          : tale // ignore: cast_nullable_to_non_nullable
              as Tale,
      editorState: null == editorState
          ? _value.editorState
          : editorState // ignore: cast_nullable_to_non_nullable
              as TaleEditorState,
    ));
  }
}

/// @nodoc

class _$TaleStateImpl extends _TaleState {
  const _$TaleStateImpl(
      {required this.taleResult, required this.tale, required this.editorState})
      : super._();

  @override
  final StateResult taleResult;
  @override
  final Tale tale;
  @override
  final TaleEditorState editorState;

  @override
  String toString() {
    return 'TaleState(taleResult: $taleResult, tale: $tale, editorState: $editorState)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaleStateImpl &&
            (identical(other.taleResult, taleResult) ||
                other.taleResult == taleResult) &&
            (identical(other.tale, tale) || other.tale == tale) &&
            (identical(other.editorState, editorState) ||
                other.editorState == editorState));
  }

  @override
  int get hashCode => Object.hash(runtimeType, taleResult, tale, editorState);

  /// Create a copy of TaleState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaleStateImplCopyWith<_$TaleStateImpl> get copyWith =>
      __$$TaleStateImplCopyWithImpl<_$TaleStateImpl>(this, _$identity);
}

abstract class _TaleState extends TaleState {
  const factory _TaleState(
      {required final StateResult taleResult,
      required final Tale tale,
      required final TaleEditorState editorState}) = _$TaleStateImpl;
  const _TaleState._() : super._();

  @override
  StateResult get taleResult;
  @override
  Tale get tale;
  @override
  TaleEditorState get editorState;

  /// Create a copy of TaleState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaleStateImplCopyWith<_$TaleStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
