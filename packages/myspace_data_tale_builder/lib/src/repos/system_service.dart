import 'package:flutter/services.dart';
import 'package:myspace_data/myspace_data.dart';

abstract class SystemService {
  ResultFuture<void> setDeviceOrientation(List<DeviceOrientation> orientations);
}

class SystemServiceImpl implements SystemService {
  const SystemServiceImpl();

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
