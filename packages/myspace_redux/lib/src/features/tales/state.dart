import 'package:equatable/equatable.dart';
import 'package:myspace_data/myspace_data.dart';

class TalesState extends Equatable {
  final Result<List<Tale>> tales;
  final Result<Tale> selectedTale;

  const TalesState({
    required this.tales,
    required this.selectedTale,
  });

  @override
  List<Object?> get props => [tales, selectedTale];

  factory TalesState.initial() {
    return const TalesState(
      tales: Result.ok([]),
      selectedTale: Result.loading(),
    );
  }

  // CopyWith method
  TalesState copyWith({Result<List<Tale>>? tales, Result<Tale>? selectedTale}) {
    return TalesState(tales: tales ?? this.tales, selectedTale: selectedTale ?? this.selectedTale);
  }
}
