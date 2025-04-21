import 'package:fairy_tale_mobile/components/icon_button.dart';
import 'package:flutter/material.dart';

class HomepageRightButtons extends StatelessWidget {
  const HomepageRightButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UIIconButton(
          onPressed: () {},
          icon: Icons.music_note_rounded,
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
        ),
      ],
    );
  }
}
