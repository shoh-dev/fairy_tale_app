import 'package:equatable/equatable.dart';
import 'package:myspace_redux/myspace_redux.dart';

class AppState extends Equatable {
  final TalesState talesState;
  final TaleState taleState;

  const AppState({required this.talesState, required this.taleState});

  AppState copyWith({
    TalesState? talesState,
    TaleState? taleState,
  }) {
    return AppState(
      talesState: talesState ?? this.talesState,
      taleState: taleState ?? this.taleState,
    );
  }

  factory AppState.initial() {
    return AppState(
      talesState: TalesState.initial(),
      taleState: TaleState.initial(),
    );
  }

  @override
  List<Object?> get props => [
        taleState,
        talesState,
      ];
}
