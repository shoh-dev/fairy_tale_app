import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_data_mobile/src/redux/di/di.dart';

import 'state.dart';

class AppStore extends ReduxStore<AppState> {
  AppStore({
    super.enableActionLog,
  }) : super(
          initialState: AppState.initial(),
          di: DependencyInjection(),
        );
}
