import 'package:fairy_tale_app/manager/redux/features/tales/tale/state.dart';
import 'package:fairy_tale_app/manager/repositories/tale/models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myspace_data/myspace_data.dart';

part 'state.freezed.dart';

@freezed
class TaleListState with _$TaleListState {
  const TaleListState._();
  const factory TaleListState({
    required StateResult taleListResult,
    required List<Tale> taleList,
    required TaleState taleState,
  }) = _TaleListState;

  factory TaleListState.initial() {
    return TaleListState(
      taleListResult: const StateResult.loading(),
      taleList: [],
      taleState: TaleState.initial(),
    );
  }
}
