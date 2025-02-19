import 'package:equatable/equatable.dart';

import 'localization/state.dart';

class ApplicationState extends Equatable {
  final AppLocalizationState localizationState;

  const ApplicationState({
    required this.localizationState,
  });

  @override
  List<Object?> get props => [localizationState];

  factory ApplicationState.initial() {
    return ApplicationState(
      localizationState: AppLocalizationState.initial(),
    );
  }

  // CopyWith method
  ApplicationState copyWith({
    AppLocalizationState? localizationState,
  }) {
    return ApplicationState(
      localizationState: localizationState ?? this.localizationState,
    );
  }
}
