import 'dart:developer';

import 'package:fairy_tale_builder_platform/manager/services/file_picker_service.dart';
import 'package:fairy_tale_builder_platform/utils/sizes.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
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
    final radius = context.borderRadius;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.bodyMedium,
        ),
        Container(
          width: Sizes.kMaxWidth * .5,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: radius,
          ),
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(top: 4),
          child: Row(
            spacing: 8,
            children: [
              StreamBuilder(
                stream: audioPlayer.playerStateStream,
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    final isPlaying = snapshot.data!.processingState ==
                            ProcessingState.ready &&
                        snapshot.data!.playing == true;
                    final isBuffering = snapshot.data!.processingState ==
                        ProcessingState.buffering;
                    if (isBuffering) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }
                    if (isPlaying) {
                      return ButtonComponent.iconOutlined(
                        icon: Icons.stop_rounded,
                        onPressed: audioPlayer.stop,
                      );
                    }
                  }
                  return ButtonComponent.iconOutlined(
                    icon: Icons.play_arrow,
                    onPressed: audioPath.isEmpty
                        ? null
                        : () {
                            audioPlayer.playFromUrl(audioPath);
                          },
                  );
                },
              ),
              Text(audioPath.isEmpty ? 'no audio selected' : audioPath),
              const Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ButtonComponent.primary(
                    onPressed: onAudioSelected == null
                        ? null
                        : () async {
                            const picker = FilePickerService();

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
                ],
              ),
              if (onAudioRemoved != null)
                ButtonComponent.iconDesctructive(
                  icon: Icons.delete_rounded,
                  onPressed: audioPath.isNotEmpty ? onAudioRemoved : null,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
