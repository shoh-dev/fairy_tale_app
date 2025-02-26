import 'dart:async';

import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_data_mobile/src/repositories.dart';
import 'package:myspace_data_mobile/src/services.dart';

class DependencyInjection extends ReduxDependencyInjection {
  late final ApplicationRepository applicationService;
  late final SupabaseRepository supabaseRepository;
  late final TaleRepository taleRepository;

  @override
  Future<Result> init() async {
    try {
      supabaseRepository = SupabaseRepositoryImpl(EnvironmentKeyServiceImpl() as EnvironmentKeyService);
      final supabaseClient = await supabaseRepository.initialize();
      return supabaseClient.fold(
        (client) {
          applicationService = ApplicationRepositoryImpl(client) as ApplicationRepository;
          taleRepository = TaleRepositoryImpl(client) as TaleRepository;
          return Result.ok(null);
        },
        (error) => Result.error(error),
      );
    } catch (e, st) {
      return Result.error(ErrorX(e, st));
    }
  }
}
