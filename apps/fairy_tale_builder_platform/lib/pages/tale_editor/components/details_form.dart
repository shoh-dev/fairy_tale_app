import 'package:fairy_tale_builder_platform/components/orientation_selector.dart';
import 'package:fairy_tale_builder_platform/components/translation_selector.dart';
import 'package:fairy_tale_builder_platform/manager/redux/features/features.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:fairy_tale_builder_platform/manager/selector.dart';
import 'package:fairy_tale_builder_platform/pages/localization_settings/localization_settings_page.dart';
import 'package:fairy_tale_builder_platform/pages/tale_editor/components/audio_selector.dart';
import 'package:fairy_tale_builder_platform/pages/tale_editor/components/image_selector.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:shared/shared.dart';

class TaleDetailsForm extends StatelessWidget {
  const TaleDetailsForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StateConnector<AppState, Tale>(
      selector: selectedTaleSelector,
      builder: (context, dispatch, tale) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tale Details',
              style: context.textTheme.headlineSmall,
            ),
            space(8),
            Text(
              'ID: ${tale.id}',
              style: context.textTheme.titleMedium,
            ),
            space(16),
            TranslationSelector(
              label: 'Title',
              textKey: tale.title,
              isRequiredToSelect: true,
              onChanged: (value) {
                dispatch(UpdateTaleAction(title: value));
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
            Text(
              'Metadata',
              style: context.textTheme.headlineSmall,
            ),
            space(8),
            ImageSelectorComponent(
              title: 'Cover Image',
              imagePath: tale.coverImage,
              onImageSelected: (value) {
                dispatch(
                  UpdateTaleAction(coverImageFile: value),
                );
              },
            ),
            space(16),
            AudioSelectorComponent(
              title: 'Background Audio',
              audioPath: tale.metadata.backgroundAudioUrl,
              audioPlayer: tale.audioPlayerService,
              onAudioSelected: (value) {
                dispatch(
                  UpdateTaleAction(backgroundAudioFile: value),
                );
              },
            ),
          ],
        );
      },
    );
  }

  SizedBox space([num? space]) {
    return SizedBox(height: space?.toDouble() ?? 24);
  }
}
