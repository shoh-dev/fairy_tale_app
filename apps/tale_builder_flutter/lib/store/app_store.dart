import 'package:flutter/widgets.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:tale_builder_flutter/store/states/tale.dart';

class AppStore extends CoreAppStore {
  // ignore: prefer_final_fields
  final ValueNotifier<TaleState> _taleState = ValueNotifier(TaleState());
  TaleState get tale => _taleState.value;
}
