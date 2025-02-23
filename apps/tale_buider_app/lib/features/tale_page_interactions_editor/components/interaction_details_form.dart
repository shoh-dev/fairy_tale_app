import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:myspace_design_system/utils/helpers/context.dart';
import 'package:myspace_design_system/utils/helpers/theme.dart';
import 'package:tale_buider_app/features/tale_editor/components/image_selector.dart';

class InteractionDetailsForm extends StatelessWidget {
  const InteractionDetailsForm({super.key, required this.interactions});

  final List<TaleInteraction> interactions;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Interaction Details", style: context.textTheme.headlineSmall),
        for (final interaction in interactions) _Form(interaction: interaction),
        //todo: can open when user can select multiple interactions at once
        // ExpansionTile(
        // collapsedBackgroundColor: context.colorScheme.surface,
        // title: Text(interaction.id),
        // initiallyExpanded: true,
        // childrenPadding: EdgeInsets.symmetric(vertical: Sizes.web.kLayoutPadding),
        // children: [
        // _Form(interaction: interaction),
        // ],
        // ),
      ],
    );
  }
}

class _Form extends StatefulWidget {
  const _Form({
    required this.interaction,
  });

  final TaleInteraction interaction;

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> with StateHelpers {
  TaleInteraction get interaction => widget.interaction;

  final TextEditingController _widthCtrl = TextEditingController();
  final TextEditingController _heightCtrl = TextEditingController();
  final TextEditingController _initialdxCtrl = TextEditingController();
  final TextEditingController _initialdyCtrl = TextEditingController();
  final TextEditingController _finaldxCtrl = TextEditingController();
  final TextEditingController _finaldyCtrl = TextEditingController();

  @override
  void dispose() {
    safeDispose(() {
      _widthCtrl.dispose();
      _heightCtrl.dispose();
      _initialdxCtrl.dispose();
      _initialdyCtrl.dispose();
      _finaldxCtrl.dispose();
      _finaldyCtrl.dispose();
    });
    super.dispose();
  }

  void showSnackbar(BuildContext context, String message) {
    if (message.isEmpty) {
      return;
    }
    if (ScaffoldMessenger.of(context).mounted) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  void initState() {
    super.initState();
    safeInitialize(() {
      _widthCtrl.text = interaction.size.w.toString();
      _heightCtrl.text = interaction.size.h.toString();
      _initialdxCtrl.text = interaction.initialPosition.dx.toString();
      _initialdyCtrl.text = interaction.initialPosition.dy.toString();
      _finaldxCtrl.text = interaction.finalPosition?.dx.toString() ?? "";
      _finaldyCtrl.text = interaction.finalPosition?.dy.toString() ?? "";
      safeSetState(() {});

      _widthCtrl.addListener(() {
        safeSetState(() {});
      });
      _heightCtrl.addListener(() {
        safeSetState(() {});
      });
      _initialdxCtrl.addListener(() {
        safeSetState(() {});
      });
      _initialdyCtrl.addListener(() {
        safeSetState(() {});
      });
      _finaldxCtrl.addListener(() {
        safeSetState(() {});
      });
      _finaldyCtrl.addListener(() {
        safeSetState(() {});
      });
    });
  }

  @override
  void didUpdateWidget(covariant _Form oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.interaction != widget.interaction) {
      safeSetState(() {
        _widthCtrl.text = interaction.size.w.toString();
        _heightCtrl.text = interaction.size.h.toString();
        _initialdxCtrl.text = interaction.initialPosition.dx.toString();
        _initialdyCtrl.text = interaction.initialPosition.dy.toString();
        _finaldxCtrl.text = interaction.finalPosition?.dx.toString() ?? "";
        _finaldyCtrl.text = interaction.finalPosition?.dy.toString() ?? "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        Text("ID: ${interaction.id}", style: context.textTheme.titleMedium),
        const Divider(height: 0),
        _TypeDropdown(interaction: interaction),
        _SubTypeDropdown(interaction: interaction),
        TextFieldComponent(
          label: 'Width',
          maxLines: 1,
          controller: _widthCtrl,
          suffixWidgets: [
            ButtonComponent.icon(
              icon: Icons.aspect_ratio_rounded,
              onPressed:
                  //function to make with and height equal to width
                  isValid(_widthCtrl)
                      ? () => dispatch(interaction.updateSize(TaleInteractionSize(num.parse(_widthCtrl.text), num.parse(_widthCtrl.text))))
                      : null,
            ),
            ButtonComponent.icon(
              icon: Icons.save,
              onPressed:
                  isValid(_widthCtrl) ? () => dispatch(interaction.updateSize(TaleInteractionSize(num.parse(_widthCtrl.text), interaction.size.h))) : null,
            ),
          ],
        ),
        TextFieldComponent(
          label: 'Height',
          maxLines: 1,
          controller: _heightCtrl,
          suffixWidgets: [
            ButtonComponent.icon(
              icon: Icons.aspect_ratio_rounded,
              onPressed:
                  //function to make with and height equal to height
                  isValid(_heightCtrl)
                      ? () => dispatch(interaction.updateSize(TaleInteractionSize(num.parse(_heightCtrl.text), num.parse(_heightCtrl.text))))
                      : null,
            ),
            ButtonComponent.icon(
              icon: Icons.save,
              onPressed:
                  isValid(_heightCtrl) ? () => dispatch(interaction.updateSize(TaleInteractionSize(interaction.size.w, num.parse(_heightCtrl.text)))) : null,
            ),
          ],
        ),
        TextFieldComponent(
          label: 'Initial Position X',
          maxLines: 1,
          controller: _initialdxCtrl,
          suffixWidgets: [
            ButtonComponent.icon(
              icon: Icons.save,
              onPressed: isValid(_initialdxCtrl)
                  ? () => dispatch(interaction.updateInitialPosition(TaleInteractionPosition(num.parse(_initialdxCtrl.text), interaction.initialPosition.dy)))
                  : null,
            ),
          ],
        ),
        TextFieldComponent(
          label: 'Initial Position Y',
          maxLines: 1,
          controller: _initialdyCtrl,
          suffixWidgets: [
            ButtonComponent.icon(
              icon: Icons.save,
              onPressed: isValid(_initialdyCtrl)
                  ? () => dispatch(interaction.updateInitialPosition(TaleInteractionPosition(interaction.initialPosition.dx, num.parse(_initialdyCtrl.text))))
                  : null,
            ),
          ],
        ),
        TextFieldComponent(
          label: 'Final Position X',
          maxLines: 1,
          controller: _finaldxCtrl,
          enabled: interaction.eventSubtype.isEmpty ? false : interaction.eventSubTypeEnum.isSwipe,
          suffixWidgets: [
            ButtonComponent.icon(
              icon: Icons.save,
              onPressed: isValid(_finaldxCtrl)
                  ? () => dispatch(interaction.updateFinalPosition(TaleInteractionPosition(num.parse(_finaldxCtrl.text), interaction.finalPosition?.dy ?? 0)))
                  : null,
            ),
          ],
        ),
        TextFieldComponent(
          label: 'Final Position Y',
          maxLines: 1,
          controller: _finaldyCtrl,
          enabled: interaction.eventSubtype.isEmpty ? false : interaction.eventSubTypeEnum.isSwipe,
          suffixWidgets: [
            ButtonComponent.icon(
              icon: Icons.save,
              onPressed: isValid(_finaldyCtrl)
                  ? () => dispatch(interaction.updateFinalPosition(TaleInteractionPosition(interaction.finalPosition?.dx ?? 0, num.parse(_finaldyCtrl.text))))
                  : null,
            ),
          ],
        ),
        ImageSelectorComponent(
          title: "Object Image",
          imagePath: interaction.objectImageUrl,
        ),
      ],
    );
  }

  bool isValid(TextEditingController controller) {
    if (controller.text.isEmpty || num.tryParse(controller.text) == null) {
      // showSnackbar(context, "Please enter a valid number");
      return false;
    }
    return true;
  }

  void dispatch(TaleInteraction interaction) {
    if (mounted) {
      context.dispatch(UpdateSelectedInteractionAction(interaction));
    }
  }
}

class _TypeDropdown extends StatelessWidget {
  const _TypeDropdown({required this.interaction});

  final TaleInteraction interaction;

  @override
  Widget build(BuildContext context) {
    return DropdownComponent<TaleInteractionEventType>(
      label: 'Event Type',
      initialValue: interaction.eventType.isEmpty ? null : DropdownItem(value: interaction.eventTypeEnum, label: interaction.eventTypeEnum.name),
      items: [
        for (final type in TaleInteractionEventType.values) DropdownItem(value: type, label: type.name),
      ],
      onChanged: (value) {
        if (value == null) {
          return;
        }
        context.dispatch(UpdateSelectedInteractionAction(interaction.updateEventType(value.value)));
      },
    );
  }
}

class _SubTypeDropdown extends StatelessWidget {
  const _SubTypeDropdown({required this.interaction});

  final TaleInteraction interaction;

  @override
  Widget build(BuildContext context) {
    return DropdownComponent<TaleInteractionEventSubType>(
      label: 'Event Type',
      initialValue: interaction.eventSubtype.isEmpty ? null : DropdownItem(value: interaction.eventSubTypeEnum, label: interaction.eventSubTypeEnum.name),
      items: [
        for (final type in TaleInteractionEventSubType.values) DropdownItem(value: type, label: type.name),
      ],
      onChanged: (value) {
        if (value == null) {
          return;
        }
        context.dispatch(UpdateSelectedInteractionAction(interaction.updateEventSubType(value.value)));
      },
    );
  }
}
