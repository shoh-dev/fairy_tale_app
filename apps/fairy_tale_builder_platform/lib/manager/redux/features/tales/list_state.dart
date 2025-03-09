import 'package:fairy_tale_builder_platform/manager/redux/features/features.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:shared/shared.dart';

part 'list_state.freezed.dart';

@freezed
class TaleListState with _$TaleListState {
  const TaleListState._();
  const factory TaleListState({
    required StateResult listResult,
    required List<Tale> list,
    required TaleState taleState,
  }) = _TaleListState;

  factory TaleListState.initial() {
    return TaleListState(
      listResult: const StateResult.loading(),
      list: [],
      taleState: TaleState.initial(),
    );
  }
}
