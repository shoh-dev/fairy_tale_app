import 'package:uuid/v4.dart';

abstract class UUID {
  static String v4() {
    return const UuidV4().generate();
  }
}
