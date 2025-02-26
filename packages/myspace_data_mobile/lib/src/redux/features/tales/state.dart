import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_data_mobile/src/repositories/tale/models.dart';

part 'state.freezed.dart';

@freezed
class TalesState with _$TalesState {
  const TalesState._();
  const factory TalesState({
    required StateResult status,
    required List<Tale> tales,
  }) = _TalesState;

  factory TalesState.initial() {
    return const TalesState(
      status: StateResult.loading(),
      tales: [],
    );
  }
}
