import 'package:fairy_tale_builder_platform/components/translation_selector.dart';
import 'package:fairy_tale_builder_platform/manager/redux/selected_tale_state/actions/interaction_actions.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import '../../../lib/components/audio_selector.dart';
import '../../../lib/components/image_selector.dart';
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
  final TextEditingController _animationDurationCtrl = TextEditingController();

  @override
  void dispose() {
    safeDispose(() {
      _widthCtrl.dispose();
      _heightCtrl.dispose();
      _initialdxCtrl.dispose();
      _initialdyCtrl.dispose();
      _finaldxCtrl.dispose();
      _finaldyCtrl.dispose();
      _animationDurationCtrl.dispose();
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
      _animationDurationCtrl.text = interaction.animationDuration.toString();
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
      _animationDurationCtrl.addListener(() {
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
        _animationDurationCtrl.text = interaction.animationDuration.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DispatchConnector<AppState>(
      builder: (context, dispatch) {
        Widget saveButton(
          UpdateInteractionAction action,
          TextEditingController controller,
        ) {
          return ButtonComponent.iconOutlined(
            icon: Icons.save,
            onPressed: isValid(controller) ? () => dispatch(action) : null,
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
                          UpdateInteractionAction(
                            width: num.parse(
                              isWidth ? _widthCtrl.text : _heightCtrl.text,
                            ),
                            height: num.parse(
                              isWidth ? _widthCtrl.text : _heightCtrl.text,
                            ),
                          ),
                        )
                    : null,
          );
        }

        Widget aspectButtonInitialPosition(bool isX) {
          return ButtonComponent.iconOutlined(
            tooltip: 'Make X and Y equal',
            icon: Icons.aspect_ratio_rounded,
            onPressed:
                //function to make with and height equal to width
                isValid(isX ? _initialdxCtrl : _initialdyCtrl)
                    ? () => dispatch(
                          UpdateInteractionAction(
                            initialdx: num.parse(
                              isX ? _initialdxCtrl.text : _initialdyCtrl.text,
                            ),
                            initialdy: num.parse(
                              isX ? _initialdxCtrl.text : _initialdyCtrl.text,
                            ),
                          ),
                        )
                    : null,
          );
        }

        Widget aspectButtonFinalPosition(bool isX) {
          return ButtonComponent.iconOutlined(
            tooltip: 'Make X and Y equal',
            icon: Icons.aspect_ratio_rounded,
            onPressed:
                //function to make with and height equal to width
                isValid(isX ? _finaldxCtrl : _finaldyCtrl)
                    ? () => dispatch(
                          UpdateInteractionAction(
                            finaldx: num.parse(
                              isX ? _finaldxCtrl.text : _finaldyCtrl.text,
                            ),
                            finaldy: num.parse(
                              isX ? _finaldxCtrl.text : _finaldyCtrl.text,
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
                dispatch(UpdateInteractionAction(hintKey: value));
              },
            ),
            TextFieldComponent(
              autovalidateMode: AutovalidateMode.always,
              label: 'Width',
              maxLines: 1,
              controller: _widthCtrl,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Width can't be empty";
                }
                if (num.tryParse(value) == null) {
                  return 'Width must be a number';
                }
                return null;
              },
              suffixWidgets: (q) => [
                aspectButtonSize(true),
                saveButton(
                  UpdateInteractionAction(
                    width: num.tryParse(_widthCtrl.text),
                  ),
                  _widthCtrl,
                ),
              ],
            ),
            TextFieldComponent(
              autovalidateMode: AutovalidateMode.always,
              label: 'Height',
              maxLines: 1,
              controller: _heightCtrl,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Height can't be empty";
                }
                if (num.tryParse(value) == null) {
                  return 'Height must be a number';
                }
                return null;
              },
              suffixWidgets: (q) => [
                aspectButtonSize(false),
                saveButton(
                  UpdateInteractionAction(
                    height: num.tryParse(_heightCtrl.text),
                  ),
                  _heightCtrl,
                ),
              ],
            ),
            TextFieldComponent(
              autovalidateMode: AutovalidateMode.always,
              label: 'Initial Position X',
              maxLines: 1,
              controller: _initialdxCtrl,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Initial position X can't be empty";
                }
                if (num.tryParse(value) == null) {
                  return 'Initial position X must be a number';
                }
                return null;
              },
              suffixWidgets: (q) => [
                aspectButtonInitialPosition(true),
                saveButton(
                  UpdateInteractionAction(
                    initialdx: num.tryParse(_initialdxCtrl.text),
                  ),
                  _initialdxCtrl,
                ),
              ],
            ),
            TextFieldComponent(
              autovalidateMode: AutovalidateMode.always,
              label: 'Initial Position Y',
              maxLines: 1,
              controller: _initialdyCtrl,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Initial position Y can't be empty";
                }
                if (num.tryParse(value) == null) {
                  return 'Initial position Y must be a number';
                }
                return null;
              },
              suffixWidgets: (q) => [
                aspectButtonInitialPosition(false),
                saveButton(
                  UpdateInteractionAction(
                    initialdy: num.tryParse(_initialdyCtrl.text),
                  ),
                  _initialdyCtrl,
                ),
              ],
            ),
            TextFieldComponent(
              autovalidateMode: AutovalidateMode.always,
              label: 'Animation Duration',
              maxLines: 1,
              controller: _animationDurationCtrl,
              validator: (value) {
                if (value != null &&
                    value.isNotEmpty &&
                    num.tryParse(value) == null) {
                  return 'Animation duration must be a number';
                }
                return null;
              },
              suffixWidgets: (q) => [
                saveButton(
                  UpdateInteractionAction(
                    animationDuration:
                        int.tryParse(_animationDurationCtrl.text),
                  ),
                  _animationDurationCtrl,
                ),
              ],
            ),
            _TypeDropdown(interaction: interaction),
            if (interaction.availableSubTypes.isNotEmpty)
              _SubTypeDropdown(interaction: interaction),
            if (interaction.availableSubTypes.isNotEmpty)
              _ActionDropdown(interaction: interaction),
            if (interaction.availableSubTypes.isNotEmpty)
              Text(
                //
                // ignore: lines_longer_than_80_chars
                'When user ${interaction.eventType} -> ${interaction.eventSubtype} -> ${interaction.action}',
              ),
            Text(
              'Metadata',
              style: context.textTheme.headlineSmall,
            ),
            if (interaction.actionEnum == TaleInteractionAction.move) ...[
              TextFieldComponent(
                label: 'Final Position X',
                maxLines: 1,
                controller: _finaldxCtrl,
                autovalidateMode: AutovalidateMode.always,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Final position X can't be empty";
                  }
                  return null;
                },
                suffixWidgets: (q) => [
                  aspectButtonFinalPosition(true),
                  saveButton(
                    UpdateInteractionAction(
                      finaldx: num.tryParse(_finaldxCtrl.text),
                    ),
                    _finaldxCtrl,
                  ),
                ],
              ),
              TextFieldComponent(
                label: 'Final Position Y',
                maxLines: 1,
                controller: _finaldyCtrl,
                autovalidateMode: AutovalidateMode.always,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Final position Y can't be empty";
                  }
                  return null;
                },
                suffixWidgets: (q) => [
                  aspectButtonFinalPosition(false),
                  saveButton(
                    UpdateInteractionAction(
                      finaldy: num.tryParse(_finaldyCtrl.text),
                    ),
                    _finaldyCtrl,
                  ),
                ],
              ),
            ],
            ImageSelectorComponent(
              title: 'Object Image',
              imagePath: interaction.metadata.imageUrl,
              onImageSelected: (value) {
                dispatch(UpdateInteractionAction(imageFile: value));
              },
            ),
            if (interaction.actionEnum == TaleInteractionAction.playSound)
              AudioSelectorComponent(
                title: 'Audio',
                audioPath: interaction.metadata.audioUrl,
                audioPlayer: interaction.audioPlayerService,
                onAudioSelected: (value) {
                  dispatch(UpdateInteractionAction(audioFile: value));
                },
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
          autovalidateMode: AutovalidateMode.always,
          label: 'Event Type',
          validator: (value) {
            if (value == null) {
              return "Event type can't be empty";
            }
            return null;
          },
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
          onChanged: (value, controller) {
            if (value == null) {
              return;
            }
            dispatch(
              UpdateInteractionAction(
                eventType: value.value.name,
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
          autovalidateMode: AutovalidateMode.always,
          label: 'Event Sub Type',
          validator: (value) {
            if (value == null) {
              return "Event sub type can't be empty";
            }
            return null;
          },
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
          onChanged: (value, controller) {
            if (value == null) {
              return;
            }
            dispatch(
              UpdateInteractionAction(
                eventSubType: value.value.name(),
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
          autovalidateMode: AutovalidateMode.always,
          label: 'Action',
          validator: (value) {
            if (value == null) {
              return "Action can't be empty";
            }
            return null;
          },
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
          onChanged: (value, controller) {
            if (value == null) {
              return;
            }
            dispatch(
              UpdateInteractionAction(
                action: value.value.name,
              ),
            );
          },
        );
      },
    );
  }
}
