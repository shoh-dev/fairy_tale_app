import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:flutter/material.dart';
import 'package:myspace_design_system/src/ui/components/shared/disabled_component.dart';
import 'package:myspace_design_system/utils/helpers/theme.dart';

Widget _disabled(Widget child, VoidCallback? onPressed) {
  return DisabledComponent(
    isDisabled: onPressed == null,
    child: child,
  );
}

class IconButtonComponent extends ButtonComponent {
  const IconButtonComponent({
    super.key,
    super.onPressed,
    required IconData icon,
  }) : super(icon: icon);

  @override
  Widget build(BuildContext context) {
    return _disabled(
      IconButton(
        onPressed: onPressed,
        icon: Icon(icon!),
        style: IconButton.styleFrom(
          disabledBackgroundColor: context.colorScheme.primaryContainer.withValues(alpha: 0.3),
          disabledForegroundColor: context.colorScheme.onSurface.withValues(alpha: 0.3),
        ),
      ),
      onPressed,
    );
  }
}

class IconButtonComponentOutlined extends ButtonComponent {
  const IconButtonComponentOutlined({
    super.key,
    super.onPressed,
    required IconData icon,
  }) : super(icon: icon);

  @override
  Widget build(BuildContext context) {
    return _disabled(
      IconButton(
        onPressed: onPressed,
        icon: Icon(icon!),
        isSelected: true,
        style: IconButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: context.colorScheme.onSurface,
          disabledForegroundColor: context.colorScheme.onSurface.withValues(alpha: 0.3),
          side: BorderSide(
            color: onPressed == null ? context.colorScheme.outline.withValues(alpha: 0.3) : context.colorScheme.outline,
          ),
        ),
      ),
      onPressed,
    );
  }
}
