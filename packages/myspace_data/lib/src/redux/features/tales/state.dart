import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myspace_data/myspace_data.dart';

part 'state.freezed.dart';

@freezed
class TalesState with _$TalesState {
  const factory TalesState({
    required Result<List<Tale>> tales,
  }) = _TalesState;

  factory TalesState.initial() {
    return const TalesState(
      tales: Result.ok([]),
    );
  }
}
