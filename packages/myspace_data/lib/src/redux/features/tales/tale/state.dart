import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myspace_data/myspace_data.dart';

part 'state.freezed.dart';

@freezed
class TaleState with _$TaleState {
  const factory TaleState({
    required StateResult status,
    required Tale selectedTale,
  }) = _TaleState;

  factory TaleState.initial() {
    return const TaleState(
      selectedTale: Tale.empty,
      status: StateResult.loading(),
    );
  }
}
