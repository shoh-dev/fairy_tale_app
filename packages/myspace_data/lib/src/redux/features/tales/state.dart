import 'package:equatable/equatable.dart';
import 'package:myspace_data/myspace_data.dart';

class TalesState extends Equatable {
  final Result<List<Tale>> tales;

  const TalesState({
    required this.tales,
  });

  @override
  List<Object?> get props => [tales];

  factory TalesState.initial() {
    return const TalesState(
      tales: Result.ok([]),
    );
  }

  // CopyWith method
  TalesState copyWith({Result<List<Tale>>? tales}) {
    return TalesState(tales: tales ?? this.tales);
  }

  @override
  String toString() {
    return "TalesState(tales: $tales)";
  }
}
