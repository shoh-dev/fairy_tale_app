import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

class HardCodedTextComponent extends TextComponent {
  final String text;
  final bool ignoreLog;

  HardCodedTextComponent(this.text, {super.key, this.ignoreLog = false}) {
    if (!ignoreLog) {
      try {
        final stackTrace = StackTrace.current;
        final fileName = stackTrace.toString().split('\n')[1];
        log("\n${fileName.replaceAll("     ", "")}",
            name: '_HardCodedTextComponentValue');
      } catch (e) {
        log("Error occurred while logging $e",
            name: '_HardCodedTextComponentValue');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}
