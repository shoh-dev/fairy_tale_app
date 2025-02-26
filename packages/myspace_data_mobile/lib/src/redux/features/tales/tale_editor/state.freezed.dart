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
mixin _$TaleEditorState {
  TalePage get selectedPage => throw _privateConstructorUsedError;
  List<TaleInteraction> get selectedInteractions =>
      throw _privateConstructorUsedError;

  /// Create a copy of TaleEditorState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaleEditorStateCopyWith<TaleEditorState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaleEditorStateCopyWith<$Res> {
  factory $TaleEditorStateCopyWith(
          TaleEditorState value, $Res Function(TaleEditorState) then) =
      _$TaleEditorStateCopyWithImpl<$Res, TaleEditorState>;
  @useResult
  $Res call(
      {TalePage selectedPage, List<TaleInteraction> selectedInteractions});
}

/// @nodoc
class _$TaleEditorStateCopyWithImpl<$Res, $Val extends TaleEditorState>
    implements $TaleEditorStateCopyWith<$Res> {
  _$TaleEditorStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaleEditorState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedPage = freezed,
    Object? selectedInteractions = null,
  }) {
    return _then(_value.copyWith(
      selectedPage: freezed == selectedPage
          ? _value.selectedPage
          : selectedPage // ignore: cast_nullable_to_non_nullable
              as TalePage,
      selectedInteractions: null == selectedInteractions
          ? _value.selectedInteractions
          : selectedInteractions // ignore: cast_nullable_to_non_nullable
              as List<TaleInteraction>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaleEditorStateImplCopyWith<$Res>
    implements $TaleEditorStateCopyWith<$Res> {
  factory _$$TaleEditorStateImplCopyWith(_$TaleEditorStateImpl value,
          $Res Function(_$TaleEditorStateImpl) then) =
      __$$TaleEditorStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TalePage selectedPage, List<TaleInteraction> selectedInteractions});
}

/// @nodoc
class __$$TaleEditorStateImplCopyWithImpl<$Res>
    extends _$TaleEditorStateCopyWithImpl<$Res, _$TaleEditorStateImpl>
    implements _$$TaleEditorStateImplCopyWith<$Res> {
  __$$TaleEditorStateImplCopyWithImpl(
      _$TaleEditorStateImpl _value, $Res Function(_$TaleEditorStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaleEditorState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedPage = freezed,
    Object? selectedInteractions = null,
  }) {
    return _then(_$TaleEditorStateImpl(
      selectedPage: freezed == selectedPage
          ? _value.selectedPage
          : selectedPage // ignore: cast_nullable_to_non_nullable
              as TalePage,
      selectedInteractions: null == selectedInteractions
          ? _value._selectedInteractions
          : selectedInteractions // ignore: cast_nullable_to_non_nullable
              as List<TaleInteraction>,
    ));
  }
}

/// @nodoc

class _$TaleEditorStateImpl extends _TaleEditorState {
  const _$TaleEditorStateImpl(
      {required this.selectedPage,
      required final List<TaleInteraction> selectedInteractions})
      : _selectedInteractions = selectedInteractions,
        super._();

  @override
  final TalePage selectedPage;
  final List<TaleInteraction> _selectedInteractions;
  @override
  List<TaleInteraction> get selectedInteractions {
    if (_selectedInteractions is EqualUnmodifiableListView)
      return _selectedInteractions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedInteractions);
  }

  @override
  String toString() {
    return 'TaleEditorState(selectedPage: $selectedPage, selectedInteractions: $selectedInteractions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaleEditorStateImpl &&
            const DeepCollectionEquality()
                .equals(other.selectedPage, selectedPage) &&
            const DeepCollectionEquality()
                .equals(other._selectedInteractions, _selectedInteractions));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(selectedPage),
      const DeepCollectionEquality().hash(_selectedInteractions));

  /// Create a copy of TaleEditorState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaleEditorStateImplCopyWith<_$TaleEditorStateImpl> get copyWith =>
      __$$TaleEditorStateImplCopyWithImpl<_$TaleEditorStateImpl>(
          this, _$identity);
}

abstract class _TaleEditorState extends TaleEditorState {
  const factory _TaleEditorState(
          {required final TalePage selectedPage,
          required final List<TaleInteraction> selectedInteractions}) =
      _$TaleEditorStateImpl;
  const _TaleEditorState._() : super._();

  @override
  TalePage get selectedPage;
  @override
  List<TaleInteraction> get selectedInteractions;

  /// Create a copy of TaleEditorState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaleEditorStateImplCopyWith<_$TaleEditorStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
