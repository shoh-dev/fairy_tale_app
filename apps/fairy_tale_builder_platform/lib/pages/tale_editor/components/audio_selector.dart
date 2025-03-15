import 'dart:developer';

import 'package:fairy_tale_builder_platform/manager/redux.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:shared/shared.dart';

class AudioSelectorComponent extends StatelessWidget {
  const AudioSelectorComponent({
    required this.title,
    required this.audioPlayer,
    super.key,
    this.audioPath = '',
    this.onAudioSelected,
    this.onAudioRemoved,
  });

  final String audioPath;
  final ValueChanged<PlatformFile>? onAudioSelected;
  final String title;
  final AudioPlayerService audioPlayer;
  final VoidCallback? onAudioRemoved;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: context.textTheme.bodyMedium),
        if (audioPath.isNotEmpty)
          StreamBuilder(
            stream: audioPlayer.playerStateStream,
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                final isPlaying =
                    snapshot.data!.processingState == ProcessingState.ready &&
                        snapshot.data!.playing == true;
                final isBuffering =
                    snapshot.data!.processingState == ProcessingState.buffering;
                if (isBuffering) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
                if (isPlaying) {
                  return ButtonComponent.outlined(
                    text: 'Stop',
                    icon: Icons.stop_rounded,
                    onPressed: audioPlayer.stop,
                  );
                }
              }
              return ButtonComponent.outlined(
                text: 'Play',
                icon: Icons.play_arrow,
                onPressed: () {
                  audioPlayer.playFromUrl(audioPath);
                },
              );
            },
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
          icon: Icons.audiotrack_rounded,
          text: audioPath.isEmpty ? 'Select Audio' : 'Replace Audio',
        ),
        ButtonComponent.destructive(
          text: 'Remove Audio',
          icon: Icons.delete_rounded,
          onPressed: audioPath.isNotEmpty ? onAudioRemoved : null,
        ),
      ],
    );
  }
}
