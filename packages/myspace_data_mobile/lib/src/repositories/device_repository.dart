import 'package:flutter/services.dart';
import 'package:myspace_data/myspace_data.dart';

abstract class DeviceRepository {
  ResultFuture<void> setDeviceOrientation(List<DeviceOrientation> orientations);
}

class DeviceRepositoryImpl implements DeviceRepository {
  const DeviceRepositoryImpl();

  @override
  ResultFuture<void> setDeviceOrientation(List<DeviceOrientation> orientations) async {
    try {
      if (orientations.isEmpty) {
        return Result.error(ErrorX('Please provide orientations!'));
      }
      await SystemChrome.setPreferredOrientations(orientations);
      return Result.ok(null);
    } catch (e, st) {
      return Result.error(ErrorX(e, st));
    }
  }
}
