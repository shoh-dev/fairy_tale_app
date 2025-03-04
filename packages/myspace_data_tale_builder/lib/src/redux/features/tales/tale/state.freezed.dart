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
mixin _$TaleState {
  StateResult get status => throw _privateConstructorUsedError;
  Tale get selectedTale => throw _privateConstructorUsedError;

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
  $Res call({StateResult status, Tale selectedTale});

  $StateResultCopyWith<$Res> get status;
  $TaleCopyWith<$Res> get selectedTale;
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
    Object? status = null,
    Object? selectedTale = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as StateResult,
      selectedTale: null == selectedTale
          ? _value.selectedTale
          : selectedTale // ignore: cast_nullable_to_non_nullable
              as Tale,
    ) as $Val);
  }

  /// Create a copy of TaleState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StateResultCopyWith<$Res> get status {
    return $StateResultCopyWith<$Res>(_value.status, (value) {
      return _then(_value.copyWith(status: value) as $Val);
    });
  }

  /// Create a copy of TaleState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TaleCopyWith<$Res> get selectedTale {
    return $TaleCopyWith<$Res>(_value.selectedTale, (value) {
      return _then(_value.copyWith(selectedTale: value) as $Val);
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
  $Res call({StateResult status, Tale selectedTale});

  @override
  $StateResultCopyWith<$Res> get status;
  @override
  $TaleCopyWith<$Res> get selectedTale;
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
    Object? status = null,
    Object? selectedTale = null,
  }) {
    return _then(_$TaleStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as StateResult,
      selectedTale: null == selectedTale
          ? _value.selectedTale
          : selectedTale // ignore: cast_nullable_to_non_nullable
              as Tale,
    ));
  }
}

/// @nodoc

class _$TaleStateImpl implements _TaleState {
  const _$TaleStateImpl({required this.status, required this.selectedTale});

  @override
  final StateResult status;
  @override
  final Tale selectedTale;

  @override
  String toString() {
    return 'TaleState(status: $status, selectedTale: $selectedTale)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaleStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.selectedTale, selectedTale) ||
                other.selectedTale == selectedTale));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, selectedTale);

  /// Create a copy of TaleState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaleStateImplCopyWith<_$TaleStateImpl> get copyWith =>
      __$$TaleStateImplCopyWithImpl<_$TaleStateImpl>(this, _$identity);
}

abstract class _TaleState implements TaleState {
  const factory _TaleState(
      {required final StateResult status,
      required final Tale selectedTale}) = _$TaleStateImpl;

  @override
  StateResult get status;
  @override
  Tale get selectedTale;

  /// Create a copy of TaleState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaleStateImplCopyWith<_$TaleStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
