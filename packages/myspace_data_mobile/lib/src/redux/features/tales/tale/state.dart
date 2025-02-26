import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_data_mobile/src/repositories/tale/models.dart';

part 'state.freezed.dart';

@freezed
class TaleState with _$TaleState {
  const factory TaleState({
    required StateResult selectedTaleResult,
    required Tale selectedTale,
  }) = _TaleState;

  factory TaleState.initial() {
    return const TaleState(
      selectedTale: Tale.empty,
      selectedTaleResult: StateResult.loading(),
    );
  }
}
