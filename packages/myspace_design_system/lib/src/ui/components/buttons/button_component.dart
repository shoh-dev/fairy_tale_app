import 'package:flutter/material.dart';

import 'types/outlined.dart';
import 'types/icon.dart';
import 'types/primary.dart';
import 'types/text.dart';
import 'types/destructive.dart';

abstract class ButtonComponent extends StatelessWidget {
  const ButtonComponent({super.key, this.onPressed, this.text, this.icon});

  final VoidCallback? onPressed;
  final String? text;
  final IconData? icon;

  const factory ButtonComponent.outlined({
    VoidCallback? onPressed,
    required String text,
    IconData? icon,
  }) = OutlinedButtonComponent;

  const factory ButtonComponent.primary({
    VoidCallback? onPressed,
    required String text,
    IconData? icon,
  }) = PrimaryButtonComponent;

  const factory ButtonComponent.text({
    VoidCallback? onPressed,
    required String text,
    IconData? icon,
  }) = TextButtonComponent;

  const factory ButtonComponent.icon({
    VoidCallback? onPressed,
    required IconData icon,
  }) = IconButtonComponent;

  const factory ButtonComponent.destructive({
    VoidCallback? onPressed,
    required String text,
    IconData? icon,
  }) = DestructiveButtonComponent;

  const factory ButtonComponent.iconOutlined({
    VoidCallback? onPressed,
    required IconData icon,
  }) = IconButtonComponentOutlined;
}
