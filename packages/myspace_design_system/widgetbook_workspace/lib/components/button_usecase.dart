import 'dart:developer';

import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

void _onPressed() => log("Button Pressed");

const _icon = Icons.send_rounded;

bool _getEnabledKnob(BuildContext context) {
  return context.knobs.boolean(label: "Enabled", initialValue: true);
}

bool _getWithIconKnob(BuildContext context) {
  return context.knobs.boolean(label: "With Icon");
}

//Outlined icon Button
@widgetbook.UseCase(name: 'Icon Button', type: ButtonComponent)
Widget buildIconButton(BuildContext context) {
  final buttonList = <Widget>[
    ButtonComponent.iconOutlined(
      onPressed: _getEnabledKnob(context) ? _onPressed : null,
      icon: _icon,
    ),
    ButtonComponent.icon(
      onPressed: _getEnabledKnob(context) ? _onPressed : null,
      icon: _icon,
    ),
  ];

  return context.knobs.list<Widget>(
      label: "Button type",
      labelBuilder: (widget) {
        if (widget == buttonList[0]) {
          return "Outlined";
        }
        return "Contained";
      },
      options: buttonList);
}

@widgetbook.UseCase(name: 'Outlined Button', type: ButtonComponent)
Widget buildOutlinedButton(BuildContext context) {
  return ButtonComponent.outlined(
    text: "Outlined Button",
    icon: _getWithIconKnob(context) ? _icon : null,
    onPressed: _getEnabledKnob(context) ? _onPressed : null,
  );
}

@widgetbook.UseCase(name: 'Primary Button', type: ButtonComponent)
Widget buildPrimaryButton(BuildContext context) {
  return ButtonComponent.primary(
    text: "Primary Button",
    onPressed: _getEnabledKnob(context) ? _onPressed : null,
    icon: _getWithIconKnob(context) ? _icon : null,
  );
}

@widgetbook.UseCase(name: 'Text Button', type: ButtonComponent)
Widget buildTextButton(BuildContext context) {
  return ButtonComponent.text(
    text: "Text Button",
    onPressed: _getEnabledKnob(context) ? _onPressed : null,
    icon: _getWithIconKnob(context) ? _icon : null,
  );
}

//Destructive Button
@widgetbook.UseCase(name: 'Destructive Button', type: ButtonComponent)
Widget buildDestructiveButton(BuildContext context) {
  return ButtonComponent.destructive(
    text: "Destructive Button",
    icon: _getWithIconKnob(context) ? _icon : null,
    onPressed: _getEnabledKnob(context) ? _onPressed : null,
  );
}
