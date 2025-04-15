import 'package:flutter/material.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:myspace_ui/myspace_ui.dart';
import 'package:web/web.dart' as web;

class AudioPlayerWidget extends StatefulWidget {
  final String audioUrl;

  const AudioPlayerWidget({super.key, required this.audioUrl});

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  late final web.HTMLAudioElement _audio;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audio =
        web.HTMLAudioElement()
          ..src = widget.audioUrl
          ..preload = 'auto'
          ..onEnded.listen((_) {
            setState(() {
              _isPlaying = false;
            });
          });
  }

  void _togglePlayPause() {
    try {
      if (_isPlaying) {
        _audio.pause();
      } else {
        _audio.play();
      }
      setState(() {
        _isPlaying = !_isPlaying;
      });
    } catch (e) {
      ErrorDialog.show(e.toString());
    }
  }

  @override
  void dispose() {
    _audio.pause();
    _audio.removeAttribute('src'); // clean up
    _audio.load();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ButtonComponent.icon(
      icon: _isPlaying ? Icons.pause : Icons.play_arrow,
      onPressed: _togglePlayPause,
    );
  }
}
