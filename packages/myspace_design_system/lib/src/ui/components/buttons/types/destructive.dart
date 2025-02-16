import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:flutter/material.dart';
import 'package:myspace_design_system/src/ui/components/shared/disabled_component.dart';

Widget _disabled(Widget child, VoidCallback? onPressed) {
  return DisabledComponent(
    isDisabled: onPressed == null,
    child: child,
  );
}

class DestructiveButtonComponent extends ButtonComponent {
  const DestructiveButtonComponent({
    super.key,
    super.onPressed,
    required String text,
    super.icon,
  }) : super(text: text);

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return _disabled(
        FilledButton.icon(
          onPressed: onPressed,
          label: Text(text!),
          icon: Icon(icon),
          style: FilledButton.styleFrom(
            backgroundColor: Colors.red,
          ),
        ),
        onPressed,
      );
    }
    return _disabled(
      FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: Colors.red,
        ),
        child: Text(text!),
      ),
      onPressed,
    );
  }
}
