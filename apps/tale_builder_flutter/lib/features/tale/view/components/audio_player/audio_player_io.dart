import 'package:flutter/material.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

class AudioPlayerWidget extends StatelessWidget {
  const AudioPlayerWidget({super.key, required this.audioUrl});

  final String audioUrl;

  @override
  Widget build(BuildContext context) {
    return ButtonComponent.outlined(
      icon: Icons.play_arrow,
      text: "Only available to use on browser!",
    ).expanded();
  }
}
