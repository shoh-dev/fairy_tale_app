import 'dart:developer';

import 'package:fairy_tale_builder_platform/manager/redux.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

class AudioSelectorComponent extends StatelessWidget {
  const AudioSelectorComponent({
    required this.title,
    super.key,
    this.audioPath = '',
    this.onAudioSelected,
  });

  final String audioPath;
  final ValueChanged<PlatformFile>? onAudioSelected;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: context.textTheme.bodyMedium),
        if (audioPath.isNotEmpty)
          ButtonComponent.outlined(
            text: 'Play',
            icon: Icons.play_arrow,
            onPressed: () {}, //todo: handle play audio
          ),
        ButtonComponent.primary(
          onPressed: onAudioSelected == null
              ? null
              : () async {
                  final picker = context
                      .getDependency<DependencyInjection>()
                      .filePickerService;

                  final result = await picker.pickAudioFile();

                  result.when(
                    ok: (file) {
                      if (file == null) {
                        return;
                      }

                      onAudioSelected!(file);
                    },
                    error: (e) {
                      //todo: show error
                      log(e.toString());
                    },
                  );
                },
          icon: Icons.image_rounded,
          text: audioPath.isEmpty ? 'Select Audio' : 'Replace Audio',
        ),
      ],
    );
  }
}
