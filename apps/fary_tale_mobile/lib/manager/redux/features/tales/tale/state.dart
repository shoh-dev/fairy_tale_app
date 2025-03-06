import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:shared/shared.dart';

part 'state.freezed.dart';

@freezed
class TaleState with _$TaleState {
  const factory TaleState({
    required StateResult selectedTaleResult,
    required Tale selectedTale,
  }) = _TaleState;

  factory TaleState.initial() {
    return TaleState(
      selectedTale: Tale.empty(''),
      selectedTaleResult: const StateResult.loading(),
    );
  }
}
