import 'package:fairy_tale_builder_platform/components/audio_selector.dart';
import 'package:fairy_tale_builder_platform/components/image_selector.dart';
import 'package:fairy_tale_builder_platform/components/translation_selector.dart';
import 'package:fairy_tale_builder_platform/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:shared/shared.dart';

class TalepageInteractionForm extends StatelessWidget
    with StateConnectorMixin<TaleInteraction?> {
  const TalepageInteractionForm({super.key});

  @override
  Widget builder(
    BuildContext context,
    Dispatcher<AppState> dispatch,
    TaleInteraction? model,
  ) {
    return Container(
      width: Sizes.kMaxWidth * .2,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        border: Border(
          left: BorderSide(color: Colors.grey.shade800),
          top: BorderSide(color: Colors.grey.shade800),
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
        ),
      ),
      child: model == null
          ? const Center(
              child: Text('Please select an interaction!'),
            )
          : _Form(
              interaction: model,
            ),
    );
  }

  @override
  TaleInteraction? selector(AppState state) => selectedInteraction(state);
}

class _Form extends StatefulWidget {
  const _Form({
    required this.interaction,
  });

  final TaleInteraction interaction;

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form>
    with DispatchConnectorMixinState, StateHelpers {
  TaleInteraction get interaction => widget.interaction;

  final formKey = GlobalKey<FormState>();

  final TextEditingController _widthCtrl = TextEditingController();
  final TextEditingController _heightCtrl = TextEditingController();
  final TextEditingController _initialdxCtrl = TextEditingController();
  final TextEditingController _initialdyCtrl = TextEditingController();
  final TextEditingController _finaldxCtrl = TextEditingController();
  final TextEditingController _finaldyCtrl = TextEditingController();
  final TextEditingController _animationDurationCtrl = TextEditingController();

  void initialize() {
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
    });
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  void onDispose(Dispatcher<AppState> dispatch) {
    dispatch(saveAction());
    print("Dispose");
  }

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

  @override
  void didUpdateWidget(covariant _Form oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.interaction != widget.interaction) {
      initialize();
    }
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

  bool isNumber(TextEditingController controller) {
    if (controller.text.isEmpty || num.tryParse(controller.text) == null) {
      return false;
    }
    return true;
  }

  UpdateInteractionAction saveAction() {
    return UpdateInteractionAction(
      id: interaction.id,
      width: num.tryParse(_widthCtrl.text),
      height: num.tryParse(_heightCtrl.text),
      initialdx: num.tryParse(_initialdxCtrl.text),
      initialdy: num.tryParse(_initialdyCtrl.text),
      finaldx: num.tryParse(_finaldxCtrl.text),
      finaldy: num.tryParse(_finaldyCtrl.text),
      animationDuration: int.tryParse(_animationDurationCtrl.text),
    );
  }

  @override
  Widget builder(BuildContext context, Dispatcher<AppState> dispatch) {
    Widget aspectButtonSize(bool isWidth) {
      return ButtonComponent.iconOutlined(
        tooltip: 'Make width and height equal',
        icon: Icons.aspect_ratio_rounded,
        onPressed:
            //function to make with and height equal to width
            isNumber(isWidth ? _widthCtrl : _heightCtrl)
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
            isNumber(isX ? _initialdxCtrl : _initialdyCtrl)
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
            isNumber(isX ? _finaldxCtrl : _finaldyCtrl)
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

    void onSave() {
      if (formKey.currentState?.validate() == true) {
        if (interaction.actionEnum == TaleInteractionAction.playSound &&
            !interaction.metadata.hasAudio) {
          showSnackbar(context, 'Please select audio in metadata!');
          return;
        }
        dispatch(
          UpdateInteractionAction(
            width: num.tryParse(_widthCtrl.text),
            height: num.tryParse(_heightCtrl.text),
            initialdx: num.tryParse(_initialdxCtrl.text),
            initialdy: num.tryParse(_initialdyCtrl.text),
            finaldx: num.tryParse(_finaldxCtrl.text),
            finaldy: num.tryParse(_finaldyCtrl.text),
            animationDuration: int.tryParse(_animationDurationCtrl.text),
          ),
        );
      } else {
        showSnackbar(context, 'Invalid form!');
      }
    }

    return Form(
      key: formKey,
      child: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Row(
            children: [
              Text(
                'Interaction Details',
                style: context.textTheme.titleMedium,
              ),
              const Spacer(),
              ButtonComponent.primary(
                text: 'Save',
                icon: Icons.save_rounded,
                onPressed: onSave,
              ),
            ],
          ),
          space(),
          _TypeDropdown(interaction: interaction),
          if (interaction.availableSubTypes.isNotEmpty) ...[
            space(),
            _SubTypeDropdown(interaction: interaction),
            space(),
            _ActionDropdown(interaction: interaction),
          ],
          space(),
          TranslationSelector(
            label: 'Hint',
            textKey: interaction.hintKey,
            onChanged: (value) {
              dispatch(
                UpdateInteractionAction(hintKey: value),
              );
            },
          ),
          space(),
          Row(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextFieldComponent(
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
                  suffixWidgets: (query) => [
                    aspectButtonSize(true),
                  ],
                ),
              ),
              Expanded(
                child: TextFieldComponent(
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
                ),
              ),
            ],
          ),
          space(),
          Row(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextFieldComponent(
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
                  ],
                ),
              ),
              Expanded(
                child: TextFieldComponent(
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
                ),
              ),
            ],
          ),
          if (interaction.actionEnum == TaleInteractionAction.move) ...[
            space(),
            Row(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextFieldComponent(
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
                    ],
                  ),
                ),
                Expanded(
                  child: TextFieldComponent(
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
                  ),
                ),
              ],
            ),
          ],
          space(),
          TextFieldComponent(
            label: 'Animation Duration (milliseconds)',
            maxLines: 1,
            controller: _animationDurationCtrl,
            validator: (value) {
              if (!isNumber(_animationDurationCtrl)) {
                return 'Animation duration must be a number';
              }
              return null;
            },
          ),
          space(),
          ExpansionTile(
            childrenPadding: const EdgeInsets.only(
              left: 16,
              bottom: 16,
              right: 16,
            ),
            title: const Text('Metadata'),
            expandedAlignment: Alignment.centerLeft,
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //image
              ImageSelectorComponent(
                title: 'Object Image',
                imagePath: interaction.metadata.imageUrl,
                recommendedSize: interaction.metadata.size.toSize(),
                onImageSelected: (value) {
                  dispatch(UpdateInteractionAction(imageFile: value));
                },
              ),
              if (interaction.actionEnum ==
                  TaleInteractionAction.playSound) ...[
                space(12),
                //Audio
                AudioSelectorComponent(
                  title: 'Audio',
                  audioPath: interaction.metadata.audioUrl,
                  audioPlayer: interaction.audioPlayerService,
                  onAudioSelected: (value) {
                    dispatch(UpdateInteractionAction(audioFile: value));
                  },
                ),
              ],
            ],
          ),
          space(),
          ButtonComponent.destructive(
            text: 'Delete',
            icon: Icons.delete_outline_rounded,
            onPressed: () {
              //todo: show confirmation first
              dispatch(DeleteInteractionAction(interaction));
            },
          ),
        ],
      ),
    );
  }

  Widget space([double height = 24]) {
    return SizedBox(height: height);
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
          helperText:
              'When -> ${interaction.eventType} (${interaction.eventSubtype}) -> ${interaction.action.replaceAll("_", " ")}',
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
