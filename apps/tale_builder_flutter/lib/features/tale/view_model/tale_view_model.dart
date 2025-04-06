import 'package:myspace_core/myspace_core.dart';

class TaleViewModel extends Vm {
  final String id;

  TaleViewModel({required this.id}) {
    log.info(id);
  }
}
