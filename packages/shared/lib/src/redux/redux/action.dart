import 'package:myspace_data/myspace_data.dart';
import 'package:shared/shared.dart';
import 'package:shared/src/redux/di/di.dart';
import 'package:shared/src/redux/redux/app_state/app_state.dart';
import 'package:shared/src/redux/redux/selected_tale_state/selected_tale_state.dart';
import 'package:shared/src/redux/redux/state.dart';
import 'package:shared/src/redux/redux/tale_list_state/tale_list_state.dart';

abstract class DefaultAction extends ReduxAction<AppState> {
  @override
  DependencyInjection get env => super.env! as DependencyInjection;

  //States
  TaleListState get taleListState => state.taleListState;
  SelectedTaleState get selectedTaleState => state.selectedTaleState;
  ApplicationState get applicationState => state.applicationState;

  //Repositories
  TaleRepository get taleRepository => env.taleRepository;

  void throwException(ErrorX error) => throw UserException(
        'Error',
        reason: error.string(),
      );
}
