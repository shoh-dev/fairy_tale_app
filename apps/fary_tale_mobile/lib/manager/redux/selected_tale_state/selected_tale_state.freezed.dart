// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'selected_tale_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SelectedTaleState {
  StateResult get taleResult => throw _privateConstructorUsedError;
  Tale get tale => throw _privateConstructorUsedError;
  List<TalePage> get pages => throw _privateConstructorUsedError;
  List<TaleInteraction> get interactions => throw _privateConstructorUsedError;

  /// Create a copy of SelectedTaleState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SelectedTaleStateCopyWith<SelectedTaleState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectedTaleStateCopyWith<$Res> {
  factory $SelectedTaleStateCopyWith(
          SelectedTaleState value, $Res Function(SelectedTaleState) then) =
      _$SelectedTaleStateCopyWithImpl<$Res, SelectedTaleState>;
  @useResult
  $Res call(
      {StateResult taleResult,
      Tale tale,
      List<TalePage> pages,
      List<TaleInteraction> interactions});

  $StateResultCopyWith<$Res> get taleResult;
  $TaleCopyWith<$Res> get tale;
}

/// @nodoc
class _$SelectedTaleStateCopyWithImpl<$Res, $Val extends SelectedTaleState>
    implements $SelectedTaleStateCopyWith<$Res> {
  _$SelectedTaleStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SelectedTaleState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taleResult = null,
    Object? tale = null,
    Object? pages = null,
    Object? interactions = null,
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
      pages: null == pages
          ? _value.pages
          : pages // ignore: cast_nullable_to_non_nullable
              as List<TalePage>,
      interactions: null == interactions
          ? _value.interactions
          : interactions // ignore: cast_nullable_to_non_nullable
              as List<TaleInteraction>,
    ) as $Val);
  }

  /// Create a copy of SelectedTaleState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StateResultCopyWith<$Res> get taleResult {
    return $StateResultCopyWith<$Res>(_value.taleResult, (value) {
      return _then(_value.copyWith(taleResult: value) as $Val);
    });
  }

  /// Create a copy of SelectedTaleState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TaleCopyWith<$Res> get tale {
    return $TaleCopyWith<$Res>(_value.tale, (value) {
      return _then(_value.copyWith(tale: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SelectedTaleStateImplCopyWith<$Res>
    implements $SelectedTaleStateCopyWith<$Res> {
  factory _$$SelectedTaleStateImplCopyWith(_$SelectedTaleStateImpl value,
          $Res Function(_$SelectedTaleStateImpl) then) =
      __$$SelectedTaleStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StateResult taleResult,
      Tale tale,
      List<TalePage> pages,
      List<TaleInteraction> interactions});

  @override
  $StateResultCopyWith<$Res> get taleResult;
  @override
  $TaleCopyWith<$Res> get tale;
}

/// @nodoc
class __$$SelectedTaleStateImplCopyWithImpl<$Res>
    extends _$SelectedTaleStateCopyWithImpl<$Res, _$SelectedTaleStateImpl>
    implements _$$SelectedTaleStateImplCopyWith<$Res> {
  __$$SelectedTaleStateImplCopyWithImpl(_$SelectedTaleStateImpl _value,
      $Res Function(_$SelectedTaleStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SelectedTaleState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taleResult = null,
    Object? tale = null,
    Object? pages = null,
    Object? interactions = null,
  }) {
    return _then(_$SelectedTaleStateImpl(
      taleResult: null == taleResult
          ? _value.taleResult
          : taleResult // ignore: cast_nullable_to_non_nullable
              as StateResult,
      tale: null == tale
          ? _value.tale
          : tale // ignore: cast_nullable_to_non_nullable
              as Tale,
      pages: null == pages
          ? _value._pages
          : pages // ignore: cast_nullable_to_non_nullable
              as List<TalePage>,
      interactions: null == interactions
          ? _value._interactions
          : interactions // ignore: cast_nullable_to_non_nullable
              as List<TaleInteraction>,
    ));
  }
}

/// @nodoc

class _$SelectedTaleStateImpl extends _SelectedTaleState {
  const _$SelectedTaleStateImpl(
      {required this.taleResult,
      required this.tale,
      required final List<TalePage> pages,
      required final List<TaleInteraction> interactions})
      : _pages = pages,
        _interactions = interactions,
        super._();

  @override
  final StateResult taleResult;
  @override
  final Tale tale;
  final List<TalePage> _pages;
  @override
  List<TalePage> get pages {
    if (_pages is EqualUnmodifiableListView) return _pages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pages);
  }

  final List<TaleInteraction> _interactions;
  @override
  List<TaleInteraction> get interactions {
    if (_interactions is EqualUnmodifiableListView) return _interactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_interactions);
  }

  @override
  String toString() {
    return 'SelectedTaleState(taleResult: $taleResult, tale: $tale, pages: $pages, interactions: $interactions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectedTaleStateImpl &&
            (identical(other.taleResult, taleResult) ||
                other.taleResult == taleResult) &&
            (identical(other.tale, tale) || other.tale == tale) &&
            const DeepCollectionEquality().equals(other._pages, _pages) &&
            const DeepCollectionEquality()
                .equals(other._interactions, _interactions));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      taleResult,
      tale,
      const DeepCollectionEquality().hash(_pages),
      const DeepCollectionEquality().hash(_interactions));

  /// Create a copy of SelectedTaleState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectedTaleStateImplCopyWith<_$SelectedTaleStateImpl> get copyWith =>
      __$$SelectedTaleStateImplCopyWithImpl<_$SelectedTaleStateImpl>(
          this, _$identity);
}

abstract class _SelectedTaleState extends SelectedTaleState {
  const factory _SelectedTaleState(
          {required final StateResult taleResult,
          required final Tale tale,
          required final List<TalePage> pages,
          required final List<TaleInteraction> interactions}) =
      _$SelectedTaleStateImpl;
  const _SelectedTaleState._() : super._();

  @override
  StateResult get taleResult;
  @override
  Tale get tale;
  @override
  List<TalePage> get pages;
  @override
  List<TaleInteraction> get interactions;

  /// Create a copy of SelectedTaleState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectedTaleStateImplCopyWith<_$SelectedTaleStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
