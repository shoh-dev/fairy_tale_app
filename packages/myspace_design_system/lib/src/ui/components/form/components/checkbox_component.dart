import 'package:flutter/material.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:myspace_design_system/src/ui/components/form/components/helper_widgets/form_field_error_text.dart';
import 'package:myspace_design_system/src/ui/components/form/components/helper_widgets/form_field_label.dart';
import 'package:myspace_design_system/src/ui/components/shared/disabled_component.dart';
import 'package:myspace_design_system/utils/helpers/theme.dart';

class CheckboxComponent extends FormField<bool> {
  CheckboxComponent({
    super.key,
    this.onChanged,
    super.enabled,
    super.initialValue,
    super.onSaved,
    super.validator,
    this.label,
  }) : super(
          builder: (field) {
            final hasError = field.hasError;
            final errorText = field.errorText;
            return LayoutComponent.column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DisabledComponent(
                  isDisabled: !enabled,
                  child: LayoutComponent.row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                        side: hasError
                            ? BorderSide(
                                width: 1.5,
                                color: field.context.theme.colorScheme.error)
                            : null,
                        value: field.value,
                        onChanged: enabled
                            ? (value) {
                                field.didChange(value);
                                onChanged?.call(value);
                              }
                            : null,
                      ),
                      if (label != null)
                        FormFieldLabel(
                          label,
                          hasError: hasError,
                          onPressed: () {
                            field.didChange(
                                field.value == null ? null : !field.value!);
                            onChanged?.call(field.value);
                          },
                        ),
                    ],
                  ),
                ),
                if (hasError) FormFieldErrorText(errorText!),
              ],
            );
          },
        );

  final ValueChanged<bool?>? onChanged;
  final String? label;

  @override
  FormFieldState<bool> createState() => _CheckboxComponentState();
}

class _CheckboxComponentState extends FormFieldState<bool> {
  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) setValue(widget.initialValue);
  }
}
