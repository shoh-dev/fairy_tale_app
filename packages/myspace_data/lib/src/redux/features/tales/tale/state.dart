import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';

class TaleState extends Equatable {
  final Result<void> status;
  final Tale selectedTale;

  const TaleState({
    required this.status,
    required this.selectedTale,
  });

  @override
  List<Object?> get props => [selectedTale, status];

  factory TaleState.initial() {
    return const TaleState(
      selectedTale: Tale.empty,
      status: Result.loading(),
    );
  }

  // CopyWith method
  TaleState copyWith({
    Result<void>? status,
    Tale? selectedTale,
  }) {
    return TaleState(
      selectedTale: selectedTale ?? this.selectedTale,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return 'TaleState{status: $status, selectedTale: $selectedTale}';
  }
}

extension TaleLocalizationHelper on BuildContext {
  String taleTr(String? key) {
    final state = getState<AppState>();
    final status = state.applicationState.localizationState.status;
    if (!status.isOk) {
      return key ?? 'translation not found';
    }
    return state.applicationState.localizationState.translations[key] ?? key ?? 'translation not found';
  }
}
