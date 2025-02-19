import 'package:equatable/equatable.dart';
import 'package:myspace_data/myspace_data.dart';

class AppLocalizationState extends Equatable {
  final Result status;
  final String locale;
  final Map<String, String> translations;
  final int localeVersion;

  const AppLocalizationState({
    required this.locale,
    required this.status,
    required this.translations,
    required this.localeVersion,
  });

  @override
  List<Object?> get props => [locale];

  factory AppLocalizationState.initial() {
    return const AppLocalizationState(
      status: Result.loading(),
      locale: 'en',
      translations: {},
      localeVersion: 0,
    );
  }

  // CopyWith method
  AppLocalizationState copyWith({
    Result? status,
    String? locale,
    Map<String, String>? translations,
    int? localeVersion,
  }) {
    return AppLocalizationState(
      status: status ?? this.status,
      locale: locale ?? this.locale,
      translations: translations ?? this.translations,
      localeVersion: localeVersion ?? this.localeVersion,
    );
  }

  @override
  String toString() {
    return 'AppLocalizationState{status: $status, locale: $locale, translations: $translations, localeVersion: $localeVersion}';
  }
}
