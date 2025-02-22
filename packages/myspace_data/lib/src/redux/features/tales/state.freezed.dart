// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TalesState {
  StateResult get status => throw _privateConstructorUsedError;
  List<Tale> get tales => throw _privateConstructorUsedError;

  /// Create a copy of TalesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TalesStateCopyWith<TalesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TalesStateCopyWith<$Res> {
  factory $TalesStateCopyWith(
          TalesState value, $Res Function(TalesState) then) =
      _$TalesStateCopyWithImpl<$Res, TalesState>;
  @useResult
  $Res call({StateResult status, List<Tale> tales});

  $StateResultCopyWith<$Res> get status;
}

/// @nodoc
class _$TalesStateCopyWithImpl<$Res, $Val extends TalesState>
    implements $TalesStateCopyWith<$Res> {
  _$TalesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TalesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? tales = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as StateResult,
      tales: null == tales
          ? _value.tales
          : tales // ignore: cast_nullable_to_non_nullable
              as List<Tale>,
    ) as $Val);
  }

  /// Create a copy of TalesState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StateResultCopyWith<$Res> get status {
    return $StateResultCopyWith<$Res>(_value.status, (value) {
      return _then(_value.copyWith(status: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TalesStateImplCopyWith<$Res>
    implements $TalesStateCopyWith<$Res> {
  factory _$$TalesStateImplCopyWith(
          _$TalesStateImpl value, $Res Function(_$TalesStateImpl) then) =
      __$$TalesStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({StateResult status, List<Tale> tales});

  @override
  $StateResultCopyWith<$Res> get status;
}

/// @nodoc
class __$$TalesStateImplCopyWithImpl<$Res>
    extends _$TalesStateCopyWithImpl<$Res, _$TalesStateImpl>
    implements _$$TalesStateImplCopyWith<$Res> {
  __$$TalesStateImplCopyWithImpl(
      _$TalesStateImpl _value, $Res Function(_$TalesStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TalesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? tales = null,
  }) {
    return _then(_$TalesStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as StateResult,
      tales: null == tales
          ? _value._tales
          : tales // ignore: cast_nullable_to_non_nullable
              as List<Tale>,
    ));
  }
}

/// @nodoc

class _$TalesStateImpl extends _TalesState {
  const _$TalesStateImpl(
      {required this.status, required final List<Tale> tales})
      : _tales = tales,
        super._();

  @override
  final StateResult status;
  final List<Tale> _tales;
  @override
  List<Tale> get tales {
    if (_tales is EqualUnmodifiableListView) return _tales;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tales);
  }

  @override
  String toString() {
    return 'TalesState(status: $status, tales: $tales)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TalesStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._tales, _tales));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, status, const DeepCollectionEquality().hash(_tales));

  /// Create a copy of TalesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TalesStateImplCopyWith<_$TalesStateImpl> get copyWith =>
      __$$TalesStateImplCopyWithImpl<_$TalesStateImpl>(this, _$identity);
}

abstract class _TalesState extends TalesState {
  const factory _TalesState(
      {required final StateResult status,
      required final List<Tale> tales}) = _$TalesStateImpl;
  const _TalesState._() : super._();

  @override
  StateResult get status;
  @override
  List<Tale> get tales;

  /// Create a copy of TalesState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TalesStateImplCopyWith<_$TalesStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
