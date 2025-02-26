import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_data_mobile/src/repositories/tale/models.dart';

import 'tale/state.dart';

part 'state.freezed.dart';

@freezed
class TaleListState with _$TaleListState {
  const TaleListState._();
  const factory TaleListState({
    required StateResult taleListStatus,
    required List<Tale> taleList,
    required TaleState taleState,
  }) = _TaleListState;

  factory TaleListState.initial() {
    return TaleListState(
      taleListStatus: StateResult.loading(),
      taleList: [],
      taleState: TaleState.initial(),
    );
  }
}
