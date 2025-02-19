import 'package:equatable/equatable.dart';
import 'package:myspace_data/src/redux/features/app/state.dart';
import 'package:myspace_data/src/redux/features/features.dart';

class AppState extends Equatable {
  final TalesState talesState;
  final TaleState taleState;
  final ApplicationState applicationState;

  const AppState({
    required this.talesState,
    required this.taleState,
    required this.applicationState,
  });

  AppState copyWith({
    TalesState? talesState,
    TaleState? taleState,
    ApplicationState? applicationState,
  }) {
    return AppState(
      talesState: talesState ?? this.talesState,
      taleState: taleState ?? this.taleState,
      applicationState: applicationState ?? this.applicationState,
    );
  }

  factory AppState.initial() {
    return AppState(
      talesState: TalesState.initial(),
      taleState: TaleState.initial(),
      applicationState: ApplicationState.initial(),
    );
  }

  @override
  List<Object?> get props => [
        taleState,
        talesState,
        applicationState,
      ];
}
