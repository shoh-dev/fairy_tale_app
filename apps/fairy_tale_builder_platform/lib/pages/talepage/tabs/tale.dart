import 'package:fairy_tale_builder_platform/components/audio_selector.dart';
import 'package:fairy_tale_builder_platform/components/image_selector.dart';
import 'package:fairy_tale_builder_platform/components/loading_component.dart';
import 'package:fairy_tale_builder_platform/components/orientation_selector.dart';
import 'package:fairy_tale_builder_platform/components/translation_selector.dart';
import 'package:fairy_tale_builder_platform/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:shared/shared.dart';

class TalepageTale extends StatelessWidget
    with StateConnectorMixin<(StateResult, Tale)> {
  const TalepageTale({super.key});

  @override
  Widget builder(
    BuildContext context,
    Dispatcher<AppState> dispatch,
    (StateResult, Tale) model,
  ) {
    return model.$1.when(
      ok: () {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 32,
          children: [
            SizedBox(
              width: Sizes.kMaxWidth * .4,
              child: _Form(model.$2),
            ),
            SizedBox(
              width: Sizes.kMaxWidth * .4,
              child: _Metadata(tale: model.$2),
            ),
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

class _Form extends StatelessWidget with DispatchConnectorMixin {
  const _Form(this.tale);

  final Tale tale;

  @override
  Widget builder(BuildContext context, Dispatcher<AppState> dispatch) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 32),
      children: [
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
        _space(),
        TranslationSelector(
          label: 'Description',
          textKey: tale.description,
          onChanged: (value) {
            dispatch(UpdateTaleAction(description: value));
          },
        ),
        _space(),
        OrientationSelector(
          orientation: tale.orientation,
          onChanged: (value) {
            dispatch(UpdateTaleAction(orientation: value));
          },
        ),
        _space(),
        const ButtonComponent.destructive(
          text: 'Delete Tale',
          icon: Icons.delete_outline_rounded,
          // onPressed: () {
          //todo: show confirmation first
          // },
        ),
      ],
    );
  }
}

Widget _space([double height = 24]) {
  return SizedBox(height: height);
}

class _Metadata extends StatelessWidget with DispatchConnectorMixin {
  const _Metadata({
    required this.tale,
  });
  final Tale tale;

  @override
  Widget builder(BuildContext context, Dispatcher<AppState> dispatch) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        //image
        ImageSelectorComponent(
          title: 'Cover Image',
          imagePath: tale.metadata.coverImageUrl,
          size: const Size(260, 320),
          onImageSelected: (value) {
            dispatch(UpdateTaleAction(coverImageFile: value));
          },
        ),
        _space(16),
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
    );
  }
}
