import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:shared/shared.dart';
import 'package:shared/src/redux/redux/state.dart';

part 'tale_list_state.freezed.dart';

@freezed
class TaleListState with _$TaleListState {
  const TaleListState._();
  const factory TaleListState({
    required StateResult listResult,
    required List<Tale> list,
    required String searchQuery,
  }) = _TaleListState;

  factory TaleListState.initial() {
    return const TaleListState(
      listResult: StateResult.initial(),
      searchQuery: '',
      list: [],
    );
  }
}

StateResult taleListResult(AppState state) => state.taleListState.listResult;
List<Tale> taleList(AppState state) => state.taleListState.list;
