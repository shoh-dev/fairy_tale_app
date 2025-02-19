import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';

class TaleState extends Equatable {
  final Result<void> status;
  final Tale selectedTale;
  final List<TaleLocalization> localizations;

  const TaleState({
    required this.status,
    required this.selectedTale,
    required this.localizations,
  });

  @override
  List<Object?> get props => [selectedTale, status, localizations];

  factory TaleState.initial() {
    return const TaleState(
      selectedTale: Tale.empty,
      status: Result.loading(),
      localizations: [],
    );
  }

  // CopyWith method
  TaleState copyWith({
    Result<void>? status,
    Tale? selectedTale,
    List<TaleLocalization>? localizations,
  }) {
    return TaleState(
      selectedTale: selectedTale ?? this.selectedTale,
      status: status ?? this.status,
      localizations: localizations ?? this.localizations,
    );
  }

  @override
  String toString() {
    return 'TaleState{status: $status, selectedTale: $selectedTale, localizations: $localizations}';
  }
}

extension TaleLocalizationHelper on BuildContext {
  String? taleTr(String? key) {
    final state = getState<AppState>();
    final status = state.applicationState.localizationState.status;
    if (!status.isOk) {
      return key;
    }
    return state.applicationState.localizationState.translations[key];
  }
}
