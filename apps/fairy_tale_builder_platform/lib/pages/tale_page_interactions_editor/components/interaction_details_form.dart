import 'package:fairy_tale_builder_platform/components/translation_selector.dart';
import 'package:fairy_tale_builder_platform/manager/redux/features/tales/tale/editor/action.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:fairy_tale_builder_platform/pages/tale_editor/components/image_selector.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:shared/shared.dart';

class InteractionDetailsForm extends StatelessWidget {
  const InteractionDetailsForm({required this.interaction, super.key});

  final TaleInteraction interaction;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DispatchConnector<AppState>(
          builder: (context, dispatch) {
            return Row(
              children: [
                Text(
                  'Interaction Details',
                  style: context.textTheme.headlineSmall,
                ),
              ],
            );
          },
        ),
        _Form(interaction: interaction),
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
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  void initState() {
    super.initState();
    safeInitialize(() {
      _widthCtrl.text = interaction.size.w.toStringAsFixed(2);
      _heightCtrl.text = interaction.size.h.toStringAsFixed(2);
      _initialdxCtrl.text = interaction.initialPosition.dx.toStringAsFixed(2);
      _initialdyCtrl.text = interaction.initialPosition.dy.toStringAsFixed(2);
      _finaldxCtrl.text =
          interaction.finalPosition?.dx.toStringAsFixed(2) ?? '';
      _finaldyCtrl.text =
          interaction.finalPosition?.dy.toStringAsFixed(2) ?? '';
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
        _widthCtrl.text = interaction.size.w.toStringAsFixed(2);
        _heightCtrl.text = interaction.size.h.toStringAsFixed(2);
        _initialdxCtrl.text = interaction.initialPosition.dx.toStringAsFixed(2);
        _initialdyCtrl.text = interaction.initialPosition.dy.toStringAsFixed(2);
        _finaldxCtrl.text =
            interaction.finalPosition?.dx.toStringAsFixed(2) ?? '';
        _finaldyCtrl.text =
            interaction.finalPosition?.dy.toStringAsFixed(2) ?? '';
      });
    }
  }

  TaleInteractionSize makeInteractionSize() {
    return TaleInteractionSize(
      num.tryParse(_widthCtrl.text) ?? interaction.size.width,
      num.tryParse(_heightCtrl.text) ?? interaction.size.height,
    );
  }

  TaleInteractionPosition makeInteractionInitialPosition() {
    return TaleInteractionPosition(
      num.tryParse(_initialdxCtrl.text) ?? interaction.initialPosition.dx,
      num.tryParse(_initialdyCtrl.text) ?? interaction.initialPosition.dy,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DispatchConnector<AppState>(
      builder: (context, dp) {
        // final deviceSize = Devices.ios.iPhone13.screenSize;

        void dispatch(TaleInteraction interaction) {
          if (mounted) {
            dp(UpdateSelectedInteractionAction(interaction));
          }
        }

        Widget saveButton(
          TaleInteraction interaction,
          TextEditingController controller,
        ) {
          return ButtonComponent.iconOutlined(
            icon: Icons.save,
            onPressed: isValid(controller) ? () => dispatch(interaction) : null,
          );
        }

        Widget aspectButtonSize(bool isWidth) {
          return ButtonComponent.iconOutlined(
            tooltip: 'Make width and height equal',
            icon: Icons.aspect_ratio_rounded,
            onPressed:
                //function to make with and height equal to width
                isValid(isWidth ? _widthCtrl : _heightCtrl)
                    ? () => dispatch(
                          interaction.updateSize(
                            TaleInteractionSize(
                              num.parse(
                                isWidth ? _widthCtrl.text : _heightCtrl.text,
                              ),
                              num.parse(
                                isWidth ? _widthCtrl.text : _heightCtrl.text,
                              ),
                            ),
                          ),
                        )
                    : null,
          );
        }

        Widget aspectButtonPosition(bool isX) {
          return ButtonComponent.iconOutlined(
            tooltip: 'Make X and Y equal',
            icon: Icons.aspect_ratio_rounded,
            onPressed:
                //function to make with and height equal to width
                isValid(isX ? _initialdxCtrl : _initialdyCtrl)
                    ? () => dispatch(
                          interaction.updateInitialPosition(
                            TaleInteractionPosition(
                              num.parse(
                                isX ? _initialdxCtrl.text : _initialdyCtrl.text,
                              ),
                              num.parse(
                                isX ? _initialdxCtrl.text : _initialdyCtrl.text,
                              ),
                            ),
                          ),
                        )
                    : null,
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            const Divider(height: 0),
            TranslationSelector(
              label: 'Hint',
              textKey: interaction.hintKey,
              onChanged: (value) {
                dispatch(interaction.updateHintKey(value));
              },
            ),
            TextFieldComponent(
              label: 'Width',
              maxLines: 1,
              controller: _widthCtrl,
              suffixWidgets: [
                aspectButtonSize(true),
                saveButton(
                  interaction.updateSize(makeInteractionSize()),
                  _widthCtrl,
                ),
              ],
            ),
            TextFieldComponent(
              label: 'Height',
              maxLines: 1,
              controller: _heightCtrl,
              suffixWidgets: [
                aspectButtonSize(false),
                saveButton(
                  interaction.updateSize(makeInteractionSize()),
                  _heightCtrl,
                ),
              ],
            ),
            TextFieldComponent(
              label: 'Initial Position X',
              maxLines: 1,
              controller: _initialdxCtrl,
              suffixWidgets: [
                aspectButtonPosition(true),
                saveButton(
                  interaction
                      .updateInitialPosition(makeInteractionInitialPosition()),
                  _initialdxCtrl,
                ),
              ],
            ),
            TextFieldComponent(
              label: 'Initial Position Y',
              maxLines: 1,
              controller: _initialdyCtrl,
              suffixWidgets: [
                aspectButtonPosition(false),
                saveButton(
                  interaction
                      .updateInitialPosition(makeInteractionInitialPosition()),
                  _initialdyCtrl,
                ),
              ],
            ),
            _TypeDropdown(interaction: interaction),
            _SubTypeDropdown(interaction: interaction),
            _ActionDropdown(interaction: interaction),
            if (interaction.availableSubTypes.isNotEmpty)
              Text(
                //
                // ignore: lines_longer_than_80_chars
                'When user ${interaction.eventType} -> ${interaction.eventSubtype} -> ${interaction.action}',
              ),
            TextFieldComponent(
              label: 'Final Position X',
              maxLines: 1,
              controller: _finaldxCtrl,
              enabled: interaction.actionEnum == TaleInteractionAction.move,
              suffixWidgets: const [
                ButtonComponent.icon(
                  icon: Icons.save,
                  // onPressed: isValid(_finaldxCtrl)
                  //     ? () => dispatch(interaction.updateFinalPosition(
                  //         TaleInteractionPosition(num.parse(_finaldxCtrl.text
                  // ),
                  //             interaction.finalPosition?.dy ?? 0)))
                  //     : null,
                ),
              ],
            ),
            TextFieldComponent(
              label: 'Final Position Y',
              maxLines: 1,
              controller: _finaldyCtrl,
              enabled: interaction.actionEnum == TaleInteractionAction.move,
              suffixWidgets: const [
                ButtonComponent.icon(
                  icon: Icons.save,
                  // onPressed: isValid(_finaldyCtrl)
                  //     ? () => dispatch(interaction.updateFinalPosition(
                  //         TaleInteractionPosition(
                  //             interaction.finalPosition?.dx ?? 0,
                  //             num.parse(_finaldyCtrl.text))))
                  //     : null,
                ),
              ],
            ),
            Text(
              'Metadata',
              style: context.textTheme.headlineSmall,
            ),
            ImageSelectorComponent(
              title: 'Object Image',
              imagePath: interaction.metadata.imageUrl,
            ),
          ],
        );
      },
    );
  }

  bool isValid(TextEditingController controller) {
    if (controller.text.isEmpty || num.tryParse(controller.text) == null) {
      return false;
    }
    return true;
  }
}

class _TypeDropdown extends StatelessWidget {
  const _TypeDropdown({required this.interaction});

  final TaleInteraction interaction;

  @override
  Widget build(BuildContext context) {
    return DispatchConnector<AppState>(
      builder: (context, dispatch) {
        return DropdownComponent<TaleInteractionEventType>(
          label: 'Event Type',
          initialValue: interaction.eventTypeEnum == null
              ? null
              : DropdownItem(
                  value: interaction.eventTypeEnum!,
                  label: interaction.eventTypeEnum!.name,
                ),
          items: [
            for (final type in TaleInteractionEventType.values)
              DropdownItem(value: type, label: type.name),
          ],
          onChanged: (value) {
            if (value == null) {
              return;
            }
            dispatch(
              UpdateSelectedInteractionAction(
                interaction.updateEventType(value.value),
              ),
            );
          },
        );
      },
    );
  }
}

class _SubTypeDropdown extends StatelessWidget {
  const _SubTypeDropdown({required this.interaction});

  final TaleInteraction interaction;

  @override
  Widget build(BuildContext context) {
    if (interaction.availableSubTypes.isEmpty) {
      return const SizedBox.shrink();
    }
    return DispatchConnector<AppState>(
      builder: (context, dispatch) {
        return DropdownComponent<TaleInteractionSubType>(
          label: 'Event Sub Type',
          initialValue: interaction.eventSubTypeEnum == null
              ? null
              : DropdownItem(
                  value: interaction.eventSubTypeEnum!,
                  label: interaction.eventSubTypeEnum!.name(),
                ),
          items: [
            for (final type in interaction.availableSubTypes)
              DropdownItem(value: type, label: type.name()),
          ],
          onChanged: (value) {
            if (value == null) {
              return;
            }
            dispatch(
              UpdateSelectedInteractionAction(
                interaction.updateEventSubType(value.value),
              ),
            );
          },
        );
      },
    );
  }
}

class _ActionDropdown extends StatelessWidget {
  const _ActionDropdown({required this.interaction});

  final TaleInteraction interaction;

  @override
  Widget build(BuildContext context) {
    if (interaction.availableSubTypes.isEmpty) {
      return const SizedBox.shrink();
    }
    return DispatchConnector<AppState>(
      builder: (context, dispatch) {
        return DropdownComponent<TaleInteractionAction>(
          label: 'Action',
          initialValue: interaction.actionEnum == null
              ? null
              : DropdownItem(
                  value: interaction.actionEnum!,
                  label: interaction.actionEnum!.name,
                ),
          items: [
            for (final type in TaleInteractionAction.values)
              DropdownItem(value: type, label: type.name),
          ],
          onChanged: (value) {
            if (value == null) {
              return;
            }
            dispatch(
              UpdateSelectedInteractionAction(
                interaction.updateAction(value.value),
              ),
            );
          },
        );
      },
    );
  }
}
