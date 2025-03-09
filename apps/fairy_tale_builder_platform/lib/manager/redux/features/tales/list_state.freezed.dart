// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TaleListState {
  StateResult get listResult => throw _privateConstructorUsedError;
  List<Tale> get list => throw _privateConstructorUsedError;
  TaleState get taleState => throw _privateConstructorUsedError;

  /// Create a copy of TaleListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaleListStateCopyWith<TaleListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaleListStateCopyWith<$Res> {
  factory $TaleListStateCopyWith(
          TaleListState value, $Res Function(TaleListState) then) =
      _$TaleListStateCopyWithImpl<$Res, TaleListState>;
  @useResult
  $Res call({StateResult listResult, List<Tale> list, TaleState taleState});

  $StateResultCopyWith<$Res> get listResult;
  $TaleStateCopyWith<$Res> get taleState;
}

/// @nodoc
class _$TaleListStateCopyWithImpl<$Res, $Val extends TaleListState>
    implements $TaleListStateCopyWith<$Res> {
  _$TaleListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaleListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listResult = null,
    Object? list = null,
    Object? taleState = null,
  }) {
    return _then(_value.copyWith(
      listResult: null == listResult
          ? _value.listResult
          : listResult // ignore: cast_nullable_to_non_nullable
              as StateResult,
      list: null == list
          ? _value.list
          : list // ignore: cast_nullable_to_non_nullable
              as List<Tale>,
      taleState: null == taleState
          ? _value.taleState
          : taleState // ignore: cast_nullable_to_non_nullable
              as TaleState,
    ) as $Val);
  }

  /// Create a copy of TaleListState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StateResultCopyWith<$Res> get listResult {
    return $StateResultCopyWith<$Res>(_value.listResult, (value) {
      return _then(_value.copyWith(listResult: value) as $Val);
    });
  }

  /// Create a copy of TaleListState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TaleStateCopyWith<$Res> get taleState {
    return $TaleStateCopyWith<$Res>(_value.taleState, (value) {
      return _then(_value.copyWith(taleState: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TaleListStateImplCopyWith<$Res>
    implements $TaleListStateCopyWith<$Res> {
  factory _$$TaleListStateImplCopyWith(
          _$TaleListStateImpl value, $Res Function(_$TaleListStateImpl) then) =
      __$$TaleListStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({StateResult listResult, List<Tale> list, TaleState taleState});

  @override
  $StateResultCopyWith<$Res> get listResult;
  @override
  $TaleStateCopyWith<$Res> get taleState;
}

/// @nodoc
class __$$TaleListStateImplCopyWithImpl<$Res>
    extends _$TaleListStateCopyWithImpl<$Res, _$TaleListStateImpl>
    implements _$$TaleListStateImplCopyWith<$Res> {
  __$$TaleListStateImplCopyWithImpl(
      _$TaleListStateImpl _value, $Res Function(_$TaleListStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaleListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listResult = null,
    Object? list = null,
    Object? taleState = null,
  }) {
    return _then(_$TaleListStateImpl(
      listResult: null == listResult
          ? _value.listResult
          : listResult // ignore: cast_nullable_to_non_nullable
              as StateResult,
      list: null == list
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<Tale>,
      taleState: null == taleState
          ? _value.taleState
          : taleState // ignore: cast_nullable_to_non_nullable
              as TaleState,
    ));
  }
}

/// @nodoc

class _$TaleListStateImpl extends _TaleListState {
  const _$TaleListStateImpl(
      {required this.listResult,
      required final List<Tale> list,
      required this.taleState})
      : _list = list,
        super._();

  @override
  final StateResult listResult;
  final List<Tale> _list;
  @override
  List<Tale> get list {
    if (_list is EqualUnmodifiableListView) return _list;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  @override
  final TaleState taleState;

  @override
  String toString() {
    return 'TaleListState(listResult: $listResult, list: $list, taleState: $taleState)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaleListStateImpl &&
            (identical(other.listResult, listResult) ||
                other.listResult == listResult) &&
            const DeepCollectionEquality().equals(other._list, _list) &&
            (identical(other.taleState, taleState) ||
                other.taleState == taleState));
  }

  @override
  int get hashCode => Object.hash(runtimeType, listResult,
      const DeepCollectionEquality().hash(_list), taleState);

  /// Create a copy of TaleListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaleListStateImplCopyWith<_$TaleListStateImpl> get copyWith =>
      __$$TaleListStateImplCopyWithImpl<_$TaleListStateImpl>(this, _$identity);
}

abstract class _TaleListState extends TaleListState {
  const factory _TaleListState(
      {required final StateResult listResult,
      required final List<Tale> list,
      required final TaleState taleState}) = _$TaleListStateImpl;
  const _TaleListState._() : super._();

  @override
  StateResult get listResult;
  @override
  List<Tale> get list;
  @override
  TaleState get taleState;

  /// Create a copy of TaleListState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaleListStateImplCopyWith<_$TaleListStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
