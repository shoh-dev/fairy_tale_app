import 'package:fairy_tale_mobile/pages/app/app.dart';
import 'package:fairy_tale_mobile/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:shared/shared.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final log = Log();

  final di = DependencyInjection();

  await Future.wait([
    SystemChrome.setPreferredOrientations(AppConstants.appOrientation),
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge),
  ]);

  final diResult = await di.init();

  diResult.when(
    ok: (_) {
      log.debug('DI initialized successfully!');
      runApp(
        StoreProvider(
          appStore: AppStore(
            initialState: AppState.initial(),
            di: di,
          ).createStore(),
          child: const App(),
        ),
      );
    },
    error: (error) {
      log.error(error);
      throw error;
    },
  );
}
