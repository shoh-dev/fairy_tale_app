import 'package:myspace_core/myspace_core.dart';
import 'package:tale_builder_flutter/features/tale/model/tale.dart';
import 'package:tale_builder_flutter/features/tale/repository/tale_repository.dart';

class TaleViewModel extends Vm {
  final String id;
  final TaleRepository _taleRepository;

  TaleViewModel(this._taleRepository, {required this.id}) {
    fetchTaleCommand = CommandNoParam(_fetchTale)..execute();
  }

  late final CommandNoParam<void> fetchTaleCommand;
  TaleModel? tale;

  Future<Result<void>> _fetchTale() async {
    final result = await _taleRepository.getTale(id);
    switch (result) {
      case ResultOk<TaleModel>():
        tale = result.value;
        log.info("Fetched tale");
        return Result.ok(null);
      case ResultError<TaleModel>():
        log.warning('Fetch tale error: ${result.e}');
        return Result.error(result.e);
    }
  }
}
