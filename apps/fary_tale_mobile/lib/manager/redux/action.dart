import 'package:fairy_tale_mobile/manager/di/di.dart';
import 'package:fairy_tale_mobile/manager/redux.dart';
import 'package:fairy_tale_mobile/manager/redux/app_state/app_state.dart';
import 'package:fairy_tale_mobile/manager/redux/app_state/localization/localization_state.dart';
import 'package:fairy_tale_mobile/manager/redux/selected_tale_state/selected_tale_state.dart';
import 'package:fairy_tale_mobile/manager/redux/tale_list_state/tale_list_state.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:shared/shared.dart';

abstract class DefaultAction extends ReduxAction<AppState> {
  @override
  DependencyInjection get env => super.env! as DependencyInjection;

  //States
  TaleListState get taleListState => state.taleListState;
  SelectedTaleState get selectedTaleState => state.selectedTaleState;
  ApplicationState get applicationState => state.applicationState;
  LocalizationState get localizationState => applicationState.localizationState;

  //Repositories
  TaleRepository get taleRepository => env.taleRepository;

  //Services
  PathProviderService get pathService => env.pathProviderService;
}
