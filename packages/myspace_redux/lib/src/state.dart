import 'package:equatable/equatable.dart';
import 'package:myspace_redux/src/features/tales/state.dart';

class AppState extends Equatable {
  final TalesState talesState;

  const AppState({required this.talesState});

  AppState copyWith({
    TalesState? talesState,
  }) {
    return AppState(
      talesState: talesState ?? this.talesState,
    );
  }

  factory AppState.initial() {
    return AppState(
      talesState: TalesState.initial(),
    );
  }

  @override
  List<Object?> get props => [
        talesState,
      ];
}
