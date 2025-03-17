import 'package:fairy_tale_builder_platform/components/loading_component.dart';
import 'package:fairy_tale_builder_platform/components/orientation_selector.dart';
import 'package:fairy_tale_builder_platform/components/translation_selector.dart';
import 'package:fairy_tale_builder_platform/manager/redux/mixin.dart';
import 'package:fairy_tale_builder_platform/manager/redux/selected_tale_state/actions/tale_actions.dart';
import 'package:fairy_tale_builder_platform/manager/redux/selected_tale_state/selected_tale_state.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:fairy_tale_builder_platform/pages/tale_editor/components/audio_selector.dart';
import 'package:fairy_tale_builder_platform/pages/tale_editor/components/image_selector.dart';
import 'package:fairy_tale_builder_platform/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:shared/shared.dart';

class TalepageSettings extends StatelessWidget
    with StateConnectorMixin<(StateResult, Tale)> {
  const TalepageSettings({super.key});

  @override
  Widget builder(BuildContext context, Dispatcher<AppState> dispatch,
      (StateResult, Tale) model) {
    return model.$1.when(
      ok: () {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _Form(model.$2),
          ],
        );
      },
      initial: () => const SizedBox(),
      error: (error) => Center(
        child: Text(error.string()),
      ),
      loading: LoadingComponent.new,
    );
  }

  @override
  (StateResult, Tale) selector(AppState state) => (
        state.selectedTaleState.taleResult,
        selectedTale(state),
      );
}

class _Form extends StatefulWidget {
  const _Form(this.tale);

  final Tale tale;

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> with DispatchConnectorMixinState {
  Tale get tale => widget.tale;

  final formKey = GlobalKey<FormState>();

  @override
  Widget builder(BuildContext context, Dispatcher<AppState> dispatch) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: Sizes.kMaxWidth * .5,
      ),
      width: double.infinity,
      height: double.infinity,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 32),
        children: [
          Text(
            'Tale Settings',
            style:
                context.textTheme.titleLarge!.copyWith(color: context.primary),
          ),
          space(),
          TranslationSelector(
            label: 'Title',
            textKey: tale.title,
            isRequiredToSelect: true,
            onChanged: (value) {
              dispatch(
                UpdateTaleAction(title: value),
              );
            },
          ),
          space(),
          TranslationSelector(
            label: 'Description',
            textKey: tale.description,
            onChanged: (value) {
              dispatch(UpdateTaleAction(description: value));
            },
          ),
          space(),
          OrientationSelector(
            orientation: tale.orientation,
            onChanged: (value) {
              dispatch(UpdateTaleAction(orientation: value));
            },
          ),
          space(),
          ExpansionTile(
            initiallyExpanded: true,
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
                title: 'Cover Image',
                imagePath: tale.metadata.coverImageUrl,
                onImageSelected: (value) {
                  dispatch(UpdateTaleAction(coverImageFile: value));
                },
              ),
              space(16),
              AudioSelectorComponent(
                title: 'Background audio',
                audioPlayer: tale.audioPlayerService,
                audioPath: tale.metadata.backgroundAudioUrl,
                onAudioRemoved: () {
                  dispatch(UpdateTaleAction(backgroundAudioUrl: ''));
                },
                onAudioSelected: (value) {
                  dispatch(UpdateTaleAction(backgroundAudioFile: value));
                },
              ),
            ],
          ),
          space(),
          const ButtonComponent.destructive(
            text: 'Delete Tale',
            icon: Icons.delete_outline_rounded,
            // onPressed: () {
            //todo: show confirmation first
            // },
          ),
        ],
      ),
    );
  }

  Widget space([double height = 24]) {
    return SizedBox(height: height);
  }
}
