import 'package:flutter/material.dart';
import 'package:myspace_design_system/utils/helpers/theme.dart';

class FormFieldErrorText extends StatelessWidget {
  const FormFieldErrorText(
    this.errorText, {
    super.key,
  });

  final String errorText;

  @override
  Widget build(BuildContext context) {
    return Text(
      errorText,
      style: context.textTheme.bodySmall!
          .copyWith(color: context.colorScheme.error),
    );
  }
}
